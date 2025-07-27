-- if getgenv().Syreiy and not _G.DEBUG == true then
--     return
-- end

-- pcall(function() getgenv().Syreiy = true end);
getgenv().Disable_Connect = {}
if not game:IsLoaded() then game.Loaded:Wait() end; warn("Hello :3")

do if game.PlaceId == 79546208627805 then return game:GetService"Players"["LocalPlayer"]:Kick("Lobby detected. Please join the actual game.") end end

function missing(t, f, fallback)
    if type(f) == t then return f end
    return fallback
end

cloneref = missing("function", cloneref, function(...) return ... end)
firetouchinterest = missing("function", firetouchinterest)
hookmetamethod = missing("function", hookmetamethod)
checkcaller = missing("function", checkcaller, function() return false end)
setthreadidentity = missing("function", setthreadidentity or (syn and syn.set_thread_identity) or syn_context_set or setthreadcontext)
local LoadingTime = tick();
local Modules = {};
Modules.__index = Modules;

local Settings = {
    KillAura = false,
    Distance = 25,
    AutoFarmTree = false,
    AutoCookedItem = false,
    No_Fog = false,
    Sefe_Part = false,
    WalkSpeed = false,
    WalkSpeedVal = .3,
    SpeedType = "ChangeSpeed",
    Noclip = false,
    InfJump = false,
    FullBright = false,
    InstPrompts = false,
    ESP = false,
    SetChildren = "Dino Kid",
}

local RepitationThread = loadstring(game:HttpGet("https://gist.githubusercontent.com/CylciaUwU/ea277c117164f82fb40016246ba6a9ad/raw/eb0502cf8ad85b70a7b24e92227f37e717eb8111/RepitationThread.luau"))();
-- local Hooks = loadstring(game:HttpGet("https://raw.githubusercontent.com/ClassicSenior/Hooks/main/hooks.lua"),true)();
local Controller = RepitationThread.new();
local random = math.random;
-- local char = string.char; --// not using for now
local NO_VIRTUALIZE = (function(...) return ... end);

local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))();
ESP.Players = false;
ESP.Boxes = false;
ESP.Names = true;

local Players = cloneref(game:GetService("Players"));
local LocalPlayer = cloneref(Players.LocalPlayer);
local Lighting = cloneref(game:GetService("Lighting"));
local RunService = cloneref(game:GetService("RunService"));
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"));
local TeleportService = cloneref(game:GetService("TeleportService"))
-- local VirtualInputManager = cloneref(game:GetService("VirtualInputManager"));
local VirtualUser = cloneref(game:GetService("VirtualUser"));
local UserInputService = cloneref(game:GetService("UserInputService"));

local PlayersGui = LocalPlayer:FindFirstChildWhichIsA("PlayerGui");
local RemoteEvents = ReplicatedStorage["RemoteEvents"];
local RemoteEventsCaller = {
    ["RequestOpenItemChest"] = RemoteEvents["RequestOpenItemChest"],
    ["RequestCollectCoints"] = RemoteEvents["RequestCollectCoints"],
    ["RequestCookItem"] = RemoteEvents["RequestCookItem"],
    ["ToolDamageObject"] = RemoteEvents["ToolDamageObject"]
}
local Heartbeat, Stepped, RenderStepped, PreSimulation = RunService.Heartbeat, RunService.Stepped, RunService.RenderStepped, RunService.PreSimulation;
local IsOnMobile = table.find({Enum.Platform.Android, Enum.Platform.IOS}, UserInputService:GetPlatform());

local Fluent = loadstring(game:HttpGet("https://gist.githubusercontent.com/CylciaUwU/4ce60ba116cb52855f282a7f50b1866b/raw/99adeed59d839b7beb7ccff8de6779599adb234e/Fluent.lua"))();
-- local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))();
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))();
local Options = Fluent.Options;

while not LocalPlayer do
	wait()
	LocalPlayer = cloneref(Players.LocalPlayer)
end
local isDebug = false;
isDebug = true;
local debugprint, debugwarn; do
	local p,w = print,warn
	debugprint = function(...)
		return isDebug and p("[DEBUG]",...)
	end
	debugwarn = function(...)
		return isDebug and w("[DEBUG]",...)
	end
end

spawn(function()
    local no_part,yes_part = pcall(function()
        assert(not getgenv().Safe_Part)
        getgenv().Safe_Part = true;
        getgenv().Part = Instance.new("Part",workspace.Terrain);
        getgenv().Part.Anchored = true;
        getgenv().Part.Size = Vector3.new(150, 1, 150);
        r = random(random(250, 300));
        cs = Vector3.new(5, 250, 5) + Vector3.new(0, r, 0);
        getgenv().Part.CFrame = CFrame.new(cs);
        getgenv().Part.Material = Enum.Material.ForceField
        getgenv().Part.Transparency = 1

        getgenv().Part.Name = game:GetService("HttpService"):GenerateGUID(false);
    end)
end)

local Blacklist = { --// use :lower() instead
    "pelt trader",
    "deer",
    "lost child"
}
local origsettings = {
	abt = Lighting.Ambient,
	oabt = Lighting.OutdoorAmbient,
	brt = Lighting.Brightness,
	time = Lighting.ClockTime,
	fe = Lighting.FogEnd,
	fs = Lighting.FogStart,
	gs = Lighting.GlobalShadows
}
function tostr(Str)
    return tostring(Str)
end
function Modules:getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end
function Modules:getRoot()
    return self:getCharacter():FindFirstChild("HumanoidRootPart");
end
function Modules:getHumanoid()
    return self:getCharacter():WaitForChild("Humanoid",9e9) or self:getCharacter():FindFirstChildWhichIsA("Humanoid",9e9)
end
function Modules:getState()
    return self:getHumanoid():GetState()
end
function Modules:changeState(State)
    local success, failed = pcall(function()
        self:getHumanoid():ChangeState(State)
    end)
    if failed then
        return debugwarn("Failed to change state", failed)
    end
end
function Modules:Teleport(Position)
    local RealtargetPos = {Position}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = CFrame.new(targetPos)
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
	end

    return self:getCharacter():PivotTo(RealTarget)
end
function Modules:ChangeSpeed(Val)
    if not Val then return end;

    local Humanoid = self:getHumanoid();
    if Humanoid then
        Humanoid["WalkSpeed"] = Val
    end
end
function Modules:FireTouchPart(Part)
	local TouchTransmitter = Part:FindFirstChildOfClass("TouchTransmitter")
	if not TouchTransmitter then return end

	local Root = self:getRoot()

    if firetouchinterest and Root then
        firetouchinterest(Root, Part, 0)
        firetouchinterest(Root, Part, 1)
    else
        return debugwarn("Missing HumanoidRootPart or firetouchinterest function.")
    end
end
function Modules:GetClosestMob()
    local dist = Settings.Distance or 1/0
    local closest_mob

    for _, v in pairs(workspace.Characters:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then --// can't check humanoid by name
            local Humanoid = v:FindFirstChildWhichIsA("Humanoid")
            if not table.find(Blacklist, v.Name:lower()) and Humanoid.Health > 0 then
                local Hum = v:FindFirstChild("HumanoidRootPart")
                -- local DistanceFromTarget = Hum and LocalPlayer:DistanceFromCharacter(Hum.CFrame.Position)
                local MagI = (Hum and Hum.Position - self:getRoot().Position).Magnitude

                if MagI and MagI <= dist then
                    dist = MagI
                    closest_mob = v
                end
            end
        end
    end
    return closest_mob, dist
end
-- function Modules:GetHitRegisters()local HitRegister=nil;for _,v in ipairs(workspace.Characters:GetChildren())do if v:IsA("Model")and v:FindFirstChild("HumanoidRootPart")then local _HitRegisters=v:FindFirstChild("HitRegisters")local HasAttributes=_HitRegisters:GetAttributes()for index,v2 in next,HasAttributes do if index then HitRegister=index;break end end end end;return HitRegister or"nil"end;function Modules:GetTargetByHitRegister(HitRegister)if not HitRegister then return end;for _,v in ipairs(workspace.Characters:GetChildren())do if v:IsA("Model")and v:FindFirstChild("HumanoidRootPart")then local _HitRegisters=v:FindFirstChild("HitRegisters")local GetAttributes=_HitRegisters:GetAttributes(HitRegister)if GetAttributes and GetAttributes[HitRegister]then return v end end end end;function Modules:GetWeapons()for _,v in pairs(LocalPlayer.Inventory:GetChildren())do if v:IsA("Model")and v:GetAttribute("ToolName")then if v:GetAttribute("ToolName")=="GenericSword"then return v.Name elseif v:GetAttribute("ToolName")=="GenericAxe"then return v.Name end end end end
function Modules:GetPlayerEquipped()
    local WhatWeaponIsPlayerEquip = nil;
    local Character = self:getCharacter()

    for i,v in next, Character:GetAttributes() do
        if v ~= nil then
           WhatWeaponIsPlayerEquip = v 
        end
    end
    return WhatWeaponIsPlayerEquip
end
function Modules:KillAura()
    args = nil;

    local Mobs, distance = self:GetClosestMob();
	local Weapons = self:GetPlayerEquipped();
    if not Weapons and not Mobs then return end

    local success, failed = pcall(function()
        args = {
            Mobs,
            LocalPlayer.Inventory:FindFirstChild(Weapons),
            "1_" .. LocalPlayer.UserId,
            Mobs.HumanoidRootPart.CFrame
        }
    end)

    if not success then return end

    return RemoteEventsCaller.ToolDamageObject:InvokeServer(unpack(args));
end
function Modules:BringItems(Unit)
    if not Unit then return end;

    local rootpart = self:getRoot()
    local wsItems = workspace.Items:GetChildren();

    local success, callback = pcall(function()
        for _,v in pairs(wsItems) do
            if string.find(v.Name, Unit) then
                v:PivotTo(rootpart:GetPivot() * CFrame.new(0, 6, 0))
            end
        end
    end)

    if ((callback) or not success) then
        return debugwarn("Failed to bring items:", callback or "Huh?")
    end
end
function Restorelighting()
    Lighting.Ambient = origsettings.abt;
	Lighting.OutdoorAmbient = origsettings.oabt;
	Lighting.Brightness = origsettings.brt;
	Lighting.ClockTime = origsettings.time;
	Lighting.FogEnd = origsettings.fe;
	Lighting.FogStart = origsettings.fs;
	Lighting.GlobalShadows = origsettings.gs;

    if Lighting.ColorCorrection.Enabled then
        Lighting.ColorCorrection.Enabled = false
    end
end
local Window = Fluent:CreateWindow({
    Title = "99 Nights in the Forest | Updating",
    SubTitle = "By Syreiy",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, 
    Theme = "Darker",
    Transparency = false,
    MinimizeKey = Enum.KeyCode.RightShift,
})
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "component" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Status = Window:AddTab({ Title = "Status", Icon = "cloud-fog" }),
    MissingChild = Window:AddTab({ Title = "Missing Child", Icon = "smile-plus" }),
    ESP = Window:AddTab({ Title = "Esp", Icon = "eye" }),
    Bring = Window:AddTab({ Title = "Bring Items", Icon = "box" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
local TabMain = Tabs.Main:AddSection("Main") do
    local DistanceKillAuras = TabMain:AddSlider("Slider", {
        Title = "Distance Kill Auras",
        Description = "",
        Default = 25,
        Min = 15,
        Max = 150,
        Rounding = 1,
        Callback = function(v)
            Settings.Distance = math.floor(v)
        end
    })
    DistanceKillAuras:OnChanged(function(v)
        Settings.Distance = math.floor(v)
    end)
    DistanceKillAuras:SetValue(25);
    local AutoKillAura = TabMain:AddToggle("KillAuraletgo", {Title = "Kill Aura", Default = false })
    AutoKillAura:OnChanged(function(v)
        Settings.KillAura = v
    end)
    local FarmTree = TabMain:AddToggle("FarmTree", {Title = "Farm Tree", Description = "Equip axe first, Depending on your axe (work with small tree only)", Default = false })
    FarmTree:OnChanged(function(v)
        Settings.AutoFarmTree = v
    end)
    local AutoCookedItem = TabMain:AddToggle("AutoCookedItem", {Title = "Auto Cooked Meat", Description = "Steak, Morsel", Default = false })
    AutoCookedItem:OnChanged(function(v)
        Settings.AutoCookedItem = v
    end)
    local NoFogs = TabMain:AddToggle("Fog", {Title = "No Fog", Description = "unloaded chunk", Default = false })
    NoFogs:OnChanged(function(v)
        Settings.No_Fog = v
    end)
    local SafePart = TabMain:AddToggle("SafePart", {Title = "Teleport to safe part", Description = "If disabled will teleport back to old position." ,Default = false })
    SafePart:OnChanged(function(v)
        Settings.Sefe_Part = v
        if Settings.Sefe_Part then
            task.defer(function() --// make sure to save old position first
                oldpos = Modules:getRoot().CFrame;
                Modules:Teleport(getgenv().Part.CFrame * CFrame.new(0, 6, 0));
            end)
        else
            pcall(function()
                Modules:Teleport(oldpos);
                oldpos = nil;
            end)
        end
    end)
    TabMain:AddButton({
        Title = "Telepot to Center of CampFire",
        Description = "",
        Callback = function()
            pcall(function()
                Modules:Teleport(workspace.Map.Campground.MainFire.Center.CFrame * CFrame.new(0, 8, 0))
            end)
        end
    })
    TabMain:AddButton({
        Title = "Open All Chest",
        Description = "",
        Callback = function()
            pcall(function()
                for _,v in pairs(workspace.Items:GetChildren()) do
                    if string.find(v.Name, "Item Chest") then
                        RemoteEventsCaller.RequestOpenItemChest:FireServer(v)
                    end
                end
            end)
        end
    })
    TabMain:AddButton({
        Title = "Collect All Coin Stack",
        Description = "",
        Callback = function()
            pcall(function()
                for _,v in ipairs(workspace.Items:GetChildren()) do
                    if string.find("coin stack", v.Name:lower()) then
                        RemoteEventsCaller.RequestCollectCoints:InvokeServer(v)
                    end
                end
            end)
        end
    })
end
local Playertab = Tabs.Player:AddSection("") do
    -- local ToogleTypeSP = Playertab:AddDropdown("Speed Toggle", {
    --     Title = "Type WalkSpeed",
    --     Values = {"ChangeSpeed","CFrame","BHop"},
    --     Multi = false,
    --     Default = 1,
    -- })
    -- ToogleTypeSP:SetValue("ChangeSpeed")
    -- ToogleTypeSP:OnChanged(function(v)
    --     Settings.SpeedType = v
    --     if v ~= "BHop" then
    --         Modules:getHumanoid().UseJumpPower = true
    --     end
    -- end)
    local SetSpeed = Playertab:AddSlider("", {
        Title = "Speed",
        Description = "",
        Default = 16,
        Min = 16,
        Max = 100,
        Rounding = 1,
        Callback = function(v)
            Settings.WalkSpeedVal = v * 1.5
        end
    })
    SetSpeed:OnChanged(function(v)
        Settings.WalkSpeedVal = v * 1.5
    end)
    local ToggleWalkSpeed = Playertab:AddToggle("", {Title = "Enable WalkSpeed", Default = false })
    ToggleWalkSpeed:OnChanged(function(v)
        Settings.WalkSpeed = v
        if not Settings.WalkSpeed then
            Modules:ChangeSpeed(16)
        end
    end)
    local InfJump = Playertab:AddToggle("", {Title = "Enable Infinite Jump", Default = false })
    InfJump:OnChanged(function(v)
        Settings.InfJump = v
    end)
    local FullBrights = Playertab:AddToggle("", {Title = "Enable FullBright", Default = false })
    FullBrights:OnChanged(function(v)
        Settings.FullBright = v
        if not Settings.FullBright then
            pcall(function()
                spawn(Restorelighting)
            end)
        end
    end)
    local iyinstpp = Playertab:AddToggle("", {Title = "Enable Instant Prompts", Default = false })
    iyinstpp:OnChanged(function(v)
        Settings.InstPrompts = v
    end)
    local Nocliplol = Playertab:AddToggle("", {Title = "Enable Noclip", Default = false })
    Nocliplol:OnChanged(function(v)
        Settings.Noclip = v
    end)
end
local Espitemthing = Tabs.ESP:AddSection("") do
    local ToggleEso = Espitemthing:AddToggle("", {Title = "Enable Esp", Default = false })
    ToggleEso:OnChanged(function(v)
        Settings.ESP = v
        ESP:Toggle(Settings.ESP)
    end)
    local espchest = Espitemthing:AddToggle("", {Title = "Esp Chest", Default = false })
    espchest:OnChanged(function(v)
        getgenv().Esp_Chest = v
        if getgenv().Esp_Chest then
            for _,v in pairs(workspace.Items:GetChildren()) do
                if string.find(v.Name, "Item Chest") then
                    ESP:AddObjectListener(v, {
                        Name = "ChestLid",
                        CustomName = "Chest",
                        Color = Color3.new(0.403921, 0.494117, 1),
                        IsEnabled = "Chest"
                    })
                    ESP.Chest = Settings.ESP
                end
            end
        end
    end)
end
Statthing = {}
local Statusshity = Tabs.Status:AddSection("") do
    Statthing.MotherShip = Statusshity:AddParagraph({
        Title = "AlienMotherShipCFrame",
        Content = "N/A"
    })
    Statusshity:AddButton({
        Title = "Teleport to Alien MotherShip",
        Description = "",
        Callback = function()
            pcall(function()
                Modules:Teleport(workspace:GetAttribute('AlienMothershipCF'))
            end)
        end
    })
    Statthing.IsCultistAttack = Statusshity:AddParagraph({
        Title = "CultistAttackDay",
        Content = "N/A"
    })
    Statthing.Progress = Statusshity:AddParagraph({
        Title = "Progress (Campfire LvL)",
        Content = "N/A"
    })
    Statthing.Fuel_Remaining = Statusshity:AddParagraph({
        Title = "Progress: Fuel Remaining",
        Content = "N/A"
    })
    Statthing.Weather = Statusshity:AddParagraph({
        Title = "Weather",
        Content = "N/A"
    })
    -- Statthing[2] = Statusshity:AddParagraph({
    --     Title = "",
    --     Content = "N/A"
    -- })
end
StatusKid = {}
local MissingChildren = Tabs.MissingChild:AddSection("Missing Child") do
    local MissingKids = workspace["Map"]["MissingKids"];

    StatusKid.DinoKid = MissingChildren:AddParagraph({
        Title = "Dino Kid",
        Content = "N/A"
    })
    StatusKid.KrakenKid = MissingChildren:AddParagraph({
        Title = "Kraken Kid",
        Content = "N/A"
    })
    StatusKid.SquidKid = MissingChildren:AddParagraph({
        Title = "Squid Kid",
        Content = "N/A"
    })
    StatusKid.KoalaKid = MissingChildren:AddParagraph({
        Title = "Koala Kid",
        Content = "N/A"
    })
    local SelectChildren = MissingChildren:AddDropdown("howtoanmeis", {
        Title = "Select Children",
        Values = {"Dino Kid","Kraken Kid","Squid Kid","Koala Kid"},
        Multi = false,
        Default = 1,
    })
    Options.howtoanmeis:SetValue(false)
    SelectChildren:OnChanged(function(v)
        Settings.SetChildren = v
        if Settings.SetChildren == nil then return end

        -- pcall(function()
            if Settings.SetChildren == "Dino Kid" then
                Modules:Teleport(MissingKids:GetAttribute('DinoKid'))
            elseif Settings.SetChildren == "Kraken Kid" then
                Modules:Teleport(MissingKids:GetAttribute('KrakenKid'))
            elseif Settings.SetChildren == "Squid Kid" then
                Modules:Teleport(MissingKids:GetAttribute('SquidKid'))
            elseif Settings.SetChildren == "Koala Kid" then
                Modules:Teleport(MissingKids:GetAttribute('KoalaKid'))
            end
        end)
    -- end)

end
local Bringtarr = Tabs.Bring:AddSection("Bring") do
    Warningtext = Bringtarr:AddParagraph({
        Title = "::Warning::",
        Content = "Don't bring items too close Crafting table or campfire, It will glitch"
    })
    local Scrappable = Bringtarr:AddDropdown("", {
        Title = "Scrappable Items",
        Description = "",
        Values = {"Sheet Metal","Bolt","Broken Fan","Tyre","Metal Chair","Broken Microwave"--[["Cultist Experiment","Cultist Prototype"--]],"Old Car Engine","Washing Machine"},
        Multi = true,
        Default = {}
    })
    Scrappable:OnChanged(function(Value)
        local Scrappablething = {}
        for Value, State in next, Value do
            table.insert(Scrappablething, Value)
        end
        getgenv().Setecteditem = Scrappablething
    end)
    Bringtarr:AddButton({
        Title = "Bring",
        Description = "Scrap",
        Callback = function()
            pcall(function()
                for _,v in pairs(workspace.Items:GetChildren()) do
                    if table.find(getgenv().Setecteditem, v.Name) then
                        Modules:BringItems(v.Name)
                    end 
                end
            end)
        end
    })
    local Fuelt = Bringtarr:AddDropdown("", {
        Title = "Fuel",
        Description = "",
        Values = {"Log","Chair","Coal","Fuel Canister","Oil Barrel","Biofuel"},
        Multi = true,
        Default = {}
    })
    Fuelt:OnChanged(function(Value)
        local Fuelcm = {}
        for Value, State in next, Value do
            table.insert(Fuelcm, Value)
        end
        getgenv().FuelBir = Fuelcm
    end)
    Bringtarr:AddButton({
        Title = "Bring",
        Description = "Fuel",
        Callback = function()
            pcall(function()
                for _,v in pairs(workspace.Items:GetChildren()) do
                    if table.find(getgenv().FuelBir, v.Name) then
                        Modules:BringItems(v.Name)
                    end 
                end
            end)
        end
    })
    Bringtarr:AddButton({
        Title = "Bring Tool Type",
        Description = "",
        Callback = function()
            pcall(function()
                for _,v in pairs(workspace.Items:GetChildren()) do
                    local IsTool = v:GetAttribute('Interaction') == "Tool";
                    local Distance = (v.PrimaryPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;

                    if IsTool and Distance >= 50 then
                        Modules:BringItems(v.Name)
                    end
                end
            end)
        end
    })
    Bringtarr:AddButton({
        Title = "Bring Armour Type",
        Description = "",
        Callback = function()
            pcall(function()
                for _,v in pairs(workspace.Items:GetChildren()) do
                    local IsArmour = v:GetAttribute('Interaction') == "Armour";
                    local Distance = (v.PrimaryPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;

                    if IsArmour and Distance >= 50 then
                        Modules:BringItems(v.Name)
                    end
                end
            end)
        end
    })
    Bringtarr:AddButton({
        Title = "Bring Food",
        Description = "Only bring food is cook",
        Callback = function()
            pcall(function()
                for _,v in pairs(workspace.Items:GetChildren()) do
                    local Is_HasMeat = v:GetAttribute('HasMeat') == true;
                    local Distance = (v.PrimaryPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;

                    if Is_HasMeat and Distance >= 50 then
                        Modules:BringItems(v.Name)
                    end
                end
            end)
        end
    })
end

getgenv().Threads = {};

do
    Threads.Aura = Controller:newThread(nil, function()
        pcall(function()
            if getgenv().Disable_Connect == nil then
                Controller:removeThread(Threads.Aura)
            end
            if Settings.KillAura then
               Modules:KillAura()
            end
        end)
    end)
    Threads.Meat = Controller:newThread(nil, function()
        pcall(function()
            if getgenv().Disable_Connect == nil then
                Controller:removeThread(Threads.Meat)
            end
            if Settings.AutoCookedItem then
                for _,v in pairs(workspace.Items:GetChildren()) do
                    local getCookable = v:GetAttribute('Cookable') == true
                    if getCookable then
                        RemoteEventsCaller.RequestCookItem:FireServer(workspace.Map.Campground.MainFire, v)
                    end
                end
            end
        end)
    end)
    Threads.Tree = Controller:newThread(nil, function()
        pcall(function()
            if getgenv().Disable_Connect == nil then
                Controller:removeThread(Threads.Tree)
            end
            if Settings.AutoFarmTree then
                for _,v in pairs(workspace.Map.Foliage:GetChildren()) do
                    if string.find(v.Name:lower(), "small tree") then
                        local args = {
                            v,
                            LocalPlayer.Inventory:FindFirstChild(Modules:GetPlayerEquipped()),
                            "1",
                            CFrame.new()
                        }
                        RemoteEventsCaller.ToolDamageObject:InvokeServer(unpack(args))
                    end
                end
            end
        end)
    end)
    Threads.WsSpeed = Controller:newThread(nil, function()
        pcall(function()
            if getgenv().Disable_Connect == nil then
                Controller:removeThread(Threads.WsSpeed)
            end
            if Settings.WalkSpeed then
                Modules:ChangeSpeed(Settings.WalkSpeedVal)
            end
        end)
    end)
    Threads.FulfBiggh = Controller:newThread(nil, function()
        pcall(function()
            if getgenv().Disable_Connect == nil then
                Controller:removeThread(Threads.FulfBiggh)
            end
            if Settings.FullBright then
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                if Lighting.ColorCorrection.Enabled then
                    Lighting.ColorCorrection.Enabled = false
                end
            end
        end)
    end)
    Threads.UnlockFog = Controller:newThread(.5, function()
        pcall(function()
            if getgenv().Disable_Connect == nil then
                Controller:removeThread(Threads.UnlockFog)
            end
            if Settings.No_Fog then
                for _,v in pairs(workspace.Map.Boundaries:GetChildren()) do
                    if v:IsA("Part") then
                        Modules:FireTouchPart(v)
                    end
                end
            end
        end)
    end)
end
local ProximityPromptService = cloneref(game:GetService("ProximityPromptService"))
do
    getgenv().Disable_Connect.PromptButtonHoldBegan = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
        if Settings.InstPrompts and Modules:getCharacter() and fireproximityprompt then
            fireproximityprompt(prompt)
        end
    end)
end
do
    getgenv().Disable_Connect.infjp = UserInputService.InputBegan:Connect(function(iobj, gp)
        if not IsOnMobile and not gp and Settings.InfJump then
            pcall(function()
                if iobj.KeyCode == Enum.KeyCode.Space and LocalPlayer.Character then
                    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
                    end
                end
            end)
        end
    end)
end
do
    getgenv().Disable_Connect.inf_mb = UserInputService.JumpRequest:Connect(function()
        if IsOnMobile and Settings.InfJump then
            pcall(function()
                local hum = Modules:getHumanoid()
                hum:ChangeState("Seated")
                wait()
                hum:ChangeState("Jumping")    
            end)
        end
    end)
end
spawn(function()
    getgenv().Disable_Connect.Items = workspace.Items.ChildAdded:Connect(function(c)
        if string.find(c.Name, "Item Chest") and getgenv().Esp_Chest then
            ESP:AddObjectListener(c, {
                Name = "ChestLid",
                CustomName = "Chest",
                Color = Color3.new(0.552941, 0.588235, 0.996078),
                IsEnabled = "Chest"
            })
            ESP.Chest = Settings.ESP
        end
    end)
end)

--// hook thing
-- do
--     Hooks[1]:namecallHook("", "FireServer")
-- end
local index
local newindex
do
    index = hookmetamethod(game, "__index", function(self, i)
        if i == "WalkSpeed" and Settings.WalkSpeed and index(self, "ClassName") == "Humanoid" and not checkcaller() then
            return Settings.WalkSpeedOG or 16
        end
        return index(self, i)
    end)
    newindex = hookmetamethod(game, "__newindex", function(self, i, v)
        if i == "WalkSpeed" and Settings.WalkSpeed and self.ClassName == "Humanoid" and not checkcaller() then
            Settings.WalkSpeedOG = v
            v = Settings.WalkSpeedVal
        end
        return newindex(self, i, v)
    end)
end

local lastpos;
local PartDestroyHeight = game:GetService("Workspace").FallenPartsDestroyHeight;
spawn(function()
    getgenv().Disable_Connect.antifall = PreSimulation:Connect(function()
        local Root = Modules:getRoot();
        local Hamnid = Modules:getHumanoid();

        lastpos = Hamnid.FloorMaterial ~= Enum.Material.Air and Root.Position or lastpos
        if (Root.Position.Y + (Root.Velocity.Y * 0.016)) <= (PartDestroyHeight + 10) then
            lastpos = lastpos or Vector3.new(Root.Position.X, (PartDestroyHeight + 20), Root.Position.Z)
            Root.CFrame += (lastpos - Root.Position)
            Root.Velocity *= Vector3.new(1, 0, 1)
            Fluent:Notify({
                Title = "Sylvia",
                Content = "Did you just falled into the void?",
                Duration = 8
            })
        end
    end)
end)
--// noclip --
local toUndo = {}
spawn(function()
    getgenv().Disable_Connect.Noclip = Stepped:Connect(function()
        local Char = Modules:getCharacter()
        if Settings.Noclip and Char then
			for i,v in pairs(Char:GetDescendants()) do
				if v:IsA("BasePart") and v.CanCollide then
					v.CanCollide = false
					toUndo[v] = true
				end
			end
		else
			for i,v in pairs(toUndo) do
				toUndo[i] = nil
				i.CanCollide = true
			end
		end
    end)
end)
--// anti afk--
spawn(function()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)
NO_VIRTUALIZE(function()
	task.spawn(function()
		while task.wait() do
            if getgenv().Disable_Connect == nil then break end
			if setscriptable then
				setscriptable(LocalPlayer, "SimulationRadius", true)
			end
			if sethiddenproperty then
				sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                sethiddenproperty(LocalPlayer, "MaxSimulationRadius", math.huge)
			end
		end
	end)
end)()

local Old = os.time()
Settings_M = Tabs.Settings:AddSection("Misc") do
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
                TeleportService:TeleportToPlaceInstance(game.PlaceId, tostring(SaveJobId) , LocalPlayer)
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
            Title = "setclipboard",
            Content = "Copyed Job Id",
            Duration = 3
        })
    end
    })
    Settings_M:AddButton({
        Title = "Rejoin Server",
        Description = "Click to Rejoin",
        Callback = function()
            local TeleportService = cloneref(game:GetService("TeleportService"))
            if #game:GetService("Players"):GetPlayers() <= 1 then
                LocalPlayer:Kick("\nRejoining...")
                wait()
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            else
                TeleportService:TeleportToPlaceInstance(game.placeId, game.jobId, LocalPlayer)
            end
        end,
    })
end

getgenv().Disable_Connect.Timer = Heartbeat:Connect(function()
    pcall(function()
        local TimeSinceLastPlay = os.time() - Old
        local hours = tostring(math.floor(TimeSinceLastPlay / 3600))
        local minutes = tostring(math.floor((TimeSinceLastPlay % 3600) / 60))
        local seconds = tostring(TimeSinceLastPlay % 60)

        local Campground = workspace.Map.Campground
        local MainFire = Campground["MainFire"]
        local MissingKidTracker = Campground["NoticeBoard"]["MissingKidTracker"]

        Timeing:SetTitle("Server Joined "..hours.." H "..minutes.." M "..seconds.." S ");

        Statthing.MotherShip:SetDesc(tostr(workspace:GetAttribute('AlienMothershipCF')));
        Statthing.IsCultistAttack:SetDesc(tostr(workspace:GetAttribute('CultistAttackDay')));
        Statthing.Progress:SetDesc("Campfire Level): "..tostr(workspace:GetAttribute('Progress')));
        Statthing.Fuel_Remaining:SetDesc("Fuel Remaining: ".. tostr(MainFire:GetAttribute('FuelRemaining')))
        Statthing.Weather:SetDesc(tostr(workspace:GetAttribute('Weather')))

        StatusKid.DinoKid:SetDesc("Is Founded: "..tostr(MissingKidTracker["DinoKid"]:GetAttribute('Found')));
        StatusKid.KrakenKid:SetDesc("Is Founded: "..tostr(MissingKidTracker["KrakenKid"]:GetAttribute('Found')));
        StatusKid.SquidKid:SetDesc("Is Founded: "..tostr(MissingKidTracker["SquidKid"]:GetAttribute('Found')));
        StatusKid.KoalaKid:SetDesc("Is Founded: "..tostr(MissingKidTracker["KoalaKid"]:GetAttribute('Found')));
        Heartbeat:Wait()
    end,print)
end)

InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("Sylvia")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
Window:SelectTab(1)

if setfpscap then
    setfpscap(240)
end

print("Loading Success Took "..string.format("%.2f",tick() - LoadingTime).." secs")
Fluent:Notify({
    Title = "Sylvia",
    Content = "Loading Success Took "..string.format("%.2f",tick() - LoadingTime).." secs",
    Duration = 8
})
