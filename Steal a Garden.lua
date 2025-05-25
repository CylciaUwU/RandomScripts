repeat task.wait() until game:IsLoaded()

if shared.settings then table.clear(shared.settings) end -- clear table

shared.settings = {
    -- AutoSellWhenMax = false,
    AutoSell = true,
    KillFarmer = false,
    InstPrompt  = true,
    IsFarmerNil = nil,
    Delete_Coin = true,

    AutoCollect = {
        Plants = true
    }
}

-- Luraph
LPH_NO_VIRTUALIZE = (function(...) return ... end)

local isDebug = false
isDebug = true
local debugprint, debugwarn
do
	local p,w = print,warn
	debugprint = function(...)
		return isDebug and p("[DEBUG]",...)
	end
	debugwarn = function(...)
		return isDebug and w("[DEBUG]",...)
	end
end

--// Service
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
local Heartbeat = RunService["Heartbeat"]
local Stepped = RunService["Stepped"]
local VirtualInputManager = game:GetService("VirtualInputManager")

if getgenv().VelocityP then
    getgenv().VelocityP:Disconnect()
    getgenv().VelocityP = nil
end

spawn(function()
    local Store_Vc = Instance.new("Folder", game:GetService("Lighting"));Store_Vc.Name = game:GetService("HttpService"):GenerateGUID(false)
    local Vcit = Instance.new("BodyVelocity", Store_Vc);Vcit.Name = game:GetService("HttpService"):GenerateGUID(false)
    Vcit.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    Vcit.Velocity = Vector3.zero
    local copiesvc = Vcit:Clone();warn("Clone", copiesvc:GetFullName(), "From", Vcit:GetFullName())
    local toUndo = {}
    getgenv().VelocityP = Stepped:Connect(function()
        pcall(function()
            local localChar = game.Players.LocalPlayer.Character or game.Players.CharacterAdded:Wait()
            local hrp = localChar:FindFirstChild("HumanoidRootPart")
            local humnH = localChar:FindFirstChild("Humanoid")
            local getStateHumanoid = humnH:GetState()
            
            if shared.settings.AutoCollect
            then
                if hrp and localChar then
                    if hrp.Anchored then
                        hrp.Anchored = false;warn("Anchored(Hrp)", hrp:GetFullName(), "SetTo",hrp.Anchored)
                    else
                        if (getStateHumanoid == Enum.HumanoidStateType.Seated) or humnH.Sit then
                            humnH.Sit = false;warn("Humanoid(Sit)", humnH:GetFullName(), "SetTo",humnH.Sit)
                        else
                            if not hrp:FindFirstChild(tostring(copiesvc.Name)) then
                                local new_vc = copiesvc:Clone()
                                new_vc.Parent = hrp
                            else
                                if humnH.AutoRotate then
                                    humnH.AutoRotate = false;warn("Humanoid(AutoRotate)",humnH:GetFullName(),"SetTo",humnH.AutoRotate)
                                else
                                    if getStateHumanoid ~= Enum.HumanoidStateType.StrafingNoPhysics then
                                        humnH:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
                                        humnH:SetStateEnabled(Enum.HumanoidStateType.Running, false)
                                        humnH:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
                                        humnH:ChangeState(Enum.HumanoidStateType.StrafingNoPhysics)
                                    end
                                    game.Players.LocalPlayer.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
                                    for i,v in pairs(localChar:GetDescendants()) do
                                        if v:IsA("BasePart") and v.CanCollide then
                                            v.CanCollide = false
                                            toUndo[v] = true
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else
                game.Players.LocalPlayer.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Zoom
                humnH:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
                humnH:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                humnH:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
                hrp:FindFirstChild(tostring(copiesvc.Name)):Destroy()
                humnH.AutoRotate = true
                humnH:ChangeState(Enum.HumanoidStateType.None)
                for i,v in pairs(toUndo) do
                    toUndo[i] = nil
                    i.CanCollide = true
                end
            end
        end)
    end)
end)

local Modules = {}
Modules.__index = Modules;

function Modules:getchar(plr,yield)
    local plr = plr or LocalPlayer
    return plr.Character or yield and plr.CharacterAdded:Wait()
end
function Modules:Teleport(CFrame: CFrame)
    local Char = self:getchar()
    return Char:PivotTo(CFrame)
end

function Modules:FireTouchPart(Part: BasePart)
	local TouchTransmitter = Part:FindFirstChildOfClass("TouchTransmitter")
	if not TouchTransmitter then return end

	local Root = self:getchar().HumanoidRootPart

    firetouchinterest(Root, Part, 0)
    firetouchinterest(Root, Part, 1)
end
-- unused function
-- local function GetSellWhenMaxCap()
--     --// TODO use pairs to get better performance :c
--     if LocalPlayer.Character:FindFirstChild("Crate") then
--         for _,v in ipairs(LocalPlayer.Character:FindFirstChild("Crate"):GetChildren()) do
--             local AnchorPoint = v:FindFirstChild("AnchorPoint");
--             local GetCapText = AnchorPoint["CapacityBillboard"];
--             local Capacity = AnchorPoint["MaxCapacity"].Value;
--             for _,x in ipairs(GetCapText:GetDescendants()) do
--                 if x:IsA("BillboardGui") then
--                     if x.Name == "CapacityText" then
--                         local GetCapText = x.Text;
--                         local getHalfText = string.split(GetCapText,"/");
--                         local GetMaxCap = tonumber(getHalfText[1]);
--                         local GetMaxCap2 = tonumber(getHalfText[2]);
--                         if GetMaxCap >= GetMaxCap2 then
--                             return FireTouchPart(game:GetService("Workspace").Interactions.Sell)
--                         end
--                     end
--                 end
--             end
--         end
--     end
-- end
function Modules:GetRandomPlants()
    local Plants
    for i,v in ipairs(workspace.Plants:GetChildren()) do
        if v:IsA("Model") then
            Plants = v -- or return v.Name
            break -- return one plant per call func
        end
    end
    return Plants
end

if CoreLooper then
    CoreLooper:Disconnect()
    CoreLooper = nil
end

local PromptButtonHoldBegan = nil
spawn(function()
    if shared.settings.InstPrompt then
        PromptButtonHoldBegan = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
			fireproximityprompt(prompt)
		end)
    else
        PromptButtonHoldBegan:Disconnect()
        PromptButtonHoldBegan = nil
    end
end)

task.spawn(function()
    local sL,Fs = pcall(loadstring([[
            lp.PlayerScripts.Coins.Enabled = false
            for i,v in ipairs(game:GetService("ReplicatedStorage")["Assets"]:GetChildren()) do
                -- if v:find(v.Name:lower(),"coin") then
                if string.find(v.Name:lower(),"coin") then
                    v:Destroy()
                end
            end
    ]]))()
    assert(sL,debugprint("Destroy All Coins"))
end)

getgenv().CoreLooper = Heartbeat:Connect(function() -- Fires every frame
    pcall(function()
        if shared.settings.KillFarmer then
            local Farmer = game:GetService("Workspace"):FindFirstChild("Farmer")
            local HrpFarmer = Farmer:FindFirstChild("HumanoidRootPart")
            local HumnoidFarmer = Farmer:FindFirstChildWhichIsA("Humanoid")
            local Animator = HumnoidFarmer:FindFirstChildWhichIsA("Animator")

            if HumnoidFarmer.PlatformStand ~= true then
                HumnoidFarmer.PlatformStand = true
                -- sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
            end
            HumnoidFarmer:RemoveAccessories()
            if Animator then
                Animator:Destroy()
            end
            if HrpFarmer and HumnoidFarmer then
                for _,v in ipairs(Farmer:GetChildren()) do
                    if v:IsA("Part") then
                        v.CanCollide = false
                    end
                end
            else
                debugwarn("Not Found HumanoidRootPart's Farmer.")
                shared.settings.KillFarmer = false
                shared.settings.IsFarmerNil = true
            end
        end

        if shared.settings.Delete_Coin then
            for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BillboardGui") then
                    if v.Enabled then
                        v.Enabled = false
                    end
                end
            end
        end

        if shared.settings.AutoSell then
            Modules:FireTouchPart(game:GetService("Workspace").Interactions.Sell)
        end

        if shared.settings.AutoCollect.Plants then
            local MainPlants = Modules:GetRandomPlants()
            if not MainPlants then return end
            Modules:Teleport(MainPlants:GetModelCFrame() * CFrame.new(0,-4,0))
        end

        if shared.settings.AutoCollect.Plants then
            --// TODO use fireproximityprompt >^<
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        end

    end)
    Heartbeat:Wait()
end)

LPH_NO_VIRTUALIZE(function()
	task.spawn(function()
		while task.wait() do
			if setscriptable then
				setscriptable(LocalPlayer, "SimulationRadius", true)
			end
			if sethiddenproperty then
                LocalPlayer.setsimulationradius(math.huge)
				sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                sethiddenproperty(LocalPlayer, "MaxSimulationRadius", math.huge)
            else
                LocalPlayer.setsimulationradius(math.huge);
                LocalPlayer.MaxSimulationRadius = math.huge;
                LocalPlayer.SimulationRadius = math.huge;
			end
		end
	end)
end)()
