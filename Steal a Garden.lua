repeat task.wait() until game:IsLoaded()

if shared.settings then return end

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

local lp = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
local Heartbeat = RunService["Heartbeat"]
local Stepped = RunService["Stepped"]
local VirtualInputManager = game:GetService("VirtualInputManager")

task.spawn(function()
    local Store_Vc = Instance.new("Folder", game:GetService("Lighting"));Store_Vc.Name = game:GetService("HttpService"):GenerateGUID(false) -- create a folder to store vc
    local Vcit = Instance.new("BodyVelocity", Store_Vc);Vcit.Name = game:GetService("HttpService"):GenerateGUID(false)
    Vcit.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    Vcit.Velocity = Vector3.zero
    local copiesvc = Vcit:Clone();warn("Clone", copiesvc:GetFullName(), "From", Vcit:GetFullName())
    local toUndo = {}
    Stepped:Connect(function()
        pcall(function()
            local localChar = game.Players.LocalPlayer.Character or game.Players.CharacterAdded:Wait()
            local hrp = localChar:FindFirstChild("HumanoidRootPart")
            local humnH = localChar:FindFirstChild("Humanoid")
            local getStateHumanoid = humnH:GetState()
            
            if shared.settings.AutoCollect
            then
                if hrp and localChar then
                    if hrp.Anchored then
                        hrp.Anchored = false;warn("Anchored(Hrp)",hrp:GetFullName(),"SetTo",hrp.Anchored)
                    else
                        if (getStateHumanoid == Enum.HumanoidStateType.Seated) or humnH.Sit then
                            humnH.Sit = false;warn("Humanoid(Sit)",humnH:GetFullName(),"SetTo",humnH.Sit)
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

local function getchar(plr,yield)
    local plr = plr or lp
    return plr.Character or yield and plr.CharacterAdded:Wait()
end
local function Teleport(CFrame: CFrame)
    local Char = getchar()
    return Char:PivotTo(CFrame)
end

local function FireTouchPart(Part: BasePart)
	local TouchTransmitter = Part:FindFirstChildOfClass("TouchTransmitter")
	if not TouchTransmitter then return end

	local Root = getchar().HumanoidRootPart

    firetouchinterest(Root, Part, 0)
    firetouchinterest(Root, Part, 1)
end
local function GetSellWhenMaxCap()
    local Char = getchar()
    local Crate = Char:FindFirstChild("Crate");
    local AnchorPoint = Crate["AnchorPoint"]
    local Capacity = Crate["MaxCapacity"].Value;

    --// TODO use pairs to get better performance :c

    local GetCapText = AnchorPoint["CapacityBillboard"]["CapacityText"].Text
    local getHalfText = string.split(GetCapText,"/")
     local getTextCapMax = tonumber(getHalfText[1])
    local getTextCapMax2 = tonumber(getHalfText[2])

    if getTextCapMax >= getTextCapMax2 then
        FireTouchPart(game:GetService("Workspace").Interactions.Sell)
    end
end
local function GetRandomPlants()
    local Plants
    for i,v in ipairs(workspace.Plants:GetChildren()) do
        if v:IsA("Model") then
            Plants = v
            break -- return one plant per call func
        end
    end
    return Plants
end

if CoreLooper then
    CoreLooper:Disconnect()
    CoreLooper = nil
end

if PromptButtonHoldBegan ~= nil then
    PromptButtonHoldBegan:Disconnect()
    PromptButtonHoldBegan = nil
end

local PromptButtonHoldBegan = nil
spawn(function()
    if shared.settings.InstPrompt then
        PromptButtonHoldBegan = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
			fireproximityprompt(prompt)
		end)
    end
end)

task.spawn(function()
    local _s,_f = pcall(function()
        loadstring([[
            game:GetService("Players").LocalPlayer.PlayerScripts.Coins.Enabled = false
            game:GetService("ReplicatedStorage").Assets:FindFirstChild("Coins"):Destroy()
            game:GetService("ReplicatedStorage").Assets:FindFirstChild("Coin"):Destroy()
        ]])()
    end)
    assert(_s,debugprint("Destroy All Coins"))
end)

local CoreLooper = getgenv().CoreLooper
CoreLooper = Heartbeat:Connect(function()
    pcall(function()

        if shared.settings.KillFarmer then
            local Farmer = game:GetService("Workspace"):FindFirstChild("Farmer")
            local HrpFarmer = Farmer:FindFirstChild("HumanoidRootPart")
            local HumnoidFarmer = Farmer:FindFirstChildWhichIsA("Humanoid")
            local Animator = HumnoidFarmer:FindFirstChildWhichIsA("Animator")

            if HumnoidFarmer.PlatformStand ~= true then
                HumnoidFarmer.PlatformStand = true
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
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
                shared.settings.KillFarmer = false
                shared.settings.IsFarmerNil = true
                debugwarn("HumanoidRootPart's Farmer is nil, Set KillFarmer To:" .. shared.settings.KillFarmer)
            end
        end

        if shared.settings.Delete_Coin then
            for _,v in pairs(lp.Character:GetDescendants()) do
                if v:IsA("BillboardGui") then
                    if v.Enabled then
                        v.Enabled = false
                    end
                end
            end
        end

        if shared.settings.AutoSell and not shared.settings.AutoSellWhenMax then
            FireTouchPart(game:GetService("Workspace").Interactions.Sell)
        end

        -- if shared.settings.AutoSellWhenMax and not shared.settings.AutoSell then
        --     task.spawn(GetSellWhenMaxCap)
        -- end

        if shared.settings.AutoCollect.Plants then
            local MainPlants = GetRandomPlants()
            if not MainPlants then return end
            Teleport(MainPlants:GetModelCFrame() * CFrame.new(0,-4,0))
        end

        if shared.settings.AutoCollect.Plants then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            -- Heartbeat:Wait()
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        end

    end)
    Heartbeat:Wait()
end)
