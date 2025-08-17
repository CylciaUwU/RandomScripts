_G.Tester = true
if getgenv().Syreiy and not _G.Tester == true then
    return
end

pcall(function() getgenv().Syreiy = true end);

getgenv().Disable_Connect = {}
if not game:IsLoaded() then game.Loaded:Wait() end; warn("Hello :3")
httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
getfenv = getfenv or debug.getfenv

local LoadingTime = tick();
local SendHttps = httprequest({
    Url = 'https://gist.githubusercontent.com/seria000/ea277c117164f82fb40016246ba6a9ad/raw/eb0502cf8ad85b70a7b24e92227f37e717eb8111/RepitationThread.luau',
    Method = "GET"
})
local SendHttps2 = httprequest({
    Url = 'https://gist.githubusercontent.com/seria000/4ce60ba116cb52855f282a7f50b1866b/raw/99adeed59d839b7beb7ccff8de6779599adb234e/Fluent.lua',
    Method = "GET"
})

local RepitationThread, Fluent = nil, nil;
if SendHttps.StatusCode == 200 then -- fix loading (loadsting)
    RepitationThread = getfenv().loadstring(SendHttps.Body)()
end
if SendHttps2.StatusCode == 200 then
    Fluent = getfenv().loadstring(SendHttps2.Body)()
end

local Options = Fluent.Options;
local Controller = RepitationThread.new();

local random = math.random;
local placeId, gameId = game["PlaceId"], game["GameId"]
local DetectionPlaceId = {
    ["Lobby"] = 79546208627805,
    ["Main"] = 126509999114328 -- main game
}
-- local virtualize = (function(...) return ... end);

function missing(t, f, fallback)
    if type(f) == t then return f end
    return fallback
end

cloneref = missing("function", cloneref, function(...) return ... end)
sethidden = missing("function", sethiddenproperty or set_hidden_property or set_hidden_prop)
gethidden = missing("function", gethiddenproperty or get_hidden_property or get_hidden_prop)
firetouchinterest = missing("function", firetouchinterest)
hookmetamethod = missing("function", hookmetamethod)
checkcaller = missing("function", checkcaller, function() return false end)

--// Services
local Players = cloneref(game:GetService("Players"));
local Lighting = cloneref(game:GetService("Lighting"));
local RunService = cloneref(game:GetService("RunService"));
local VirtualUser = cloneref(game:GetService("VirtualUser"));
local TeleportService = cloneref(game:GetService("TeleportService"));
local UserInputService = cloneref(game:GetService("UserInputService"));
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"));
local MarketplaceService = cloneref(game:GetService("MarketplaceService"));

local LocalPlayer = cloneref(Players.LocalPlayer);
local WsItems = workspace.Items
local RemoteEvents = ReplicatedStorage["RemoteEvents"];
local GameInfo = MarketplaceService:GetProductInfo(placeId).Name;
local ProximityPromptService = game:GetService("ProximityPromptService")
local Heartbeat, Stepped, RenderStepped, PreSimulation = RunService.Heartbeat, RunService.Stepped, RunService.RenderStepped, RunService.PreSimulation;
local IsOnMobile = table.find({Enum.Platform.Android, Enum.Platform.IOS}, UserInputService:GetPlatform());
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))();

local RemoteEventsCaller = {
    ["RequestOpenItemChest"] = RemoteEvents["RequestOpenItemChest"],
    ["RequestCollectCoints"] = RemoteEvents["RequestCollectCoints"],
    ["RequestCookItem"] = RemoteEvents["RequestCookItem"],
    ["RequestSetTrap"] = RemoteEvents["RequestSetTrap"],

    ["ToolDamageObject"] = RemoteEvents["ToolDamageObject"],
    ["CheckLightningDamage"] =  RemoteEvents["CheckLightningDamage"],
    ["NPCProjectileDamagePlayer"] = RemoteEvents["NPCProjectileDamagePlayer"]
}

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

while not LocalPlayer do
	wait()
	LocalPlayer = cloneref(Players.LocalPlayer)
end
tostr = function(...) 
    return tostring(...) 
end
local PreConfig = function(f, callback, tables)
    if getgenv()[f] == nil then
        getgenv()[f] = callback or false
    end

    if tables then --// if i have another idea(no), i will rewrite ts
        table.insert(tables, f)
        wait()
        if tables[f] == nil then
            tables[f] = callback or false
        end
    end
end

local Blacklist = {
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
function Restorelighting()
    spawn(function()
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
    end)
end
local Settings = {}; Settings.__index = Settings;
PreConfig("DamageAura", false, Settings);
PreConfig("Distance" , 25, Settings);
PreConfig("AutoTree", false, Settings);
PreConfig("AutoCookeMean", false, Settings);
PreConfig("NoFog", false, Settings);
PreConfig("SafePart", false, Settings);
PreConfig("WalkSpeed", false, Settings);
PreConfig("WalkSpeedVal", 16, Settings);
PreConfig("Noclip", false, Settings);
PreConfig("InfJump", false, Settings);
PreConfig("FullBright", false, Settings);
PreConfig("InstPrompts", false, Settings);
PreConfig("SetChildren", "Dino Kid", Settings);
PreConfig("SetSpectatePlr", {}, Settings);
PreConfig("SavePos", nil, Settings);
PreConfig("ResetTrap", false, Settings)

PreConfig("NoProjectileDamage", true, Settings)
PreConfig("NoLightningStrikeDamage", true, Settings)
PreConfig("AntiVoid", true, Settings);

local Character = {};
Character.__index = Character;

local ConverPosition = function(...)
    local Pos = {...};
    local SetectPos = Pos[1];
    local RealPos;
    if type(SetectPos) == "vector" then
		RealPos = CFrame.new(SetectPos)
	elseif type(SetectPos) == "userdata" then
		RealPos = SetectPos
	elseif type(SetectPos) == "number" then
		RealPos = CFrame.new(unpack(Pos))
	end
    return RealPos
end
function Character:getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end
function Character:getRoot()
    return self:getCharacter():FindFirstChild("HumanoidRootPart")
end
function Character:getHumnoid()
    return self:getCharacter():FindFirstChild("Humanoid") or self:getCharacter():FindFirstChildWhichIsA("Humanoid")
end
function Character:Teleport(Position)
    local checkpoint = ConverPosition(Position);
    if checkpoint then
        return self:getCharacter():PivotTo(checkpoint)
    end
end
function Character:ChangeSpeed(Val)
    if not Val then return end;

    local Humanoid = self:getHumnoid();
    if Humanoid then
        Humanoid["WalkSpeed"] = Val
    end
end

local Modules = {};
Modules.__index = Modules;
setmetatable(Modules, Character)

function Modules:getClosestMob()
    local dist = Settings.Distance or 1/0
    local closest_mob

    for _, v in pairs(game:GetService("Workspace")["Characters"]:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
            local Humanoid = v:FindFirstChildWhichIsA("Humanoid")
            if not table.find(Blacklist, v.Name:lower()) and Humanoid.Health > 0 then
                local Hum = v:FindFirstChild("HumanoidRootPart", true)
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
function Modules:ObjectDoesDamage()
    local Equipment;
    local Char = self:getCharacter();
    local Char_Equipped = Char:GetAttribute('Equipped');
    local Tools = Char:FindFirstChildOfClass("Model");
    local getWeaponDamage = Tools and Tools:GetAttribute('WeaponDamage');

    if not Tools then return end

    if tonumber(getWeaponDamage) > 1 then
        Equipment = Char_Equipped
        return Equipment
    end

    if Equipment == nil and Char then return debugprint("return nil, fix your shit now.") end

    return Equipment
end
function Modules:ObjectNormal()
    local Equipment;
    local Char = self:getCharacter();
    local Char_Equipped = Char:GetAttribute('Equipped');

    if type(Char_Equipped) == "string" then
        Equipment = Char_Equipped
        return Equipment
    end

    return Equipment
end
function Modules:DamageAura()
    local args = {}
    local ClosestEntity = self:getClosestMob();
    local WeaponName = self:ObjectDoesDamage();

    if ClosestEntity and WeaponName then
        local Success, Failed = pcall(function()
            args = {
                ClosestEntity,
                LocalPlayer.Inventory:FindFirstChild(WeaponName),
                "1_" .. LocalPlayer.UserId,
                ClosestEntity.HumanoidRootPart.CFrame
            }
        end)

        if not Success then return end;

        RemoteEventsCaller["ToolDamageObject"]:InvokeServer(unpack(args));
    end
end
function Modules:BringItems(Object, Once)
    local Hrp = Character:getRoot()
    for _,v in pairs(game:GetService("Workspace")["Items"]:GetChildren()) do
        if string.find(v.Name, Object) then
            if v:GetAttribute('Interaction') == "Item" and not v.Name:lower():find("rod") then
                -- v:PivotTo(Hrp:GetPivot() * CFrame.new(0, 6, 0))
                local store_table = {};
                table.insert(store_table, v);
                if #store_table >= 25 then --// anticrash
                    v:PivotTo(Hrp:GetPivot() * CFrame.new(0, 6, 0))
                    task.wait()
                else
                    v:PivotTo(Hrp:GetPivot() * CFrame.new(0, 6, 0))
                    if Once then
                        break
                    end
                end
            end
        end
    end
end
function Modules:FireTouchPart(Part : BasePart?)
	local TouchTransmitter = Part:FindFirstChildOfClass("TouchTransmitter")
	if not TouchTransmitter then return end

	local Root = self:getRoot()
    
    if Root and firetouchinterest then
        firetouchinterest(Root, Part, 0)
        firetouchinterest(Root, Part, 1) 
    end
end

local Window = Fluent:CreateWindow({
    Title = GameInfo.." | seria000",
    SubTitle = "Rewriting",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, 
    Theme = "Darker",
    Transparency = false,
    MinimizeKey = Enum.KeyCode.RightShift,
})

local _PlayerList = {}; do
    if #Players:GetPlayers() > 1 then
        for _,v in next, Players:GetPlayers() do
            if v ~= LocalPlayer then
                table.insert(_PlayerList, v.Name)
            end
        end
    end
end
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "component" }),
    Players = Window:AddTab({ Title = "Player", Icon = "user" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}
local TabMain = Tabs.Main:AddSection("Main") do
    ShowMePosition = TabMain:AddParagraph({
        Title = "Position : N/A"
    })
    TabMain:AddButton({
        Title = "Save Position",
        Description = "",
        Callback = function()
            xpcall(function()
                Settings.SavePos = Character:getRoot().CFrame;
                ShowMePosition:SetTitle("Position : " .. tostr(math.floor(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.X)) .. " X " .. tostr(math.floor(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Y)) .. " Y " .. tostr(math.floor(LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Z)) .. " Z")
            end,print)
        end
    })
    TabMain:AddButton({
        Title = "Teleport to saved position",
        Description = "",
        Callback = function()
            if not Settings.SavePos then
                Fluent:Notify({
                    Title = "SavePos is nil",
                    Content = "kys",
                    Duration = 8
                })
            end
            pcall(function()
                Character:Teleport(Settings.SavePos)
            end)
        end
    })
    Mainmark = TabMain:AddParagraph({ -- idk how to name this
        Title = "Main Tab Here"
    })
    local DistanceKillAuras = TabMain:AddSlider("Aura", {
        Title = "Distance Aura",
        Description = "",
        Default = 25,
        Min = 15,
        Max = 100,
        Rounding = 1,
        Callback = function(v)
            Settings.Distance = math.floor(v)
        end
    })
    DistanceKillAuras:OnChanged(function(v)
        Settings.Distance = math.floor(v)
    end)
    Options.Aura:SetValue(15)
    local DamageAura = TabMain:AddToggle("EnableAura", {Title = "Enable Aura", Description = "Damage is depending on your weapons equipment.", Default = false })
    DamageAura:OnChanged(function(v)
        Settings.DamageAura = v
    end)
    local FarmTree = TabMain:AddToggle("FarmTree", {Title = "Enable FarmTree", Description = "Equip axe first.", Default = false })
    FarmTree:OnChanged(function(v)
        Settings.AutoTree = v
    end)
    local AutoCookedItem = TabMain:AddToggle("AutoCookedItem", {Title = "Enable Cooked Meat", Description = "Steak, Morsel", Default = false })
    AutoCookedItem:OnChanged(function(v)
        Settings.AutoCookedItem = v
    end)
    local AutoResetTrap = TabMain:AddToggle("ResetTrap", {Title = "Enable Reset Trap", Description = "", Default = false })
    AutoResetTrap:OnChanged(function(v)
        Settings.AutoCookedItem = v
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
        Title = "Collect All Coin Stack",
        Description = "",
        Callback = function()
            pcall(function()
                for _,v in pairs(workspace.Items:GetChildren()) do
                    if string.find("coin stack", v.Name:lower()) then
                        RemoteEventsCaller["RequestCollectCoints"]:InvokeServer(v)
                    end
                end
            end)
        end
    })
end
viewing = {};
PreConfig("realpart", nil)
spawn(function()
    realpart = Instance.new("Part", workspace)
    realpart.Anchored = true;
    realpart.Size = Vector3.new(150, 1, 150);
    r = random(random(250, 300));
    cs = Vector3.new(5, 250, 5) + Vector3.new(0, r, 0);
    realpart.CFrame = CFrame.new(cs);
    realpart.Material = Enum.Material.ForceField
    realpart.Transparency = 1
end)
local tarrplr = Tabs.Players:AddSection() do
    if #Players:GetPlayers() > 1 then
        local PlayerList = tarrplr:AddDropdown("PlayerList", {
            Title = "Select Player",
            Values = _PlayerList,
            Multi = false,
            Default = 1,
        })
        Options.PlayerList:SetValue(false)
        PlayerList:OnChanged(function(v)
            -- Settings.SetPlayer = v
            pcall(function()
                viewing = Players[v]
            end)
        end)
        tarrplr:AddButton({
            Title = "Teleport to Players",
            Description = "",
            Callback = function()
                pcall(function()
                    Modules:Teleport(Players[viewing].Character.HumanoidRootPart.CFrame)
                end)
            end
        })
        SpectatePlayers = tarrplr:AddToggle("SpectatePlr", {Title = "Spectate", Default = false })
        SpectatePlayers:OnChanged(function(v)
            Settings.SetSpectatePlr = v
            if Settings.SetSpectatePlr then
                pcall(function()
                    Fluent:Notify({
                        Title = "Viewing",
                        Content = viewing.Name,
                        Duration = 3
                    })
                end)
            end
            repeat task.wait()
                pcall(function()
                    workspace.CurrentCamera.CameraSubject = viewing.Character
                end)
            until not Settings.SetSpectatePlr or not viewing or not viewing.Character or not viewing.Character:FindFirstChildWhichIsA("Humanoid")
            game:GetService("Workspace").Camera.CameraSubject = Character:getHumnoid()
        end)
        Options.SpectatePlr:SetValue(false)
    else
        tarrplr:AddParagraph({
            Title = "Disabled Function",
            Content = "You are the only player in this server. this function will useless, unless debug mode is on <3"
        })
    end
    local SetSpeed = tarrplr:AddSlider("", {
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
    local ToggleWalkSpeed = tarrplr:AddToggle("", {Title = "Enable WalkSpeed", Default = false })
    ToggleWalkSpeed:OnChanged(function(v)
        Settings.WalkSpeed = v
        if not Settings.WalkSpeed then
            Character:ChangeSpeed(16)
        end
    end)
    local SafePart = tarrplr:AddToggle("SafePart", {Title = "Teleport to safe part", Description = "" ,Default = false })
    SafePart:OnChanged(function(v)
        Settings.Sefe_Part = v
        if Settings.Sefe_Part then
            task.defer(function() --// make sure to save old position first
                oldpos = Character:getRoot().CFrame
                Character:Teleport(realpart.CFrame * CFrame.new(0, 6, 0))
            end)
        else
            pcall(function()
                Modules:Teleport(oldpos);
                oldpos = nil;
            end)
        end
    end)
    local InfJump = tarrplr:AddToggle("", {Title = "Enable Infinite Jump", Default = false })
    InfJump:OnChanged(function(v)
        Settings.InfJump = v
    end)
    local FullBrights = tarrplr:AddToggle("", {Title = "Enable FullBright", Default = false })
    FullBrights:OnChanged(function(v)
        Settings.FullBright = v
        if not Settings.FullBright then
            pcall(function()
                spawn(Restorelighting)
            end)
        end
    end)
    local iyinstpp = tarrplr:AddToggle("", {Title = "Enable Instant Prompts", Default = false })
    iyinstpp:OnChanged(function(v)
        Settings.InstPrompts = v
    end)
    local Nocliplol = tarrplr:AddToggle("", {Title = "Enable Noclip", Default = false })
    Nocliplol:OnChanged(function(v)
        Settings.Noclip = v
    end)
end
do debugwarn("Ready? Create Threads In", tick() - LoadingTime, "secs") end
getgenv().Threads = nil; Threads = {};spawn(function() -- should be in another threads not in main
    local Caller = setmetatable({}, Modules);
    Caller.__index = Caller;

    Threads["DamageAura"] = Controller:newThread(nil, function()
        if Settings.DamageAura then
            pcall(function()
                Caller:DamageAura()
            end)
        end
    end)
    Threads["Tree"] = Controller:newThread(nil, function()
        if Settings.AutoTree then
            pcall(function()
                if Character:getRoot() then
                    for _,v in pairs(workspace["Map"]["Foliage"]:GetChildren()) do
                        if string.find(v.Name:lower(), "small tree") then
                            local args = {
                                v,
                                LocalPlayer.Inventory:FindFirstChild(Caller:ObjectNormal()),
                                "1",
                                CFrame.new()
                            }
                            RemoteEventsCaller["ToolDamageObject"]:InvokeServer(unpack(args))
                        end
                    end
                end
            end)
        end
    end)
    Threads["Cook"] = Controller:newThread(.1, function()
        if Settings.AutoCookedItem then
            pcall(function()
                for _,v in pairs(WsItems:GetChildren()) do
                    local IsCookable = v and v:GetAttribute('Cookable') == true
                    if IsCookable then
                        RemoteEventsCaller["RequestCookItem"]:FireServer(workspace.Map.Campground.MainFire, v)
                    end
                end
            end) 
        end
    end)
    Threads["Trap"] = Controller:newThread(nil, function()
        if Settings.ResetTrap then
            pcall(function()
                for i,v in pairs(workspace.Structures:GetChildren()) do
                    if v:isA("Model", true) then
                        local AnimalTrap = v:GetAttribute("Interaction") == "AnimalTrap"
                        local IsTrapSet = v:GetAttribute("TrapSet") == true

                        if not IsTrapSet and AnimalTrap and v then
                            RemoteEventsCaller.RequestSetTrap:FireServer(v)
                        end
                    end
                end
            end)
        end
    end)
    Threads["WalkSpeed"] = Controller:newThread(nil, function()
        if Settings.WalkSpeed and Settings.WalkSpeedVal then
            pcall(function()
                Character:ChangeSpeed(Settings.WalkSpeedVal)
            end)
        end
    end)
    Threads["FullBright"] = Controller:newThread(nil, function()
        if Settings.FullBright then
            pcall(function()
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                if Lighting.ColorCorrection.Enabled then
                    Lighting.ColorCorrection.Enabled = false
                end
            end)
        end
    end)

    Threads["ClientSide"] = Controller:newThread(nil, function()
        if setscriptable then
            setscriptable(LocalPlayer, "SimulationRadius", true)
        end
        if sethidden then
            sethidden(LocalPlayer, "SimulationRadius", math.huge)
            sethidden(LocalPlayer, "MaxSimulationRadius", math.huge) 
        end
    end)
end)
spawn(function()
    Disable_Connect.autoRemoveThreads = Heartbeat:Connect(function()
        spawn(function()
            if Disable_Connect == nil then
                for _,v in pairs(Threads) do
                    Controller:removeThread(v)
                end
            end
        end)
        Heartbeat:Wait()
    end)
end)
spawn(function()
    debugprint("Created instprompts")
    Disable_Connect.PromptButtonHoldBegan = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
        if Settings.InstPrompts and Character:getCharacter() and fireproximityprompt and prompt then
            fireproximityprompt(prompt)
        end
    end)
end)
spawn(function()
    debugprint("Created infjump")
    getgenv().Disable_Connect.infjp = UserInputService.InputBegan:Connect(function(iobj, gp)
        if not gp and Settings.InfJump then
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
end)
local lastpos;
local PartDestroyHeight = game:GetService("Workspace").FallenPartsDestroyHeight;
spawn(function()
    debugprint("Created antivoid")
    getgenv().Disable_Connect.antifall = PreSimulation:Connect(function()
        local Root = Character:getRoot()
        local Humanoid = Character:getHumnoid()

        lastpos = Humanoid.FloorMaterial ~= Enum.Material.Air and Root.Position or lastpos
        if Settings.AntiVoid and (Root.Position.Y + (Root.Velocity.Y * 0.016)) <= (PartDestroyHeight + 10) then
            lastpos = lastpos or Vector3.new(Root.Position.X, (PartDestroyHeight + 20), Root.Position.Z)
            Root.CFrame += (lastpos - Root.Position)
            Root.Velocity *= Vector3.new(1, 0, 1)
            debugprint("Player was falled", lastpos)
        end
    end)
end)
local toUndo = {}
spawn(function()
    debugprint("Created noclip")
    getgenv().Disable_Connect.Noclip = Stepped:Connect(function()
        local Char = Character:getCharacter()
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
spawn(function()
    debugprint("Created antiafk")
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)
task.spawn(function()
    if placeId == DetectionPlaceId.Lobby then
        return LocalPlayer:Kick("Lobby detected. Please join the actual game.")
    elseif placeId == DetectionPlaceId.Main then
        loadstring([[
            local a=os.date("*t");if a.hour>=3 and a.hour<5 then local b=Instance.new("ScreenGui",game:GetService("CoreGui"))local c=Instance.new("ImageLabel",b)c.Size=UDim2.new(1,0,1,0)c.Image="rbxassetid://9419562118"task.wait(3)c:Destroy()else return print(":<")end
        ]])()
    end
end)
local NPCProjectileDamagePlayer = RemoteEventsCaller.NPCProjectileDamagePlayer
local CheckLightningDamage = RemoteEventsCaller.CheckLightningDamage
spawn(function()
    local old = {};
    old[1] = hookmetamethod(game,"__namecall", function(self, ...)
        if Settings.NoProjectileDamage and getnamecallmethod() == "FireServer" and typeof(self) == "Instance" and self == NPCProjectileDamagePlayer and not checkcaller() then
            local ev = Instance.new("BindableEvent")
            return ev.Event:Wait()
        end
        return old[1](self, ...)
    end)
    old[2] = hookmetamethod(game, "__namecall", function(self, ...)
        if Settings.NoLightningStrikeDamage and getnamecallmethod() == "FireServer" and self == CheckLightningDamage and not checkcaller() then
            return
        end
        return old[2](self, ...)
    end)
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
