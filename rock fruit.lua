local LoadingTime = tick()
if Sylvia then return warn("Sylvia: Already executed!") end
getgenv().Sylvia = true

local _TrashTable = {};
_TrashTable.__index = _TrashTable;

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser");
local VirtualInputManager = game:GetService("VirtualInputManager");
assert(require,loadstring([[
    game.Players.LocalPlayer:Kick("require func is broken")
]]))()
local SummonInfo = require(ReplicatedStorage.Modules.SummonInfo)
local LocalPlayer = Players.LocalPlayer

local Megumint = {};
Megumint.__index = Megumint;

local e = request or http_request
local a = e({
    Url = "https://gist.githubusercontent.com/CylciaUwU/30e45e7afd055ddbe643d7571b0d7850/raw/ca58f241c0aade24e298f763792647b48b1f0120/Repetator.luau",
    Method = "GET"
})
if a.StatusCode == 200 then
    Megumint.MainThread = loadstring(a.Body)()
else
    return ("Repetator Not Found")
end

local Megumint = Megumint.MainThread.new()

function _TrashTable:getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end
function _TrashTable:getRootPart()
    return self:getCharacter():FindFirstChild("HumanoidRootPart")
end
function _TrashTable:getHumanoid()
    return self:getCharacter():FindFirstChild("Humanoid")
end
function _TrashTable:getState()
    return self:getHumanoid():GetState()
end
function _TrashTable:isDead()
    return self:getState() == Enum.HumanoidStateType.Dead
end
function _TrashTable:changeState(...)
    local args = {...}
    local success, err = pcall(function()
        self:getHumanoid():ChangeState(args[1])
        -- sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
    end)

    if not success then
        warn("Failed to change state:", err)
    end
end
function _TrashTable:Teleport(CFrame : CFrame)
    local Char = self:getCharacter()
    Char:PivotTo(CFrame)
end

-- local run = function(func) func() end

local random = math.random;
local char = string.char;

local function RandomCharacters(length)
    local charset = {}
    for i = 48, 57 do table.insert(charset, char(i)) end   -- 0-9
    for i = 65, 90 do table.insert(charset, char(i)) end   -- A-Z
    for i = 97, 122 do table.insert(charset, char(i)) end  -- a-z

    local result = ""
    for i = 1, length do
        result = result .. charset[random(1, #charset)]
    end
    return result
end

if not getgenv().antiafk then
    spawn(function()
        local getconnect = getconnections or get_signal_cons
        if getconnect then
            for i,v in pairs(getconnect(LocalPlayer.Idled)) do
                if v["Disable"] then
                    v["Disable"](v)
                elseif v["Disconnect"] then
                    v["Disconnect"](v)
                end
            end
        else
            LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:Button2Down(Vector2.new(0,0),game:GetService("Workspace").Camera.CFrame)
                wait(1)
                VirtualUser:Button2Up(Vector2.new(0,0),game:GetService("Workspace").Camera.CFrame)
            end)
        end
    end)
end

getgenv().antiafk = true;
if getgenv().globalstop then getgenv().globalstop = false end;
if getgenv().Disconnect or getgenv().Disconnect == true then getgenv().Disconnect = false end;

local MainCCs, OldCcs = {}, {}
local vcName = RandomCharacters(36,72)
local VelocityCon

spawn(function()
    VelocityCon = RunService.Stepped:Connect(function()
        if getgenv().Disconnect and VelocityCon then
            VelocityCon:Disconnect()
            VelocityCon = nil
            print("Velocity disconnected")
            LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
            return
        end
        pcall(function()
            local humanoid = _TrashTable:getHumanoid()
            local rootPart = _TrashTable:getRootPart()
            local currentState = _TrashTable:getState()
            local isSitting = currentState == Enum.HumanoidStateType.Seated
            if AutoFarmMon or AutoFarmMon2 or AutoBoss or _Auto_Chest
            then
                if isSitting and humanoid.Health > 0 then
                    humanoid.Sit = false
                    local BV = rootPart:FindFirstChild(vcName)
                    if BV then BV:Destroy() end
                end
                if not _TrashTable:isDead() then
                    _TrashTable:changeState(Enum.HumanoidStateType.StrafingNoPhysics)
                end
                if rootPart.Anchored then rootPart.Anchored = false end
                if not humanoid.AutoRotate then humanoid.AutoRotate = true end
                if LocalPlayer.PlayerGui:FindFirstChild("HUD") then LocalPlayer.PlayerGui.HUD.Enabled = true end
                if LocalPlayer.PlayerGui:FindFirstChild("Shiftlock") then LocalPlayer.PlayerGui.Shiftlock.Enabled = true end
                LocalPlayer.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
                if not isSitting and humanoid.Health > 0 or _TrashTable:isDead() then
                    for _, part in ipairs(_TrashTable:getCharacter():GetChildren()) do
                        if part:IsA("BasePart") then
                            if MainCCs[part] == nil then
                                MainCCs[part] = part.CanCollide
                                OldCcs[part] = part.CanCollide
                            end
                            if MainCCs[part] ~= false then
                                if AutoFarmMon or AutoFarmMon2 or AutoBoss then
                                    part.CanCollide = false
                                else
                                    part.CanCollide = OldCcs[part]
                                end
                            end
                        end
                    end
                else
                    humanoid.Sit = false
                end
                if not rootPart:FindFirstChild(vcName) and not isSitting then
                    local bv = Instance.new("BodyVelocity", rootPart)
                    bv.Name = vcName
                    bv.MaxForce = Vector3.new(math.random(math.random(math.random(math.huge))), math.huge, math.random(math.random(math.random(math.huge))))
                    bv.Velocity = Vector3.zero
                end
            else
                LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
                local BV = rootPart:FindFirstChild(vcName)
                if BV then BV:Destroy() end
                _TrashTable:changeState(Enum.HumanoidStateType.None)
            end
        end)
    end)
end)
ToRotate = nil
spawn(function()
    while task.wait() do
        if getgenv().Disconnect then break end
        ToRotate = random(1,6)
        task.wait(.5)
    end
end)

local _TrashLPTable = {}
_TrashLPTable.__index = _TrashLPTable

function _TrashLPTable:RandomRotateReal()
    if ToRotate == 1 then
        getgenv().Rotate = CFrame.new(0,DistanceFarms,0) * CFrame.Angles(math.rad(-90), 0, 0)
    elseif ToRotate == 2 then
        getgenv().Rotate = CFrame.new(0,0,DistanceFarms) * CFrame.Angles(0, math.rad(0), 0)
    elseif ToRotate == 3 then
        getgenv().Rotate = CFrame.new(0,0,-DistanceFarms) * CFrame.Angles(0, math.rad(180), 0)
    elseif ToRotate == 4 then
        getgenv().Rotate = CFrame.new(0,-DistanceFarms,0) * CFrame.Angles(math.rad(90), 0, 0)
    elseif ToRotate == 5 then
        getgenv().Rotate = CFrame.new(-DistanceFarms,0,0) * CFrame.Angles(0, math.rad(-90), 0)
    elseif ToRotate == 6 then
        getgenv().Rotate = CFrame.new(DistanceFarms,0,0) * CFrame.Angles(0, math.rad(90), 0)
    else
        getgenv().Rotate = CFrame.new(0,DistanceFarms,0) * CFrame.Angles(math.rad(-90), 0, 0)
    end
end
function _TrashLPTable:InBackpackItems()
    local item
    for _,v in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v:GetAttribute("Type") == "Items" then
            item = v
            break
        end
    end
    return item
end
function _TrashLPTable:getTypeTool(Attribute)
    local willreturnnametool
    for _,v in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v:GetAttribute("Type") == Attribute then
            willreturnnametool = v.Name
            break
        end
    end
    for _,v in ipairs(LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and v:GetAttribute("Type") == Attribute then
            willreturnnametool = v.Name
            break
        end
    end
    return willreturnnametool
end
function _TrashLPTable:getTool(Values)
    local Attribute = Values
    local Weapon = self:getTypeTool(Attribute)
    local Tool
    task.spawn(function()
        if Weapon then
            for _,v in ipairs(LocalPlayer.Backpack:GetChildren()) do
                if v:IsA("Tool") and v.Name == Weapon then
                    Tool = v.Name
                    break
                end
            end
            for _,v in ipairs(_TrashTable:getCharacter():GetChildren()) do
                if v:IsA("Tool") and v.Name == Weapon then
                    Tool = v.Name
                    break
                end
            end
        end
    end)
    return Tool
end
function _TrashLPTable:EquipTools(Value)
    local getName = self:getTool(Value)
    local WhereIs = LocalPlayer.Backpack:FindFirstChild(getName) or _TrashTable:getCharacter():FindFirstChild(getName)
    local InBackpack = WhereIs.Parent == LocalPlayer.Backpack
    local InCharacter = WhereIs.Parent == _TrashTable:getCharacter()
    if WhereIs and _TrashTable:getCharacter() and not _TrashTable:isDead() then
        if InCharacter then
            WhereIs:Activate()
        elseif InBackpack then
            _TrashTable:getHumanoid():EquipTool(WhereIs)
        end
    end
end
function _TrashLPTable:IsItem()
    local target
    for _,v in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v:GetAttribute("Type") == "Items" then
            target = v
            break
        end
    end
    return target
end
function _TrashLPTable:AutoEquip(Value)
    local Success , err = pcall(function()
        self:EquipTools(Value)
    end)
    if err then
        return ("Failed to Equip:"..err)
    end
end

local Fluent
Fluent = loadstring(game:HttpGet("https://gist.githubusercontent.com/CylciaUwU/4ce60ba116cb52855f282a7f50b1866b/raw/864c18d9319cde98eac7a570cbcef1df857fe217/Fluent_Edited.luau"))();
SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Options = Fluent.Options

local Window = Fluent:CreateWindow({
    Title = "Rock Fruit",
    SubTitle = "By Sylvia",
    TabWidth = 160,
    Size =  UDim2.fromOffset(580, 460),
    Acrylic = false, 
    Theme = "Darker",
    Transparency = false,
    MinimizeKey = Enum.KeyCode.RightShift,
})

local Tap = {
    General = Window:AddTab({Title = "Main", Icon = "component"}),
    Island = Window:AddTab({Title = "Teleport", Icon = "codepen"}),
    Boss = Window:AddTab({Title = "Boss", Icon = "swords"}),
    Settings = Window:AddTab({Title = "Settings", Icon = "settings"}),
}

local All_NPC_MONSTER = loadstring(game:HttpGet("https://raw.githubusercontent.com/CylciaUwU/RandomScripts/main/_Rock_Fruit_All_Npc.lua"))() ; warn("Loaded NPC World1")
local World2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/CylciaUwU/RandomScripts/raw/main/_ROCK_FRUIT_WORLD2NPC.lua"))() ; warn("Loaded NPC World2")
local NPC_Storage, NPC_Storage_World2, LocalAccessories = {}, {}, {}

spawn(function()
    for _,v in ipairs(All_NPC_MONSTER) do
        table.insert(NPC_Storage,v)
    end
    for _,v in ipairs(World2) do
        table.insert(NPC_Storage_World2,v)
    end
end)

Main = Tap.General:AddSection('Main'); do
    local _SelectWeapon = Main:AddDropdown("Dropdown", {
        Title = "Select Weapon",
        Values = {"Melee", "Sword","Special"},
        Multi = false,
        Default = 1,
    })
    _SelectWeapon:SetValue("Sword")
    _SelectWeapon:OnChanged(function(v)
        SelectWeapon = v
    end)
    if game.PlaceId == 95295765150201 then
        local SelectMonFram = Main:AddDropdown("Dropdown", {
            Title = "Select NPC Farm(World 1)",
            Values = NPC_Storage,
            Multi = false,
            Default = 1,
        })
        SelectMonFram:OnChanged(function(v)
            SelectMonFramWorld1 = v
        end)
    elseif game.PlaceId == 72064813230771 then
        local SelectMonFram2 = Main:AddDropdown("Dropdown", {
            Title = "Select NPC Farm(World 2)",
            Values = NPC_Storage_World2,
            Multi = false,
            Default = 1,
        })
        SelectMonFram2:OnChanged(function(v)
            SelectMonFramWorld2 = v
        end)
    end
    if game.PlaceId == 95295765150201 then
        local AutoFarm = Main:AddToggle("", {Title = "Auto Farm", Description = "Will improved next update. uwu" ,Default = false})
        AutoFarm:OnChanged(function(v)
            AutoFarmMon = v
        end)
    elseif game.PlaceId == 72064813230771 then
        local AutoFarm2 = Main:AddToggle("", {Title = "Auto Farm(World2)", Description = "Will improved next update. uwu" ,Default = false})
        AutoFarm2:OnChanged(function(v)
            AutoFarmMon2 = v
        end)
    end
    local DistanceFarm = Main:AddSlider("Distance_Auto_Farm", {
        Title = "Distance Farm",
        Description = "",
        Default = 14,
        Min = 0,
        Max = 100,
        Rounding = 1,
        Callback = function(v)
            DistanceFarms = v
        end
    })
    DistanceFarm:OnChanged(function(v)
        DistanceFarms = v
    end)
    DistanceFarm:SetValue(14)
    local HakiToggles = Main:AddToggle("", {Title = "Haki", Description = "No need to purchase haki" ,Default = true})
    HakiToggles:OnChanged(function(v)
        AutoHaki = v
    end)
    local AccessoriesList = Main:AddDropdown("Dropdown", {
        Title = "Select Accessories",
        Values = LocalAccessories,
        Multi = false,
        Default = 1,
    })
    AccessoriesList:OnChanged(function(v)
        SelectAccessories = v
    end)
    local AutoAccessories = Main:AddToggle("", {Title = "Accessories", Description = "" ,Default = true})
    AutoAccessories:OnChanged(function(v)
        AutoEquipAccessories = v
    end)
    local RemoveEffects = Main:AddToggle("", {Title = "Remove Effects", Description = "" ,Default = true})
    RemoveEffects:OnChanged(function(v)
        _RemoveEffects = v
    end)
    local MethodFarm = Main:AddDropdown("Dropdown", {
        Title = "Select Farm Method",
        Values = {"Above","Behind","Front","Below","RandomRotate"},
        Multi = false,
        Default = 1,
    })
    MethodFarm:SetValue("Above")
    MethodFarm:OnChanged(function(v)
        MethodFarms = v
    end)
    Main:AddButton({
        Title = "Teleport to Chest",
        Description = "",
        Callback = function()
            pcall(function()
                for _,v in ipairs(workspace.MobSpawnGroup:GetDescendants()) do
                    if v:FindFirstChild("ChestRef") then
                        _TrashTable:Teleport(v.CFrame)
                    end
                end
            end)
        end
    })
    if replicatesignal and firesignal then
        local AutoStoreItem = Main:AddToggle("", {Title = "Auto Store", Description = "Store any type of items." ,Default = false})
        AutoStoreItem:OnChanged(function(v)
            AutoStores = v
        end)
    else
        local AutoStoreItem_NonSupportReplisingal = Main:AddToggle("", {Title = "Auto Store", Description = "Your exploit doesn't support this function. " ,Default = false})
        AutoStoreItem_NonSupportReplisingal:OnChanged(function(v)
            AutoStores_NonSignal = v
        end)
    end
    local EnableAutoSkill = Main:AddToggle("", {Title = "Toggle Auto Skill", Description = "" ,Default = false})
    EnableAutoSkill:OnChanged(function(v)
        EnableAutoSkills = v
    end)
    local delayskill = Main:AddSlider("delayskill", {
        Title = "Delay Skill",
        Description = "",
        Default = 0,
        Min = 0,
        Max = 10,
        Rounding = 1,
        Callback = function(v)
            delayskilltime = v
        end
    })
    delayskill:OnChanged(function(v)
        delayskilltime = v
    end)
    delayskill:SetValue(0)
    local AutoSkill = Main:AddDropdown("Dropdown", {
        Title = "Select Skill",
        Values = {"Z","X","C","V","F"},
        Multi = true,
        Default = {}
    })
    AutoSkill:OnChanged(function(Value)
        local Values = {}
        for Value, State in next, Value do
            table.insert(Values, Value)
        end
        AutoSpamSkill = Values
    end)
    local AutoBringFruit = Main:AddToggle("", {Title = "Auto Grab/Bring Fruits", Description = "" ,Default = false})
    AutoBringFruit:OnChanged(function(v)
        AutoGrab = v
        while AutoGrab do task.wait()
            pcall(function()
                local Humanoid = _TrashTable:getHumanoid()
                for _,v in pairs(workspace.Fruits:GetChildren()) do
                    if v:IsA("Tool") then
                        if LocalPlayer.Character and v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
                            Humanoid:EquipTool(v)
                        end
                    end
                end
                for _,v in pairs(workspace:GetChildren()) do
                    if v:IsA("Tool") then
                        if LocalPlayer.Character and v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
                            Humanoid:EquipTool(v)
                        end
                    end
                end
            end)
        end
    end)
    local Auto_Chest = Main:AddToggle("", {Title = "Auto Chest", Description = "x5 250Gem Per Chests" ,Default = false})
    Auto_Chest:OnChanged(function(v)
        _Auto_Chest = v
    end)
end
Teleports = Tap.Island:AddSection('Main'); do
    local All_Islands = {}
    spawn(function()
        for _,v in pairs(workspace.Island:GetChildren()) do
            if v:IsA("Model") then
                table.insert(All_Islands,v.Name)
            end
        end
    end)
    local SelectTeleporter = Teleports:AddDropdown("", {
        Title = "Select Island",
        Values = All_Islands,
        Multi = false,
        Default = 1,
    })
    SelectTeleporter:OnChanged(function(v)
        SelectIsland = v
    end)
    Teleports:AddButton({
        Title = "Teleport/Island",
        Description = "",
        Callback = function()
            pcall(function()
                for i,v in pairs(workspace.Island:GetChildren()) do
                    if v.Name == SelectIsland then
                        _TrashTable:Teleport(v:GetModelCFrame() * CFrame.new(0,25,0))
                    end
                end
            end)
        end
    })
    Teleports:AddButton({
        Title = "Teleport to Red Portal",
        Description = "World 2 Only",
        Callback = function()
            pcall(function()
                local Portal = workspace:FindFirstChild("Portal")
                if Portal then
                    _TrashTable:Teleport(Portal.CFrame)
                end
            end)
        end
    })
end

Boss_List = {}
spawn(function()
    for x,v in next, SummonInfo do
        table.insert(Boss_List,x)
    end
end)

spawn(function()
    local ListAccessories = LocalPlayer.PlayerGui:WaitForChild("HUD"):WaitForChild("Inventory"):WaitForChild("Sub_Inventory"):WaitForChild("Main"):WaitForChild("ScrollingFrame")
    if ListAccessories then
        for _,v in ipairs(ListAccessories:GetChildren()) do
            if v:IsA("Frame") and v:GetAttribute("Type") == "Accessories" then
                table.insert(LocalAccessories,v.Name)
            end
        end
    end
end)

local Notify = loadstring(game:HttpGet(('https://raw.githubusercontent.com/treeofplant/Notif/main/library.lua'),true))();

local function Notifi(types,Title,Description,Timeout) -- Success/Custom/Info/Error
    Notify:NewNotification({
     ["Mode"] = types,
     ["Title"] = Title,
     ["Description"] = Description,
     ["Timeout"] = Timeout,
     ["Audio"] = false
 }) 
end

Boss = Tap.Boss:AddSection('Main'); do
    local BossList = Boss:AddDropdown("", {
        Title = "Select Boss",
        Values = Boss_List,
        Multi = false,
        Default = 1,
    })
    BossList:OnChanged(function(v)
        SelectBoss = v
    end)
    local AutoSummonBoss = Boss:AddToggle("", {Title = "Auto Summon", Description = "" ,Default = false})
    AutoSummonBoss:OnChanged(function(v)
        SummonBoss = v
    end)
    local KillBoss = Boss:AddToggle("", {Title = "Auto Boss", Description = "" ,Default = false})
    KillBoss:OnChanged(function(v)
        AutoBoss = v
    end)
    Boss:AddButton({
        Title = "Check Requirement All Boss",
        Description = "",
        Callback = function()
            pcall(function()
                for i,v in next, SummonInfo do
                    Notifi("Info",i,v,10)
                end
            end)
        end
    })
    Boss:AddButton({
        Title = "Teleport To Summon Boss",
        Description = "",
        Callback = function()
            _TrashTable:Teleport(workspace.NpcSpawnBoss.NPC:GetModelCFrame())
        end
    })
    -- Notifi("Error","Status","Click Teleport Again",7)
end

-- while loop
spawn(function()
    while wait(1) do 
        if getgenv().Disconnect then break end
        pcall(function()
            if AutoHaki then
                if not LocalPlayer.Character:FindFirstChild("HakiFolder") then
                    ReplicatedStorage:WaitForChild("Remote"):FindFirstChild("Action"):FireServer("Misc", "buso")
                end    
            end
        end)
    end
end)
spawn(function()
    while wait(1) do 
        if getgenv().Disconnect then break end
        pcall(function()
            if AutoEquipAccessories then
                if not LocalPlayer.Character:FindFirstChild(SelectAccessories) then
                    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Inventory"):FireServer(SelectAccessories)                    
                end    
            end
        end)
    end
end)

spawn(function()
    getgenv().ThreadAutoFarm = Megumint:newThread(0,function()
        if getgenv().Disconnect then Megumint:removeThread(ThreadAutoFarm) end
        if AutoFarmMon then
            pcall(function()
                for _,v in pairs(workspace.Mob:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
                        if v.Name == SelectMonFramWorld1 then
                            repeat task.wait()
                                if getgenv().globalstop then return end;if v.Humanoid.Health==0 then getgenv().CanPressSkill=false else getgenv().CanPressSkill=true end
                                _TrashTable:Teleport(v.HumanoidRootPart.CFrame * getgenv().Rotate)
                                _TrashLPTable:AutoEquip(SelectWeapon)
                            until not AutoFarmMon or v.Humanoid.Health == 0 or getgenv().globalstop
                        end
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoFarm2 = Megumint:newThread(0,function()
        if getgenv().Disconnect then Megumint:removeThread(ThreadAutoFarm2) end
        if AutoFarmMon2 then
            pcall(function()
                for _,v in pairs(workspace.Mob:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
                        if v.Name == SelectMonFramWorld2 then
                            repeat task.wait()
                                if getgenv().globalstop then return end;if v.Humanoid.Health==0 then getgenv().CanPressSkill=false else getgenv().CanPressSkill=true end
                                _TrashTable:Teleport(v.HumanoidRootPart.CFrame * getgenv().Rotate)
                                _TrashLPTable:AutoEquip(SelectWeapon)
                            until not AutoFarmMon2 or v.Humanoid.Health == 0 or getgenv().globalstop
                        end
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadBossSummon = Megumint:newThread(0,function()
        if getgenv().Disconnect then Megumint:removeThread(ThreadBossSummon) end
        if SummonBoss then
            pcall(function()
                if SelectBoss ~= nil then
                    local args = {
                        [1] = "fire",
                        [3] = "SummonBoss",
                        [4] = SelectBoss
                    }
                    ReplicatedStorage:WaitForChild("Modules"):WaitForChild("NetworkFramework"):WaitForChild("NetworkEvent"):FireServer(unpack(args))
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoBoss = Megumint:newThread(0,function()
        if getgenv().Disconnect then Megumint:removeThread(ThreadAutoBoss) end
        if AutoBoss then
            pcall(function()
                for _,v in ipairs(game:GetService("Workspace")["Mob"]:GetChildren()) do
                    if table.find(Boss_List,v.Name) then
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
                            repeat task.wait()
                                if getgenv().globalstop then return end;if v.Humanoid.Health==0 then getgenv().CanPressSkill=false else getgenv().CanPressSkill=true end
                                _TrashTable:Teleport(v.HumanoidRootPart.CFrame * getgenv().Rotate)
                                _TrashLPTable:AutoEquip(SelectWeapon)
                            until not AutoBoss or v.Humanoid.Health == 0 or getgenv().globalstop
                        end
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadChest = Megumint:newThread(0,function()
        if getgenv().Disconnect then Megumint:removeThread(ThreadChest) end
        if _Auto_Chest then
            pcall(function()
                ReplicatedStorage:WaitForChild("Remote"):WaitForChild("RandomFruit"):FireServer("Random",5)
            end)
        end
    end)
end)
spawn(function()
    while task.wait() do
        if getgenv().Disconnect then break end
        if AutoStores then
            pcall(function()
                if LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then -- Check ClassName is Tool
                    replicatesignal(LocalPlayer.PlayerGui:FindFirstChild("Dialogue").Dialog.Sub_Dialog.Frame.Store["3"].MouseButton1Click)
                end
            end)
        end
    end
end)
spawn(function()
    getgenv().ThreadStore = Megumint:newThread(0,function()
        if getgenv().Disconnect then Megumint:removeThread(ThreadStore) getgenv().globalstop = false end
        if AutoStores then
            pcall(function()
                repeat wait(.3)
                    local Single = _TrashLPTable:InBackpackItems()
                    if Single then
                        getgenv().globalstop = true
                        LocalPlayer.Character.Humanoid:EquipTool(Single) 
                    end
                until (Single) or not AutoStores
                for _, v in ipairs(_TrashTable:getCharacter():GetChildren()) do
                    if v:IsA("Tool") and v:GetAttribute("Type") == "Items" then
                        v:Activate()
                        task.wait(.5)
                        getgenv().globalstop = false
                        break
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadEffects = Megumint:newThread(0,function()
        if getgenv().Disconnect then Megumint:removeThread(ThreadEffects) end
        if _RemoveEffects then
            pcall(function()
                for _,v in pairs(game:GetService("Workspace")["FX"]:GetChildren()) do
                    if not v:IsA("Model") then -- Fixed Broken Cam
                        v:ClearAllChildren()
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoRotate = Megumint:newThread(0,function()
        if getgenv().Disconnect then Megumint:removeThread(ThreadAutoRotate) end
        pcall(function() -- {"Above","Behind","Front","Below","RandomRotate"}
            if MethodFarms == "Above" then
                getgenv().Rotate = CFrame.new(0,DistanceFarms,0) * CFrame.Angles(math.rad(-90), 0, 0)
            elseif MethodFarms == "Behind" then
                getgenv().Rotate = CFrame.new(0,0,DistanceFarms) * CFrame.Angles(0, math.rad(0), 0)
            elseif MethodFarms == "Front" then
                getgenv().Rotate = CFrame.new(0,0,-DistanceFarms) * CFrame.Angles(0, math.rad(180), 0)
            elseif MethodFarms == "Below" then
                getgenv().Rotate = CFrame.new(0,-DistanceFarms,0) * CFrame.Angles(math.rad(90), 0, 0)
            elseif MethodFarms == "RandomRotate" then
                _TrashLPTable:RandomRotateReal()
            end
        end)
    end)
end)
spawn(function()
    getgenv().ThreadAutoSkill = Megumint:newThread(0,function()
        if getgenv().Disconnect then Megumint:removeThread(ThreadAutoSkill) end
        if EnableAutoSkills and getgenv().CanPressSkill and not _TrashTable:isDead() then
            pcall(function()
                if table.find(AutoSpamSkill,"Z") then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                    task.wait(delayskilltime)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
                end
                if table.find(AutoSpamSkill,"X") then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game)
                    task.wait(delayskilltime)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game)
                end
                if table.find(AutoSpamSkill,"C") then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
                    task.wait(delayskilltime)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game)
                end
                if table.find(AutoSpamSkill,"V") then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.V, false, game)
                    task.wait(delayskilltime)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game)
                end
                if table.find(AutoSpamSkill,"F") then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                    task.wait(delayskilltime)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                end
            end)
        end
    end)
end)

local Old = os.time()
Settings_M = Tap.Settings:AddSection("Misc") do
    local White_Screen = Settings_M:AddToggle("", {Title = "White Screen", Description = "only white screen" ,Default = true})
    White_Screen:OnChanged(function(v)
        WhiteScreen = v
    end)
    local Opfps = Settings_M:AddToggle("", {Title = "Fps(White Screen)", Description = "set fpscap to low, less cpu/gpu" ,Default = false})
    Opfps:OnChanged(function(v)
        Set_Fps = v
    end)
    Timeing = Settings_M:AddParagraph({
        Title = "Timeing Server"
    })
    ServerJobs = Settings_M:AddParagraph({        
        Title = "Your JobId " .. tostring(game.JobId)
    })
    local EnteredJobid = Settings_M:AddInput("Input", {
        Title = "Enter JobId",
        Default = "Job Id ?",
        Placeholder = "",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(v)
            SaveJobId = v
        end
    })
    EnteredJobid:OnChanged(function(v)
        SaveJobId = v
    end)
    Settings_M:AddButton({
        Title = "Join Server",
        Description = "Very important button",
        Callback = function()
            local suc,fail = pcall(function()
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, tostring(SaveJobId) , LocalPlayer)
            end)
            if suc then
                Fluent:Notify({
                    Title = "Success.",
                    Content = "Teleporting Please wait",
                    Duration = 8
                })
            end
            if fail then
                Fluent:Notify({
                    Title = "Failed to Teleport.",
                    Content = "make sure to enter not just click",
                    Duration = 8
                })
            end
        end
    })
    Settings_M:AddButton({
    Title = "Copy Your Job Id",
    Callback = function()
        setclipboard(tostring(game.JobId))
        wait()
        Fluent:Notify({
            Title = "Kurone",
            Content = "Copyed Job Id",
            Duration = 3
        })
    end
    })
    Settings_M:AddButton({
        Title = "Rejoin Server",
        Description = "Click to Rejoin",
        Callback = function()
            local TeleportService = game:GetService("TeleportService")
            if #game:GetService("Players"):GetPlayers() <= 1 then
                game:GetService("Players").LocalPlayer:Kick("\nRejoining...")
                wait()
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            else
                TeleportService:TeleportToPlaceInstance(game.placeId, game.jobId, LocalPlayer)
            end
        end,
    })
end
local ToggleWhiteScreen
local ToggleWhiteScreen2
ToggleWhiteScreen = game:GetService("UserInputService").WindowFocusReleased:Connect(function()
    if getgenv().Disconnect then
        ToggleWhiteScreen:Disconnect();ToggleWhiteScreen = nil
    end
    if WhiteScreen then
        RunService:Set3dRenderingEnabled(false);
        if Set_Fps and setfpscap then
            setfpscap(12)
        end
    end
end)
ToggleWhiteScreen2 = game:GetService("UserInputService").WindowFocused:Connect(function()
    if getgenv().Disconnect then
        ToggleWhiteScreen2:Disconnect();ToggleWhiteScreen2 = nil
    end
    RunService:Set3dRenderingEnabled(true);
    if setfpscap then
        setfpscap(100)
    end
end)

local Timer
Timer = RunService.Heartbeat:Connect(function() -- All RunService
    if getgenv().Disconnect then
        Timer:Disconnect();Timer = nil
    end
    pcall(function()
        local TimeSinceLastPlay = os.time() - Old
        local hours = tostring(math.floor(TimeSinceLastPlay / 3600))
        local minutes = tostring(math.floor((TimeSinceLastPlay % 3600) / 60))
        local seconds = tostring(TimeSinceLastPlay % 60)
        Timeing:SetTitle("Server Joined "..hours.." H "..minutes.." M "..seconds.." S ")
        RunService.Heartbeat:Wait()
    end,print)
end)

InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("KuroneUwU")
InterfaceManager:BuildInterfaceSection(Tap.Settings)
Window:SelectTab(1)

if setfpscap then
    setfpscap(240)
end

if setfflag then
    pcall(function()
        setfflag("AbuseReportScreenshot", "False")
        setfflag("AbuseReportScreenshotPercentage", "0")
    end)
end

print("Loading Success Took "..string.format("%.2f",tick() - LoadingTime).." secs")
Fluent:Notify({
    Title = "Script",
    Content = "Loading Success Took "..string.format("%.2f",tick() - LoadingTime).." secs",
    Duration = 8
})
