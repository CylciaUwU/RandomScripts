repeat task.wait() until game:IsLoaded()

if shared.settings then return end

shared.settings = {
    AutoSellWhenMax = false,
    AutoSell = true,
    KillFarmer = true,
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
local VirtualInputManager = game:GetService("VirtualInputManager")

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

	local Root = getchar(nil,true).HumanoidRootPart

    firetouchinterest(Root, Part, 0)
    firetouchinterest(Root, Part, 1)
end
local function GetSellWhenMaxCap()
    local Char = getchar()
    local Crate = Char:FindFirstChild("Crate");
    local AnchorPoint = Crate["AnchorPoint"]
    local Capacity = Crate["MaxCapacity"].Value;

    --// TODO use forloop :c

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

        if shared.settings.IsFarmerNil then
            if shared.settings.AutoSell and not shared.settings.AutoSellWhenMax then
                FireTouchPart(game:GetService("Workspace").Interactions.Sell)
            end

            if shared.settings.AutoSellWhenMax and not shared.settings.AutoSell then
                task.spawn(GetSellWhenMaxCap)
            end

            if shared.settings.AutoCollect.Plants then
                local MainPlants = GetRandomPlants()
                if not MainPlants then return end
                Teleport(MainPlants:GetModelCFrame())
            end

            if shared.settings.AutoCollect.Plants then
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                -- Heartbeat:Wait()
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
            end
        end

    end)
    Heartbeat:Wait()
end)
