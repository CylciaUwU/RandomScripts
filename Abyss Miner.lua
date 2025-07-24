if getgenv().Syreiy and not _G.DEBUG == true then
    return
end

pcall(function() getgenv().Syreiy = true end);
if not game:IsLoaded() then game.Loaded:Wait() end; warn("Hello :3")

function missing(t, f, fallback)
    if type(f) == t then return f end
    return fallback
end

cloneref = missing("function", cloneref, function(...) return ... end)
-- firetouchinterest = missing("function", firetouchinterest)1
hookmetamethod = missing("function", hookmetamethod)
checkcaller = missing("function", checkcaller, function() return false end)

local LoadingTime = tick();
local Modules = {};
Modules.__index = Modules;

local Settings = {
    HitBoxAura = false,
}

local RepitationThread = loadstring(game:HttpGet("https://gist.githubusercontent.com/CylciaUwU/ea277c117164f82fb40016246ba6a9ad/raw/eb0502cf8ad85b70a7b24e92227f37e717eb8111/RepitationThread.luau"))();
local Controller = RepitationThread.new();

local Players = cloneref(game:GetService("Players"));
local LocalPlayer = cloneref(Players.LocalPlayer);
local RunService = cloneref(game:GetService("RunService"));
local TeleportService = cloneref(game:GetService("TeleportService"));
local VirtualUser = cloneref(game:GetService("VirtualUser"));
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"));

local Heartbeat, Stepped, RenderStepped, PreSimulation = RunService.Heartbeat, RunService.Stepped, RunService.RenderStepped, RunService.PreSimulation;
local NO_VIRTUALIZE = (function(...) return ... end);

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))();
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))();
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

function Modules:getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end
function Modules:getRoot()
    return self:getCharacter():FindFirstChild("HumanoidRootPart");
end
function Modules:getHumanoid()
    return self:getCharacter():WaitForChild("Humanoid") or self:getCharacter():FindFirstChildWhichIsA("Humanoid")
end

function Modules:getMainToolData()
    local _Power, _Type, _pickaxeId, _Cooldown

    local Backpack = LocalPlayer:FindFirstChild("Backpack")
    local Character = self:getCharacter()

    for _,v in pairs(Backpack:GetChildren()) do
        if v:IsA("Tool") and v:GetAttribute('toolAdded') and v.Name == "Main Tool" then
            _Cooldown = v["CoolDown"].Value
            _Power = v["Power"].Value
            _Type = v["Type"].Value
            _pickaxeId = v["pickaxeId"].Value
        end
    end
    for  _,v in ipairs(Character:GetDescendants()) do
        if v:IsA("Tool") and v:GetAttribute('toolAdded') and v.Name == "Main Tool" then
            _Cooldown = v["CoolDown"].Value
            _Power = v["Power"].Value
            _Type = v["Type"].Value
            _pickaxeId = v["pickaxeId"].Value
        end
    end

    return _Power, _Type, _pickaxeId, _Cooldown
end
function Modules:InitializeHitbox()
    local Power, Type, PickaxeId, Cooldown = self:getMainToolData();
    
    local args = {
        Power,
        Type,
        false, -- Is Climbing
        PickaxeId,
        Cooldown
    }

    ReplicatedStorage:WaitForChild("RemoteEvent"):WaitForChild("HitBox"):FireServer(unpack(args))
end

local Window = Fluent:CreateWindow({
    Title = "Abyss Miner | Developing",
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
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local TabMain = Tabs.Main:AddSection("Main") do
    local Firehitbox = TabMain:AddToggle("", {Title = "Fire PickAxe", Default = false })
    Firehitbox:OnChanged(function(v)
        Settings.HitBoxAura = v
    end)
end

local Threads = {};
do
    Threads[1] = Controller:newThread(nil, function()
        pcall(function()
            if Settings.HitBoxAura then
               Modules:InitializeHitbox();
            end
        end)
    end)
end

local old = {};
local Banned = LocalPlayer.HiddenStats.Banned;
local MaxWeight = LocalPlayer.HiddenStats.MaxWeight
local UpdateWalkspeed = ReplicatedStorage:WaitForChild("UpdateWalkspeed");

do
    old[1] = hookmetamethod(game, "__index", function(self, Value)
        if self == Banned and self:IsA("BoolValue") and Value == "Value" and not checkcaller() then
            return false
        end
        return old[1](self, Value)
    end)
    old[2] = hookmetamethod(game, "__index", function(self, Value)
        if self == MaxWeight and Value == "Value" and not checkcaller() then
            return math.huge
        end
        return old[2](self, Value)
    end)
    old[3] = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod();

        if self == UpdateWalkspeed and method:lower() == "fireserver" and not checkcaller() then
            args[1] = 16
            return old[3](self, unpack(args))
        end
        return old[3](self, ...)
    end)
end

local ToDisable = {
    "CursedLayer",
    "EnvironmetEffect",
    "ScreenShake"
}
spawn(function()
    while task.wait(.1) do
        pcall(function()
            for _,v in pairs(Modules:getCharacter():GetDescendants()) do
                if v:IsA("LocalScript") then
                    if table.find(ToDisable, v.Name) then
                        if v.Disabled ~= true then
                            v.Disabled = true
                        end
                    end
                end
            end
        end)
    end
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

local Timer;Timer = Heartbeat:Connect(function()
    pcall(function()
        local TimeSinceLastPlay = os.time() - Old
        local hours = tostring(math.floor(TimeSinceLastPlay / 3600))
        local minutes = tostring(math.floor((TimeSinceLastPlay % 3600) / 60))
        local seconds = tostring(TimeSinceLastPlay % 60)
        Timeing:SetTitle("Server Joined "..hours.." H "..minutes.." M "..seconds.." S ")
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