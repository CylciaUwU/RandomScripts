--// Feel free to skid
--// I make ts readable? maybe

local LoadingTime = tick()
if not game:IsLoaded() then game.Loaded:Wait() end;

local StartTick = tick()
local UwU = loadstring(game:HttpGet("https://gist.githubusercontent.com/CylciaUwU/4ce60ba116cb52855f282a7f50b1866b/raw/864c18d9319cde98eac7a570cbcef1df857fe217/Fluent_Edited.luau"))();
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))();
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))();
local Options = UwU.Options
local Window = UwU:CreateWindow({
    Title = "Fisch | Unfinished - Version",
    SubTitle = "By Sylvia",
    TabWidth = 160,
    Size = UDim2.fromOffset(580,460),
    Acrylic = false, 
    Theme = "Darker",
    Transparency = false,
    MinimizeKey = Enum.KeyCode.RightShift,
})

--// Services
local Services={"Workspace","RunService","GuiService","UserInputService","Stats","SoundService","LogService","ContentProvider","Chat","MarketplaceService","Players","PointsService","ReplicatedFirst","VirtualUser","VirtualInputManager","StudioData","StarterPlayer","StarterPack","StarterGui","CoreGui","TextChatService","LocalizationService","JointsService","InsertService","Debris","Instance","Selection","Lighting","CorePackages","NetworkClient","HttpService","Teams","ReplicatedStorage","TestService","PolicyService","RbxAnalyticsService"};
local empty_table = {Services = {}}
local _RealPath = function(path, method, ...)
    local args = {...}
    return path[method](path, unpack(args))
end
for i, v in pairs(Services) do
    empty_table.Services[v] = _RealPath(game, "GetService", v)
end
for i, v in pairs(empty_table.Services) do
    local ServiceName = tostring(v.ClassName):gsub(" ", "")
    getgenv()[ServiceName] = v
end

--// Variables
local LocalPlayer, PlayersGui, Sylviafem = Players.LocalPlayer, Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui"), {} -- that all, yes
Sylviafem.__index = Sylviafem
local Heartbeat, Stepped, RenderStepped = RunService.Heartbeat, RunService.Stepped, RunService.RenderStepped
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local events = ReplicatedStorage:FindFirstChild("events")
local IsComputer = UserInputService.KeyboardEnabled and UserInputService.MouseEnabled; --[[do
    if not (IsComputer) or table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform()) then
        return LocalPlayer:Kick("No Supported to Mobile. Sry >:3c")
    end
end
--]]

--// Debug
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

spawn(function()
    debugwarn("Anti Idled Start")
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
            VirtualUser:Button2Down(Vector2.new(0,0),Workspace.Camera.CFrame)
            wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0),Workspace.Camera.CFrame)
        end)
    end
end)

function Sylviafem:getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end
function Sylviafem:getRootPart()
    return self:getCharacter():FindFirstChild("HumanoidRootPart")
end
function Sylviafem:getHumanoid()
    return self:getCharacter():FindFirstChild("Humanoid")
end

function Sylviafem:GetNameToolTP() -- fisch
    local focnfige = "fisch"
    local emptyName
    for _,v in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == focnfige then
            emptyName = v.Name
            break
        end
    end
    for _,v in ipairs(LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == focnfige then
            emptyName = v.Name
            break
        end
    end
    return emptyName
end
function Sylviafem:EquipTools()
    local getName = self:GetNameToolTP()
    local WhereIs = LocalPlayer.Backpack:FindFirstChild(getName) or self:getCharacter():FindFirstChild(getName)
    local InBackpack = WhereIs.Parent == LocalPlayer.Backpack
    local InCharacter = WhereIs.Parent == self:getCharacter()
    if WhereIs and self:getCharacter() then
        if InCharacter then
            return true
        elseif InBackpack then
            self:getHumanoid():EquipTool(WhereIs);debugwarn("Equip Rod")
        end
    end
end

-- Config
local Settings = {
    autoShake = false,
    -- ShakeDelay = 0,
    autoShakeMethod = "Signal", -- KeyCodeEvent,Signal

    autoReel = false,
    AutoReelMethod = "Instant", -- Instant,Smooth

    AutoCast = false,

    AutoCastMode = "Blatant", -- Legit,Blatant

    AutoFish = false,

    AntiDrown = true
}

local Tabs = {
    General = Window:AddTab({Title = "Main", Icon = "component"}),
    Settings = Window:AddTab({Title = "Settings", Icon = "settings"}),
}

MainGeneral = Tabs.General:AddSection('Main'); do
    local EnableAutoShake = MainGeneral:AddToggle("EnableAutoShake", {Title = "Auto Shake", Description = "Automatically shake buttons for you" ,Default = false})
    EnableAutoShake:OnChanged(function(v)
        Settings.autoShake = v
    end)
    local ShakeMethod = MainGeneral:AddDropdown("autoShakeMethod", {
        Title = "Shake Method",
        Values = {"KeyCodeEvent", "Signal"},
        Multi = false,
        Default = 1,
    })
    ShakeMethod:SetValue("Signal")
    ShakeMethod:OnChanged(function(v)
        Settings.autoShakeMethod = v
    end)

    local EnableAutoReel = MainGeneral:AddToggle("EnableAutoReel", {Title = "Auto Reel", Description = "Automatically reels in the fishing rod" ,Default = false})
    EnableAutoReel:OnChanged(function(v)
        Settings.autoReel = v
    end)
    local ReelMethod = MainGeneral:AddDropdown("ReelMethod", {
        Title = "Reel Method",
        Values = {"Instant", "Smooth"},
        Multi = false,
        Default = 1,
    })
    ReelMethod:SetValue("Instant")
    ReelMethod:OnChanged(function(v)
        Settings.AutoReelMethod = v
    end)
    local CastMethod = MainGeneral:AddDropdown("CastMethod", {
        Title = "Cast Method",
        Values = {"Blatant", "Legit"},
        Multi = false,
        Default = 1,
    })
    CastMethod:SetValue("Blatant")
    CastMethod:OnChanged(function(v)
        Settings.AutoCastMode = v
    end)

    local AutoFish = MainGeneral:AddToggle("AutoFish", {Title = "Auto Fish", Description = "" ,Default = false})
    AutoFish:OnChanged(function(v)
        Settings.AutoFish = v
        while Settings.AutoFish do task.wait()
            pcall(function()
                local Rod = Sylviafem:GetNameToolTP()
                local Char = Sylviafem:getCharacter()
                local RodInChar = Char:FindFirstChild(Rod)
                local Bobber = RodInChar:FindFirstChild("bobber")

                local ReelUi = PlayersGui:FindFirstChild("reel")
                local ShakeUi = PlayersGui:FindFirstChild("shakeui")

                -- Sylviafem:getHumanoid():EquipTool(LocalPlayer.Backpack:FindFirstChild(Rod))

                if not ShakeUi and not ReelUi then
                    if RodInChar and not Bobber then
                        -- Auto Throws Rod
                        debugwarn("Auto Throws Rod")
                        if Settings.AutoCastMode == "Legit" then
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, LocalPlayer, 0)
                            if Sylviafem:getRootPart():FindFirstChild("power") ~= nil and Sylviafem:getRootPart().power.powerbar.bar ~= nil then
                                if Sylviafem:getRootPart().power.powerbar.bar.Size == UDim2.new(1, 0, 1, 0) then
                                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, LocalPlayer, 0) return task.wait(.5)
                                end
                            end
                        elseif Settings.AutoCastMode == "Blatant" then
                            RodInChar["events"].cast:FireServer(math.random(95,100), 1)
                        end
                    end
                    elseif ShakeUi and Bobber and Settings.autoShake then
                        -- Auto Shake
                        debugprint("Auto Shake")
                            for _,v in ipairs(ShakeUi:FindFirstChild("safezone"):GetChildren()) do
                            if v:IsA("ImageButton") and v.Name == "button" and Settings.AutoFish and Settings.autoShake then
                                if Settings.autoShakeMethod == "KeyCodeEvent" then
                                    GuiService.SelectedObject = v
                                    if GuiService.SelectedObject == v then
                                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                                    end
                                elseif Settings.autoShakeMethod == "Signal" then
                                    replicatesignal(v.MouseButton1Click)
                                end
                            end
                        end
                    elseif ReelUi and Settings.autoReel then
                    -- Auto Reel
                    debugprint("Auto Reel")
                    repeat task.wait()
                        if Settings.AutoReelMethod == "Instant" then
                            events["reelfinished "]:FireServer(100, true)
                            pcall(function()
                                LocalPlayer.Character[Sylviafem:GetNameToolTP()].events.reset:FireServer()
                            end)
                        elseif Settings.AutoReelMethod == "Smooth" then
                            ReelUi.bar.playerbar.Position = UDim2.new(
                                ReelUi.bar.fish.Position.X.Scale, 
                                ReelUi.bar.fish.Position.X.Offset, 
                                ReelUi.bar.fish.Position.Y.Scale, 
                                ReelUi.bar.fish.Position.Y.Offset
                            )
                        end
                    until PlayersGui:FindFirstChild("reel") == nil or not PlayersGui:FindFirstChild("reel") or not Settings.AutoFish or not Settings.autoReel
                end
            end)
        end
    end)
end

local Old = os.time()
Settings_M = Tabs.Settings:AddSection("Misc") do
    local White_Screen = Settings_M:AddToggle("", {Title = "White Screen", Description = "only white screen" ,Default = false})
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
        Numeric = false,
        Finished = false,
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
                UwU:Notify({
                    Title = "Success.",
                    Content = "Teleporting Please wait",
                    Duration = 8
                })
            end
            if fail then
                UwU:Notify({
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
        UwU:Notify({
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
ToggleWhiteScreen = UserInputService.WindowFocusReleased:Connect(function()
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
ToggleWhiteScreen2 = UserInputService.WindowFocused:Connect(function()
    if getgenv().Disconnect then
        ToggleWhiteScreen2:Disconnect();ToggleWhiteScreen2 = nil
    end
    RunService:Set3dRenderingEnabled(true);
    if setfpscap then
        setfpscap(100)
    end
end)

-- block remote
spawn(function()
    local drown_Remote = events:WaitForChild("drown")
    local afk_Remote = events:WaitForChild("afk")

    local old={}

    old[1] = hookmetamethod(game,"__namecall",function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        if self == drown_Remote and Settings.AntiDrown and not checkcaller() then
            return wait(9e9)
        end
        return old[1](self,...)
    end)
    old[2] = hookmetamethod(game,"__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        if self == afk_Remote and method:lower() == "fireserver" and not checkcaller() then
            args[1] = false
            return old[2](self,unpack(args))
        end
        return old[2](self, ...)
    end)
end)

local Timer;Timer = Heartbeat:Connect(function()
    if getgenv().Disconnect then
        Timer:Disconnect();Timer = nil;
    end
    pcall(function()
        local TimeSinceLastPlay = os.time() - Old
        local hours = tostring(math.floor(TimeSinceLastPlay / 3600))
        local minutes = tostring(math.floor((TimeSinceLastPlay % 3600) / 60))
        local seconds = tostring(TimeSinceLastPlay % 60)
        Timeing:SetTitle("Server Joined "..hours.." H "..minutes.." M "..seconds.." S ")
        Heartbeat:Wait()
    end,print)
end)

InterfaceManager:SetLibrary(UwU)
InterfaceManager:SetFolder("SylviaIsFemboy")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
Window:SelectTab(1)

if setfpscap then
    setfpscap(240)
end

print("Loading Success Took "..string.format("%.2f",tick() - LoadingTime).." secs")
UwU:Notify({
    Title = "Fishy",
    Content = "Loading Success Took "..string.format("%.2f",tick() - LoadingTime).." secs",
    Duration = 8
})
