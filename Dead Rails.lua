-- kys. fuck this game

-- local Players = game:GetService("Players")
--[[//TODO List:--//
Added store or bring item
Added Notification when something is spawned (unicorn,outlaw) or added highlight
]]--

local Collection = {} ; Collection.__index = Collection

loadstring(game:HttpGetAsync("https://gist.githubusercontent.com/CylciaUwU/7f03f50246fe82fb76158c7e4dadd849/raw/20d769e5d364e97373cc7f3ccc5d3bbc7d8de0ec/top_secret_function_variable.luau"))()

local LocalPlayer = Players.LocalPlayer

local Notify = loadstring(game:HttpGet(('https://raw.githubusercontent.com/treeofplant/Notif/main/library.lua'),true))()

local function Notifi(types,Title,Description,Timeout) -- Success/Custom/Info/Error
       Notify:NewNotification({
        ["Mode"] = types,
        ["Title"] = Title,
        ["Description"] = Description,
        ["Timeout"] = Timeout,
        ["Audio"] = false
    }) 
end

function Collection:GetChar()
    return Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
end
function Collection:GetHumanoid()
    return Collection:GetChar():FindFirstChildOfClass("Humanoid")
end
function Collection:GetRootPart()
    return Collection:GetChar():FindFirstChild("HumanoidRootPart")
end
function Collection:Teleport(_CFRAME_)
    local RootPart = Collection:GetRootPart()
    -- RootPart:PivotTo(_CFRAME_)
    RootPart.CFrame = _CFRAME_
end
function Collection:GetStatePlayers()
    return Collection:GetHumanoid():GetState()
end
function Collection:SetPlayerState(HumanoidStateType)
    local args = nil
    if not HumanoidStateType then return else args = {HumanoidStateType};end

    local success,failed = pcall(function()
        Collection:GetHumanoid():ChangeState(unpack(args))
    end)
end
function Collection:IsLocalPlayerDead()
    if Collection:GetStatePlayers() == Enum.HumanoidStateType.Dead then
        return true
    else
        return false
    end
end
function Collection:EquipTool(ToolName)
    local Humanoid = Collection:GetHumanoid()
    local Tool = LocalPlayer.Backpack:FindFirstChild(ToolName)
    if not Tool then return end

    return Humanoid:EquipTool(Tool)
end

local IsSitting = Collection:GetStatePlayers() == Enum.HumanoidStateType.Seated
local IsHrpAnchored = Collection:GetRootPart().Anchored == true

function Collection:CoverGetClosestSeat(realpath)
    local ClosestSeat = nil
    local ShortestDistance = math.huge

    local char = Collection:GetChar();
    local plrpos = Collection:GetRootPart().Position
    if realpath ~= nil then
        for _,v in ipairs(realpath:GetDescendants()) do
            if v:IsA("VehicleSeat") then
                local distance = (v.Position - plrpos).Magnitude;
                if distance < ShortestDistance then
                    ShortestDistance = distance
                    ClosestSeat = v
                end
            end
        end
    end
    return ClosestSeat
end
local function unfreeze()
    task.spawn(function()
        for i, x in next, LocalPlayer.Character:GetDescendants() do
            if x:IsA("BasePart") and x.Anchored then
                x.Anchored = false
            end
        end
    end)
end
function Collection:ATeleport(method)
    if not CFrame then return end

    local char = Collection:GetChar();
    local hrp = Collection:GetRootPart();
    local hum = Collection:GetHumanoid();

    if char and hrp and hum then -- don't judge me
        if IsSitting then
            repeat wait()
                Collection:SetPlayerState(Enum.HumanoidStateType.Jumping) ; Notifi("Error","Status","Click Teleport Again",7)
            until hum.Sit == false or getgenv().Stop
        else
            if not IsHrpAnchored then
                hrp.Anchored = true ; Notifi("Info","Status","freezing player",3)
            end
            if method == "End" then
                CFrame,path=CFrame.new(-378, 11, -48889),workspace["Baseplates"]; Notifi("Info","Status","Teleporting",3)
                Collection:Teleport(CFrame);task.wait(3)
                local closest = Collection:CoverGetClosestSeat(path)
                if closest then
                    Collection:Teleport(closest.CFrame);task.wait(8)
                    unfreeze();Notifi("Info","Status","unfreezing player",3)
                end
            elseif method == "Castle" then
                CFrame,path=CFrame.new(-159, 38, -9749),workspace.RuntimeItems;
                if not workspace:FindFirstChild("VampireCastle") then
                    Collection:Teleport(CFrame);task.wait(3) 
                end
                local closest = Collection:CoverGetClosestSeat(path); closest.Disabled = false
                if closest then
                    Collection:Teleport(closest.CFrame);task.wait(3)
                    unfreeze();Notifi("Info","Status","unfreezing player",3)
                end
            end
        end
    end
end

-- Collection:ATeleport("Castle")
