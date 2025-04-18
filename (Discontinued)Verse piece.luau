--[[⊹˚₊‧───────────────‧₊˚*.·:·.☽✧ ✦ ✧☾.·:·.*₊‧───────────────‧₊˚⊹
 _____       _      _       _   _          _   _ 
/  __ \     | |    (_)     | | | |        | | | |
| /  \/_   _| | ___ _  __ _| | | |_      _| | | |
| |   | | | | |/ __| |/ _` | | | \ \ /\ / / | | |
| \__/\ |_| | | (__| | (_| | |_| |\ V  V /| |_| |
 \____/\__, |_|\___|_|\__,_|\___/  \_/\_/  \___/ 
        __/ |                                    
       |___/                                     

──────୨୧─────────* . °•★|•°∵ ♰ ∵°•|☆•° . *──────୨୧─────────


‧͙‧───────────────⁺˚*･༓☾✧ ✦ ✧☽༓･*˚⁺‧͙  ‧───────────────‧]]--

repeat task.wait() print("Waiting For Game Fully Load.") until game:IsLoaded() 
local LoadingTime = tick()

local cloneref = cloneref or function(...) return ... end;

--// Services //--
local Services = {
    ["CoreGui"] = cloneref(game:GetService("CoreGui")),
    ["Players"] = cloneref(game:GetService("Players")),
    ["UserInputService"] = cloneref(game:GetService("UserInputService")),
    ["TweenService"] = cloneref(game:GetService("TweenService")),
    ["HttpService"] = cloneref(game:GetService("HttpService")),
    ["MarketplaceService"] = cloneref(game:GetService("MarketplaceService")),
    ["RunService"] = cloneref(game:GetService("RunService")),
    ["TeleportService"] = cloneref(game:GetService("TeleportService")),
    ["StarterGui"] = cloneref(game:GetService("StarterGui")),
    ["GuiService"] = cloneref(game:GetService("GuiService")),
    ["ReplicatedStorage"] = cloneref(game:GetService("ReplicatedStorage")),
    ["VirtualUser"] = cloneref(game:GetService("VirtualUser")),
    ["VirtualInputManager"] = cloneref(game:GetService("VirtualInputManager")),
    ["TextChatService"] = cloneref(game:GetService("TextChatService")),
}

--// Variable //--
local Kurone = {} ; Kurone.__index = getgenv().Kurone or Kurone
local sethidden = sethiddenproperty or set_hidden_property or set_hidden_prop
local everyClipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
local random = math.random;
local char = string.char;

local LocalPlayer = Services["Players"].LocalPlayer
local PlayerGui = Services["Players"].LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
local IsComputer = Services["UserInputService"].KeyboardEnabled and Services["UserInputService"].MouseEnabled
local Remotes = Services["ReplicatedStorage"].Remotes
local Serverside = Remotes["Serverside"]
local VeNpc = workspace["Npc"]
-- local Notify = loadstring(game:HttpGet(('https://raw.githubusercontent.com/treeofplant/Notif/main/library.lua'),true))()
local Rarest_Ore = {
    "Tempest Ore",
    "Light Ore",
    "Limitbreak Stone",
    "Enhance Stone",
    "Gold",
    "Iron",
}

--// Import Megumint Utilities //--
local e = request or http_request
local a = e({
    Url = "https://gist.githubusercontent.com/CylciaUwU/30e45e7afd055ddbe643d7571b0d7850/raw/ca58f241c0aade24e298f763792647b48b1f0120/Repetator.luau",
    Method = "GET"
})
if a.StatusCode == 200 then
    MainThread = loadstring(a.Body)()
else
    LocalPlayer:Kick("Controller StatusCode 404")
end
local Controller = MainThread.new() ; print("Controller new")
if getgenv().Disconnect then
    getgenv().Disconnect = false
end
if setreadonly then
    setreadonly(task,false)
end
local charset = {};

for i = 48, 57 do
    table.insert(charset, char(i))
end;
for i = 65, 90 do
    table.insert(charset, char(i))
end;
for i = 97, 122 do
    table.insert(charset, char(i))
end;
function Kurone:RandomCharacters(length)
    if length > 0 then
        return Kurone:RandomCharacters(length - 1) .. charset[random(1, #charset)]
    else
        return ""
    end
end

--// Configuration Initializer

local Configuration ; if Configuration == nil then Configuration = {} end

local function AutoConfiguration(func,...)
    if Configuration[func] == nil or "" then
        Configuration[func] = ...
    end
end
function Kurone:SendKeyEvent(...)
    local VirIm = Services["VirtualInputManager"] or game:GetService("VirtualInputManager")
    local args={...}
    if type(args[1]) == "userdata" or "string" then
        local uv = game or LocalPlayer
        VirIm:SendKeyEvent(true,args[1],false,uv)
        VirIm:SendKeyEvent(false,args[1],false,uv)
    end
    return nil
end

--? <Archlypse Here>
AutoConfiguration("Distance",7.5)
AutoConfiguration("MethodFarm","Above")
AutoConfiguration("CustomAttack",true);
AutoConfiguration("SelectCustomAttack","Rowan");
AutoConfiguration("AutoFarm",false);
AutoConfiguration("AutoSkill",false);
AutoConfiguration("DelaySkill",2.5)
AutoConfiguration("SelectWeapon","Sword");
AutoConfiguration("TypeBossFarm",false);
AutoConfiguration("SelectBossType","Normal"); -- "Normal","Raid"
AutoConfiguration("CollentLoot",false); -- last update --//TODO
AutoConfiguration("Wisper",false); -- last update --//TODO
AutoConfiguration("Bring",true);
AutoConfiguration("Haki",true);
AutoConfiguration("RemoveEffects",true);
AutoConfiguration("InstantAtHealth",90);
AutoConfiguration("InstantKill",true);
AutoConfiguration("TypeMission","Jujutsu"); --- "Jujutsu","Hueco"
AutoConfiguration("AutoMission",false);

-- update
AutoConfiguration("Karun",false);
AutoConfiguration("JoJoD4c",false);

AutoConfiguration("FalledAngel",false);
AutoConfiguration("AutoMine",false);
AutoConfiguration("AutoSkeleton",false);

-- Stats
AutoConfiguration("SilderPoints",25);
AutoConfiguration("Strength",false);
AutoConfiguration("Defense",false);
AutoConfiguration("Sword",false);
AutoConfiguration("Special",false);

-- Exchange
AutoConfiguration("MaterialItems",{});
AutoConfiguration("AutoExchange",false);

AutoConfiguration("SelectIsland",{});
AutoConfiguration("SelectCombatSeller",{});
AutoConfiguration("SelectSwordSeller",{});
AutoConfiguration("MiscNpc",{});

AutoConfiguration("AutoStarkkLL",false);
AutoConfiguration("AutoRandomTrait",false);
AutoConfiguration("AutoRandomFruit",false);
AutoConfiguration("SelectGacha",{});
AutoConfiguration("GambleGacha",false);
AutoConfiguration("SelectSummonBoss",{});
AutoConfiguration("AutoSummonBoss",false);
AutoConfiguration("AutoWorldBoss",false);

-- PlaceId 119477642078428
AutoConfiguration("AutoDungeon",false);
AutoConfiguration("AutoReplay",false);
AutoConfiguration("GrabFruits",false);

-- if Archlypse then
--     return --("already loaded")
-- end

-- getgenv().Archlypse = true

do
    _G["$Alp"] = {
        -- isWindows = IsComputer, --UserInputService:GetPlatform() == Enum.Platform.Windows,
        TypeOs = (table.find({Enum.Platform.Windows}, Services["UserInputService"]:GetPlatform()) ~= nil and "Pc") or "Mb",
        SizeUi = (not IsComputer and UDim2.fromOffset(600, 300)) or UDim2.fromOffset(560, 600),
        AutoSize = true,
        TweenUiSize = true,
        SpeedTweenUi = 0.25,
        StyleTweenUi = Enum.EasingStyle.Quad,
        Mutiply = 1.80,
        SizeX = 550,
        SafePercent = 20,
        AnimationUiToggle = true
    }
    
    _G["$Alp"].SizeUi =
        (not IsComputer and UDim2.fromOffset(600, 300)) or UDim2.fromOffset(560, 600)
    if not IsComputer then
        if Services["CoreGui"]:FindFirstChild("UIBUTTON") then
            Services["CoreGui"]:FindFirstChild("UIBUTTON"):Destroy()
        end
    
        local TweenService = game:GetService("TweenService")
        local UserInputService = game:GetService("UserInputService")
        local UIBUTTON = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local ImageButton = Instance.new("ImageButton")
        local UICorner = Instance.new("UICorner")
        local UICorner_2 = Instance.new("UICorner")
    
        UIBUTTON.Name = "UIBUTTON"
        UIBUTTON.Parent = Services["CoreGui"]
        UIBUTTON.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
        Frame.Parent = UIBUTTON
        Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Frame.BorderSizePixel = 0
        Frame.Transparency = 1
        Frame.Position = UDim2.new(0.157012194, 0, 0.164366379, 0)
        Frame.Size = UDim2.new(0, 115, 0, 49)
    
        ImageButton.Parent = Frame
        ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ImageButton.BorderSizePixel = 0
        ImageButton.Active = true
        ImageButton.Draggable = true
        ImageButton.Position = UDim2.new(0.218742043, 0, -0.155235752, 0)
        ImageButton.Size = UDim2.new(0, 64, 0, 64)
    
        -- Set initial image to "open"
        ImageButton.Image = crypt.base64decode("cmJ4YXNzZXRpZDovLzk0MTk1NjIxMTg=") -- Open image asset ID
        local isOpen = true -- Variable to track the state
    
        ImageButton.MouseButton1Click:Connect(
            function()
                -- Animate the button size
                ImageButton:TweenSize(UDim2.new(0, 60, 0, 60), Enum.EasingDirection.In, Enum.EasingStyle.Elastic, 0.1)
                delay(
                    0.1,
                    function()
                        ImageButton:TweenSize(
                            UDim2.new(0, 64, 0, 64),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Elastic,
                            0.1
                        )
                    end
                )
    
                -- Toggle the image based on the state
                if isOpen then
                    ImageButton.Image = crypt.base64decode("cmJ4YXNzZXRpZDovLzk0MTk1NjIxMTg=") -- Replace with close image asset ID
                else
                    ImageButton.Image = crypt.base64decode("cmJ4YXNzZXRpZDovLzk0MTk1NjIxMTg=") -- Open image asset ID
                end
                isOpen = not isOpen -- Toggle the state

                -- Simulate key presses
                Services["VirtualInputManager"]:SendKeyEvent(true, "RightControl", false, game)
                Services["VirtualInputManager"]:SendKeyEvent(false, "RightControl", false, game)
                Services["VirtualInputManager"]:SendKeyEvent(true, "RightShift", false, game)
                Services["VirtualInputManager"]:SendKeyEvent(false, "RightShift", false, game)
                Services["VirtualInputManager"]:SendKeyEvent(true, "LeftControl", false, game)
                Services["VirtualInputManager"]:SendKeyEvent(false, "LeftControl", false, game)
            end
        )
    
        UICorner.CornerRadius = UDim.new(0, 100)
        UICorner.Parent = ImageButton
    
        UICorner_2.CornerRadius = UDim.new(0, 10)
        UICorner_2.Parent = Frame
    
        local UIS = UserInputService
        local frame = Frame
        local dragToggle = nil
        local dragSpeed = 0.25
        local dragStart = nil
        local startPos = nil
    
        local function updateInput(input)
            local delta = input.Position - dragStart
            local position =
                UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            game:GetService("TweenService"):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
        end
    
        frame.InputBegan:Connect(
            function(input)
                if
                    (input.UserInputType == Enum.UserInputType.MouseButton1 or
                        input.UserInputType == Enum.UserInputType.Touch)
                 then
                    dragToggle = true
                    dragStart = input.Position
                    startPos = frame.Position
                    input.Changed:Connect(
                        function()
                            if input.UserInputState == Enum.UserInputState.End then
                                dragToggle = false
                            end
                        end
                    )
                end
            end
        )
    
        UIS.InputChanged:Connect(
            function(input)
                if
                    input.UserInputType == Enum.UserInputType.MouseMovement or
                        input.UserInputType == Enum.UserInputType.Touch
                 then
                    if dragToggle then
                        Frame.Transparency = 1
                        updateInput(input)
                    else
                        Frame.Transparency = 1
                    end
                end
            end
        )
    end

end

spawn(function()
    if EnableAntiAFK or getgenv().EnableAntiAFK then return warn("already loaded antiidle/antiafk") end
    if not EnableAntiAFK or not getgenv().EnableAntiAFK then
        print("load antiIdle")
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
                Services["VirtualUser"]:CaptureController()
                Services["VirtualUser"]:Button2Down(Vector2.new(0,0),game:GetService("Workspace").Camera.CFrame)
                wait(1)
                Services["VirtualUser"]:Button2Up(Vector2.new(0,0),game:GetService("Workspace").Camera.CFrame)
            end)
        end
    end
end)

pcall(function() getgenv().EnableAntiAFK = true end)

if not getgenv().NameHandler == nil then
    return NameHandler
else
    getgenv().NameHandler = nil
end

if NameHandler == nil then
    NameHandler = {
        ["Client"] = {
            ["Velocity"] = Kurone:RandomCharacters(random(26,46)),
            ["FireButtonName"] = Kurone:RandomCharacters(random(8,16))
        },
        ["UISettings"] = {
            ["TabWidth"] = 160,
            ["Size"] = { 580, 460 },
            ["Theme"] = "Darker",
            ["Acrylic"] = false,
            ["Transparency"] = false,
            ["MinimizeKey"] = Enum.KeyCode.RightShift,
            ["AutoImport"] = true
        }
    }
end

function Kurone:GetChar()
    return Services["Players"].LocalPlayer.Character or Services["Players"].LocalPlayer.CharacterAdded:Wait()
end
function Kurone:GetRootPart()
    return Kurone:GetChar():FindFirstChild("HumanoidRootPart")
end
function Kurone:GetHumanoid()
    return Kurone:GetChar():FindFirstChild("Humanoid")
end
function Kurone:GetStatePlayers()
    return Kurone:GetHumanoid():GetState()
end
function Kurone:IsLocalPlayerDead()
    if Kurone:GetStatePlayers() ~= Enum.HumanoidStateType.Dead then
        return true
    else
        return task.wait()
    end
end
-- spawn(function()
--     if not PlayerGui:FindFirstChild(NameHandler.Client.FireButtonName) then
--         local VisibleUI = Instance.new("Frame",PlayerGui)
--         VisibleUI.Name = NameHandler.Client.FireButtonName
--         VisibleUI.BackgroundTransparency = 1
--         PlayerGui.SelectionImageObject = VisibleUI
--     end
-- end)
local FireClickButton = (function(...)
    if not ... then return end;
    local ui = {...} if ui[1] and ui[1] ~= nil or "" then Services["GuiService"].SelectedObject = ui[1] end
    task.defer(function()
        Kurone:SendKeyEvent(Enum.KeyCode.Return)
        if Services["GuiService"].SelectedObject == ui[1] then
            task.spawn(function()
                -- game:GetService("RunService").Heartbeat:Wait()
                Services["RunService"].Stepped:Wait()
                Services["GuiService"].SelectedObject = nil
            end)
        end
    end)
end)
-- function Kurone:EquipWeapon(...) -- local EquipWeapon = (function(...) end)
--     if type(...) == "nil" then return end
--     if type(...) == "string" then
--         local Get = {...}
--         if Get[1] and Get[1] ~= "" then
--             if LocalPlayer["Backpack"]:FindFirstChild(tostring(Get[1])) then
--                 local tool = LocalPlayer["Backpack"]:FindFirstChild(tostring(Get[1]))
--                 game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
--             end
--         else
--             task.spawn(function()
--                 for i ,v in ipairs(LocalPlayer["Backpack"]:GetChildren()) do
--                     if v:IsA("Tool") then
--                         if v:FindFirstChild(Configuration.SelectWeapon) then
--                             ToolSe = v.Name
--                         end
--                     end
--                 end
--                 for i ,v in ipairs(LocalPlayer.Character:GetChildren()) do
--                     if v:IsA("Tool") then
--                         if v:FindFirstChild(Configuration.SelectWeapon) then
--                             ToolSe = v.Name
--                         end
--                     end
--                 end
--                 local function Fired()
--                     if LocalPlayer["Backpack"]:FindFirstChild(ToolSe) then
--                         local tool = LocalPlayer["Backpack"]:FindFirstChild(ToolSe)
--                         LocalPlayer.Character.Humanoid:EquipTool(tool)
--                     elseif LocalPlayer.Character:FindFirstChild(ToolSe) then
--                         local tool = LocalPlayer.Character:FindFirstChild(ToolSe)
--                         if NeedFireTool and not Configuration.CustomAttack then
--                             tool:Activate()
--                         end
--                     end 
--                 end
--                 Fired()
--             end)
--         end
--     end
-- end
function Kurone:EquipTool(gimmename)
    local foundedTool = LocalPlayer.Backpack:FindFirstChild(gimmename) or LocalPlayer.Character:FindFirstChild(gimmename)
    if foundedTool then
        if NeedFireTool and not Configuration.CustomAttack then
            LocalPlayer.Character.Humanoid:EquipTool(foundedTool)
            foundedTool:Activate()
        end
    end
end
function Kurone:EquipWeapon(cls)
    if not cls then return end
    if Kurone:IsLocalPlayerDead() then
        task.spawn(function()
            for _, v in ipairs(LocalPlayer.Backpack:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild(Configuration.SelectWeapon) then
                    IsFounded = v.Name
                    break
                end
            end
            for _, v in ipairs(LocalPlayer.Character:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild(Configuration.SelectWeapon) then
                    IsFounded = v.Name
                    break
                end
            end
        end)
    end
    local suc,fail = pcall(function()
        Kurone:EquipTool(IsFounded)
    end)
    if not suc then return end
    if fail then
        print(fail)
    end
end
function Kurone:EquipAndFire(callback)
    Kurone:EquipWeapon();

    if callback and Configuration.CustomAttack and NeedFireTool then
        task.spawn(function()
            callback()
        end)
    end
end
function Kurone:GiveMeInteger(Decimal) -- thank to Gemini(Ai)
	if type(Decimal) ~= "number" then
		return nil
	end
	return math.floor(Decimal)
end

local CanCollide = {}; 
local OldCanCollide = {};
local velocityHandlerName = NameHandler["Client"]["Velocity"];
-- local NoclipNotDup = tostring(random(15000,90324));

local Velocity

spawn(function()
    Velocity = Services["RunService"].Stepped:Connect(function()
        if getgenv().Disconnect and Velocity then Velocity:Disconnect(); Velocity = nil ;print("Velocity nil");LocalPlayer.DevCameraOcclusionMode = 0 end
		pcall(function()
            local HumNoid = Kurone:GetHumanoid();
            local HumNoidRoot = Kurone:GetRootPart();
            local isSitting = Kurone:GetStatePlayers() == Enum.HumanoidStateType.Seated
            if Configuration.AutoFarm or Configuration.TypeBossFarm or Configuration.AutoDungeon or Configuration.AutoMission or Configuration.AutoStarkkLL or Configuration.AutoWorldBoss or Configuration.JoJoD4c or Configuration.Karun or Configuration.FalledAngel or Configuration.AutoMine or Configuration.GambleGacha or Configuration.AutoSkeleton
            then
                if isSitting and HumNoid.Health ~= 0 then
                    HumNoid.Sit = false
                    if HumNoidRoot:FindFirstChild(velocityHandlerName) then
                        HumNoidRoot:FindFirstChild(velocityHandlerName):Destroy()
                    end
                end
                if LocalPlayer.DevCameraOcclusionMode ~= Enum.DevCameraOcclusionMode.Invisicam then LocalPlayer.DevCameraOcclusionMode = 1 end
                if not isSitting and HumNoid.Health > 0 then
                    for _,v in pairs(Kurone:GetChar():GetChildren()) do -- can't use GetDescendants , lag client
                        if v:IsA("BasePart") then
                            if CanCollide[v] == nil then
                                OldCanCollide[v] = v.CanCollide
                                CanCollide[v] = v.CanCollide
                            elseif CanCollide[v] ~= nil then
                                if CanCollide[v] ~= false then
                                    if Configuration.AutoFarm or Configuration.TypeBossFarm or Configuration.AutoDungeon or Configuration.AutoMission or Configuration.AutoStarkkLL or Configuration.AutoWorldBoss or Configuration.JoJoD4c or Configuration.Karun or Configuration.FalledAngel or Configuration.AutoMine or Configuration.GambleGacha or Configuration.AutoSkeleton
                                    then
                                        v.CanCollide = false
                                    else
                                        v.CanCollide = OldCanCollide[v]
                                    end
                                end
                            end 
                        end
                    end
                else
                    HumNoid.Sit = false
                end
                if not HumNoidRoot:FindFirstChild(velocityHandlerName) and not isSitting then
                    local bv = Instance.new("BodyVelocity",HumNoidRoot)
                    bv.Name = velocityHandlerName
                    bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                    bv.Velocity = Vector3.new(0,0,0)
                end
            else
                LocalPlayer.DevCameraOcclusionMode = 0
                if HumNoidRoot:FindFirstChild(velocityHandlerName) then
                    HumNoidRoot:FindFirstChild(velocityHandlerName):Destroy()
                end
            end
        end)
    end)
end)
function Kurone:chatMessage(str) -- by iy
    if not str then return end
    str = tostring(str)
    if Services["TextChatService"].ChatVersion == Enum.ChatVersion.TextChatService then
        Services["TextChatService"].TextChannels.RBXGeneral:SendAsync(str)
    else
        Services["ReplicatedStorage"].DefaultChatSystemChatEvents.SayMessageRequest:FireServer(str, "All")
    end
end
function Kurone:Checkcc()
    local Lv = LocalPlayer["PlayerData"]:WaitForChild("Levels").Value; -- this 1 line took me 10 min or more to find this directory. 
    if Lv == 1 or Lv <= 99 then
        NameMon, ParentMon , FolderMon , CQuest , GQuest = "Bandit [Lv.5]","Starter","Bandits","Bandit","Quest 1"
        CFrameQuest = CFrame.new(-178.983505, 12.5301752, -682.385864, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        CFrameMon = CFrame.new(-169, 30, -762)
    elseif Lv == 100 or Lv <= 299 then
        NameMon, ParentMon , FolderMon , CQuest , GQuest  = "Monkey [Lv.100]","Jungle","Monkey","Monkey","Quest 3"
        CFrameQuest = CFrame.new(899.858032, 19.1609154, -198.700684)
        CFrameMon = CFrame.new(1184.78076, 80.5796661, -111.953499)
    elseif Lv == 300 or Lv <= 599 then
        NameMon, ParentMon , FolderMon , CQuest , GQuest  = "Snow Bandit [Lv.300]","Snow","Snow Bandit","Snow Bandit","Quest 5"
        CFrameQuest = CFrame.new(-155.211319, 14.7363424, 842.84082)
        CFrameMon = CFrame.new(-71.8203964, 47.25354, 937.227234)
    elseif Lv == 600 or Lv <= 1499 then
        NameMon, ParentMon , FolderMon , CQuest , GQuest  = "Desert Thief [Lv.1000]","Desert","Desert Thief","Desert Thief","Quest 7"
        CFrameQuest = CFrame.new(1653.3457, 11.1776123, 1106.85156)
        CFrameMon = CFrame.new(1680.1897, 46.7697678, 1047.55347)
    elseif Lv == 1500 or Lv <= 2999 then
        NameMon, ParentMon , FolderMon , CQuest , GQuest  = "Marine Soldier [Lv.2000]","Shells","Marine Soldier","Marine Soldier","Quest 9"
        CFrameQuest = CFrame.new(-1379.34583, 33.6876259, 2011.48108)
        CFrameMon = CFrame.new(-1339.86304, 111.144882, 2115.10669)
    elseif Lv == 3000 or Lv <= 4999 then
        NameMon, ParentMon , FolderMon , CQuest , GQuest  = "Sorceror Student [Lv.3500]","Hidden","Sorceror Student","Sorceror Student","Quest 11"
        CFrameQuest = CFrame.new(2266.97803, 12.2214708, -934.243347)
        CFrameMon = CFrame.new(2304.38843, 47.2612686, -950.734009)
    elseif Lv == 5000 or Lv <= 7499 then
        NameMon, ParentMon , FolderMon , CQuest , GQuest  = "Black Thief [Lv.6000]","Frost","Frost Soldier","Frost Soldier","Quest 13"
        CFrameQuest = CFrame.new(-1616.59717, 17.2604561, 498.919006)
        CFrameMon = CFrame.new(-1649, 30, 482)
    elseif Lv == 7500 or Lv <= 10000 then
        NameMon, ParentMon , FolderMon , CQuest , GQuest  = "Vasto Lorde [Lv.7500]","Kurakura","Vasto Lorde","Vasto Lorde","Quest 15"
        CFrameQuest = CFrame.new(-1924.36707, 12.0268345, -2456.20117)
        CFrameMon = CFrame.new(-1938.41028, 35.906662, -2586.51465)
    end
end
function Kurone:GetDataMission()
    return LocalPlayer:WaitForChild("MissionData")["Quest"].Value
end
function Kurone:Teleport(_CFRAME_ : CFrame)
    local RootPart = Kurone:GetChar()
    RootPart:PivotTo(_CFRAME_)
end
function Kurone:IsBossSpawn()
    for _,v in pairs(workspace.Main.Boss:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChildWhichIsA("Humanoid").Health ~= 0 then
            return v
        end
    end
end
function Kurone:IsRaidBossSpawn()
    for _,v in pairs(workspace.Main.RaidBoss:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChildWhichIsA("Humanoid").Health ~= 0 then
            return v
        end
    end
end

--! Fields
local Fluent = nil
-- Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))();
Fluent = loadstring(game:HttpGet("https://gist.github.com/CylciaUwU/4ce60ba116cb52855f282a7f50b1866b/raw/f7f2f59272145614852f28d5659e1b7e4223518a/Fluent_Edited.luau"))();
SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Options = Fluent.Options
local success, latestVersionInfo = pcall(function() 
    local versionJson = game:HttpGet('https://gist.githubusercontent.com/Archlypse/c2aafa451b59e11b6ad0766acfde2898/raw/f7963da998e6ff693bc7aa18e46d5d11fe9d3582/version')
    return Services["HttpService"]:JSONDecode(versionJson)
end)

local Window = Fluent:CreateWindow({
    Title = "Verse Piece | Discontinued",
    SubTitle = "By Kurone",
    TabWidth = NameHandler["UISettings"]["TabWidth"],
    Size = UDim2.fromOffset(table.unpack(NameHandler["UISettings"]["Size"])),
    Acrylic = NameHandler["UISettings"]["Acrylic"], 
    Theme = NameHandler["UISettings"]["Theme"],
    Transparency = NameHandler["UISettings"]["Transparency"],
    MinimizeKey = NameHandler["UISettings"]["MinimizeKey"],
})
local Tap = {
    General = Window:AddTab({Title = "Main", Icon = "component"}),
    Updated = Window:AddTab({Title = "New Update", Icon = "calendar-range"}),
    Dungeon = Window:AddTab({Title = "Dungeon", Icon = "album"}),
    Stats = Window:AddTab({Title = "Stats", Icon = "align-left"}),
    Exchange = Window:AddTab({Title = "Auto Exchange", Icon = "signal-zero"}),
    Boss = Window:AddTab({Title = "Boss", Icon = "swords"}),
    Island = Window:AddTab({Title = "Teleport", Icon = "codepen"}),
    Automatic = Window:AddTab({Title = "Automatic", Icon = "bed"}),
    Miscs = Window:AddTab({Title = "Misc", Icon = "boxes"}),
    Settings = Window:AddTab({Title = "Settings", Icon = "settings"}),
}

spawn(function()
    xpcall(function()
        for _,v in pairs(VeNpc["Quest"]:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0
            end
        end
        for _,v in pairs(VeNpc["Quest"]["Mission 2"]:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0
            end
        end
        for i,v in pairs(VeNpc["Misc"]:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0
            end
        end
        for _,v in pairs(workspace["Main"]["Mission Quest"]:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0
            end
        end
        for _,v in pairs(workspace["Main"]["Mission Quest 2"]:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0
            end
        end
    end,print)
end)

CustomAttack = {};

do
    for _,v in pairs(Services["ReplicatedStorage"].Values.InventoryData.Sword:GetChildren()) do
        if v:IsA("BoolValue") then
            if v:FindFirstChildWhichIsA("BoolValue") then
                table.insert(CustomAttack, v.Name)
            end
        end
    end
    for _,v in pairs(Services["ReplicatedStorage"].Values.InventoryData.Combat:GetChildren()) do
        if v:IsA("BoolValue") then
            if v:FindFirstChildWhichIsA("BoolValue") then
                table.insert(CustomAttack, v.Name)
            end
        end
    end
end
function Kurone:InstantKill(Character)
    if Configuration.InstantKill then
        xpcall(function()
            if LocalPlayer:DistanceFromCharacter(Character.HumanoidRootPart.Position) <= 55 then
                local HealthMin = Character.Humanoid.MaxHealth*Configuration.InstantAtHealth/100
                if Character.Humanoid.Health <= HealthMin and not Character:FindFirstChild("Already") then
                    repeat task.wait()
                        if NeedFireTool ~= false then
                            NeedFireTool = false
                        end
                        Character.Humanoid:TakeDamage(math.huge)
                        if sethidden then
                            sethidden(LocalPlayer, "SimulationRadius", math.huge)
                        else
                            LocalPlayer.SimulationRadius = math.huge
                        end
                    until not Character.Parent or Character == nil
                end
            end
        end,print)
    end
end
function Kurone:BringReal(Character,CFrame)
    if Configuration.Bring then
        local Storage = {Character}
        for x,v in next, Storage do
            if v:FindFirstChild("Already") then
                Storage[v]:Destroy()
            end
            local HumanoidRe = v:FindFirstChildWhichIsA("Humanoid")
            local Animator = HumanoidRe:FindFirstChildWhichIsA("Animator")
            if CFrame then
                local hrp = Character:FindFirstChild("HumanoidRootPart");
                hrp.CFrame = CFrame
            end
            HumanoidRe:RemoveAccessories()
            HumanoidRe["JumpPower"] = 0
            HumanoidRe["WalkSpeed"] = 0
            HumanoidRe:ChangeState("PlatformStanding")
            if Animator then
                Animator:Destroy() 
            end
            if sethidden then
                sethidden(LocalPlayer, "SimulationRadius", math.huge)
            else
                LocalPlayer.SimulationRadius = math.huge
            end
        end
    end
end

Main = Tap.General:AddSection('Main'); do
    local _SelectWeapon = Main:AddDropdown("Dropdown", {
        Title = "Select Weapon",
        Values = {"Combat", "Sword"},
        Multi = false,
        Default = 1,
    })
    _SelectWeapon:SetValue("Sword")
    _SelectWeapon:OnChanged(function(v)
        Configuration.SelectWeapon = v
    end)
    local SelectCustomAttack = Main:AddDropdown("Dropdown", {
        Title = "Select Custom Weapon",
        Values = CustomAttack,
        Multi = false,
        Default = 1,
    })
    SelectCustomAttack:SetValue("Rowan")
    SelectCustomAttack:OnChanged(function(v)
        Configuration.SelectCustomAttack = v
    end)
    local CustomAttack = Main:AddToggle("", {Title = "Custom Weapon", Description = "Lag Warning", Default = true})
    CustomAttack:OnChanged(function(v)
        Configuration.CustomAttack = v
    end)
    local DistanceFarm = Main:AddSlider("Distance_Auto_Farm", {
        Title = "Distance Farm",
        Description = "",
        Default = 8.5,
        Min = 0,
        Max = 12,
        Rounding = 1,
        Callback = function(v)
            Configuration.Distance = v
        end
    })
    DistanceFarm:OnChanged(function(v)
        Configuration.Distance = v
    end)
    local MethodFarm = Main:AddDropdown("Dropdown", {
        Title = "Select Farm Method",
        Values = {"Above","Behind","Front","Below","RandomRotate"},
        Multi = false,
        Default = 1,
    })
    MethodFarm:SetValue("Above")
    MethodFarm:OnChanged(function(v)
        Configuration.MethodFarm = v
    end)
    local SliderKillAt = Main:AddSlider("Mob_Kill", {
        Title = "Instant Kill At",
        Description = "Kill Monster Heath %",
        Default = 90,
        Min = 0,
        Max = 100,
        Rounding = 1,
        Callback = function(v)
            Configuration.InstantAtHealth = v
        end
    })
    SliderKillAt:OnChanged(function(v)
        Configuration.InstantAtHealth = v
    end)
    local Instant_Kills = Main:AddToggle("", {Title = "Instant Kill", Description = "Improved" ,Default = true})
    Instant_Kills:OnChanged(function(v)
        Configuration.InstantKill = v
    end)
    -- local BringToggles = Main:AddToggle("", {Title = "Bring", Description = "" , Default = true})
    -- BringToggles:OnChanged(function(v)
    --     Configuration.Bring = v
    -- end)
    local HakiToggles = Main:AddToggle("", {Title = "Haki", Description = "No need to purchase haki" ,Default = true})
    HakiToggles:OnChanged(function(v)
        Configuration.Haki = v
    end)
    local RemoveEffects = Main:AddToggle("", {Title = "Remove Effects", Description = "Some particles not remove" ,Default = true})
    RemoveEffects:OnChanged(function(v)
        Configuration.RemoveEffects = v
    end)
    local AutoFarm = Main:AddToggle("", {Title = "AutoFarmLv", Description = " - Farming Until Levels Max(10,000) / Auto Accept Quest, Auto Cancel Quest, Check Quest" , Default = false})
    AutoFarm:OnChanged(function(v)
        Configuration.AutoFarm = v
    end)
    local CollentWisper = Main:AddToggle("", {Title = "Collent Wisper", Default = false})
    CollentWisper:OnChanged(function(v)
        Configuration.Wisper = v
    end)
    local SelectMissions = Main:AddDropdown("Dropdown", {
        Title = "Select Mission",
        Values = {"Jujutsu", "Hueco"},
        -- Description = "",
        Multi = false,
        Default = 1,
    })
    SelectMissions:SetValue("Jujutsu")
    SelectMissions:OnChanged(function(v)
        Configuration.TypeMission = v
    end)
    local AutoMission = Main:AddToggle("", {Title = "Auto Mission", Default = false})
    AutoMission:OnChanged(function(v)
        Configuration.AutoMission = v
    end)
end
Dungeon = Tap.Dungeon:AddSection('Main'); do
    if game.PlaceId == 119477642078428 then
        local Aut_Dungeon = Dungeon:AddToggle("", {Title = "Auto Dungeon", Description = "Instant kill only work with boss" ,Default = false})
        Aut_Dungeon:OnChanged(function(v)
            Configuration.AutoDungeon = v
        end)
        local Ayto_Reply = Dungeon:AddToggle("", {Title = "Auto Replay Dungeon", Description = "" ,Default = false})
        Ayto_Reply:OnChanged(function(v)
            Configuration.AutoReplay = v
        end)
        Dungeon:AddButton({
            Title = "Back To Main Game",
            Description = "",
            Callback = function()
                Window:Dialog({
                    Title = "Back To Main Game?",
                    Content = "",
                    Buttons = {
                        {
                            Title = "Confirm",
                            Callback = function()
                                local TS = Services["TeleportService"]
                                local Players = Services["Players"]
                                local placeID = 86639052909924
                                TS:Teleport(placeID, Players.LocalPlayer)
                            end
                        },
                        {
                            Title = "Cancel",
                            Callback = function()
                                print("Cancelled the dialog.")
                            end
                        }
                    }
                })
            end
        })
        Dungeon:AddButton({
            Title = "Join Random Server",
            Description = "1 player only",
            Callback = function()
                Window:Dialog({
                    Title = "Wanna Join Random Server?",
                    Content = "",
                    Buttons = {
                        {
                            Title = "Confirm",
                            Callback = function()
                                if #Services["Players"]:GetPlayers() <= 1 then
                                    LocalPlayer:Kick("\nWait a bit...")
                                    wait()
                                    Services["TeleportService"]:Teleport(game.PlaceId, LocalPlayer)
                                else
                                    Services["TeleportService"]:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
                                end
                            end
                        },
                        {
                            Title = "Cancel",
                            Callback = function()
                                print("Cancelled the dialog.")
                            end
                        }
                    }
                })
            end
        })
    else
        Dungeon:AddParagraph({
            Title = "Auto Dungeon 🟡",
            Content = "Only work in Dungeon"
        })
    end
end
function Kurone:CheckPickaxe()
    return LocalPlayer.PlayerData.Pickaxe.Value
end
function Kurone:GetRarestOre()
    if not Kurone:CheckPickaxe() then return end
    local ores = workspace.Main["Ore"]:GetChildren()
    for _, rarestOreName in ipairs(Rarest_Ore) do
        for _, ore in ipairs(ores) do
            if ore:FindFirstChild("Ore") and ore.Ore:IsA("StringValue") and ore.Ore.Value == rarestOreName then
                return ore
            end
        end
    end
    return nil
end
Update = Tap.Updated:AddSection('Last Update'); do
    local FalledAngel = Update:AddToggle("", {Title = "Auto Falled Angel", Description = "" ,Default = false})
    FalledAngel:OnChanged(function(v)
        Configuration.FalledAngel = v
    end)
    local Skeletone = Update:AddToggle("", {Title = "Auto Skeleton", Description = "" ,Default = false})
    Skeletone:OnChanged(function(v)
        Configuration.AutoSkeleton = v
    end)
    local AutoMining = Update:AddToggle("", {Title = "Auto Ore", Description = "Checking Priority / if not teleport to ore because you don't have pickaxe" ,Default = false})
    AutoMining:OnChanged(function(v)
        Configuration.AutoMine = v
    end)
    Update:AddParagraph({
        Title = "Iron  / 70.75%",
        Content = ""
    })
    Update:AddParagraph({
        Title = "Gold / 25%",
        Content = ""
    })
    Update:AddParagraph({
        Title = "Enhance Stone / 3%",
        Content = ""
    })
    Update:AddParagraph({
        Title = "Limitbreak Stone / 0.5%",
        Content = ""
    })
    Update:AddParagraph({
        Title = "Light Ore / 0.5%",
        Content = ""
    })
    Update:AddParagraph({
        Title = "Tempest Ore / 0.25%",
        Content = ""
    })
end
Stats = Tap.Stats:AddSection('Auto Stats'); do
    local StatsPoints = Stats:AddSlider("Slider", {
        Title = "Points",
        Description = "How many stats you want to add",
        Default = 25,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(v)
            Configuration.SilderPoints = Kurone:GiveMeInteger(v)
        end
    })
    StatsPoints:OnChanged(function(v)
        Configuration.SilderPoints = Kurone:GiveMeInteger(v)
    end)
    local Strength = Stats:AddToggle("", {Title = "Auto Strength", Description = "" ,Default = false})
    Strength:OnChanged(function(v)
        Configuration.Strength = v
    end)
    local Defense = Stats:AddToggle("", {Title = "Auto Defense", Description = "" ,Default = false})
    Defense:OnChanged(function(v)
        Configuration.Defense = v
    end)
    local Sword = Stats:AddToggle("", {Title = "Auto Sword", Description = "" ,Default = false})
    Sword:OnChanged(function(v)
        Configuration.Sword = v
    end)
    local Special = Stats:AddToggle("", {Title = "Auto Special", Description = "" ,Default = false})
    Special:OnChanged(function(v)
        Configuration.Special = v
    end)
end
MaterialTypeB = {}
Exchange = Tap.Exchange:AddSection(""); do
    local Material = Exchange:AddDropdown("Materialssee", {
        Title = "Select Material",
        Values = MaterialTypeB,
        Multi = false,
        Default = 1,
    })
    Options.Materialssee:SetValue(false)
    Material:OnChanged(function(v)
        Configuration.MaterialItems = v
    end)
    Exchange:AddButton({
        Title = "Update Dropdown",
        Description = "Opened Exchange Ui To Work",
        Callback = function()
            task.spawn(function()
                table.clear(MaterialTypeB)
                Options.Materialssee:SetValue(false)
            end)
            local suc,fail = pcall(function()    
                for _,v in pairs(PlayerGui:FindFirstChild("Exchange")["BG"]["Iinv"]["Material"]:GetChildren()) do
                    if v:IsA("Frame") then
                        table.insert(MaterialTypeB,v.Name)
                        Options.Materialssee:SetValue(MaterialTypeB)
                    end
                end
            end)
            if suc then
                Fluent:Notify({
                    Title = "Kurone",
                    Content = "Done Check Dropdown",
                    Duration = 8
                })
            end
            if fail then
                return (fail)
            end
        end
    })
    local AutoExchange = Exchange:AddToggle("", {Title = "Auto Exchange", Default = false })
    AutoExchange:OnChanged(function(v)
        Configuration.AutoExchange = v
    end)
    Exchange:AddButton({
        Title = "Telport To Exchange",
        Description = "",
        Callback = function()
            pcall(function()
                Kurone:Teleport(VeNpc.Misc.Exchange:GetModelCFrame())
            end)
        end
    })
end
table_boss_summon = {}
do
    for _,v in pairs(PlayerGui.Misc.Boss.Iinv.Stock:GetChildren()) do
        if v:IsA("TextButton") then
            table.insert(table_boss_summon,v.Name)
        end
    end
end
Boss = Tap.Boss:AddSection(""); do
    BossNormal = Boss:AddParagraph({
        Title = "Normal_Boss : Spawned",
        Content = "Name : N/A"
    })
    RaidBoss = Boss:AddParagraph({
        Title = "Raid_Boss : Spawned",
        Content = "Name : N/A"
    })
    local SelectTypeBossFarm = Boss:AddDropdown("Typeof Boss", {
        Title = "Select Type Boss",
        Values = {"Normal", "Raid"},
        Multi = false,
        Default = 1,
    })
    SelectTypeBossFarm:SetValue("Normal")
    SelectTypeBossFarm:OnChanged(function(v)
        Configuration.SelectBossType = v
    end)
    local AutoBossFarm = Boss:AddToggle("", {Title = "Auto Farm Boss", Default = false})
    AutoBossFarm:OnChanged(function(v)
        Configuration.TypeBossFarm = v
    end)
    ChestTimer = Boss:AddParagraph({
        Title = "Chest Timer",
        Content = "Count : N/A"
    })
    local CollentLoot = Boss:AddToggle("", {Title = "Collent Loots", Description = "Fast Loot",Default = false})
    CollentLoot:OnChanged(function(v)
        Configuration.CollentLoot = v
    end)
    local SelectSummonBoss = Boss:AddDropdown("Dropdown", {
        Title = "Select Summon",
        Values = table_boss_summon,
        Multi = false,
        Default = 1,
    })
    SelectSummonBoss:SetValue("Nil")
    SelectSummonBoss:OnChanged(function(v)
        Configuration.SelectSummonBoss = v
    end)
    local AutoSum = Boss:AddToggle("", {Title = "Auto Summon", Default = false })
    AutoSum:OnChanged(function(v)
        Configuration.AutoSummonBoss = v
    end)
    BossTicketToSummontotal = Boss:AddParagraph({
        Title = "Boss Ticket",
        Content = "Total : N/A"
    })
    local KillSumBoss = Boss:AddToggle("", {Title = "Auto World Boss", Description = "", Default = false })
    KillSumBoss:OnChanged(function(v)
        Configuration.AutoWorldBoss = v
    end)
    local D4C = Boss:AddToggle("", {Title = "Auto D4C", Description = "" ,Default = false})
    D4C:OnChanged(function(v)
        Configuration.JoJoD4c = v
    end)
    local karun1 = Boss:AddToggle("", {Title = "Auto Okarun", Description = "" ,Default = false})
    karun1:OnChanged(function(v)
        Configuration.Karun = v
    end)
    Summontotal = Boss:AddParagraph({
        Title = "Starkk (LL)",
        Content = "Total : N/A"
    })
    local StarkkLL = Boss:AddToggle("", {Title = "Auto Starkk (LL)", Description = "" ,Default = false})
    StarkkLL:OnChanged(function(v)
        Configuration.AutoStarkkLL = v
    end)
end
spawn(function()
    while wait() do if getgenv().Disconnect then break end
        pcall(function()
            if workspace.Main["Boss"]["Boss"].Value then
                BossNormal:SetDesc("Name : " .. Kurone:IsBossSpawn().Name .. " _:Health:_ " .. Kurone:IsBossSpawn().Humanoid.Health)
            else
                BossNormal:SetDesc("Boss is Not Spawn yet 🔴")
            end
            if workspace.Main["RaidBoss"]["Boss"].Value then
                RaidBoss:SetDesc("Name : " .. Kurone:IsRaidBossSpawn().Name .. " _:Health:_ " .. Kurone:IsRaidBossSpawn().Humanoid.Health)
            else
                RaidBoss:SetDesc("RaidBoss is Not Spawn yet 🔴")
            end
        end)
    end
end)

All_Islands = {}
All_Combats_Seller = {}
All_Swords_Seller = {}
_Misc = {}

do
    xpcall(function()
        for _,v in pairs(workspace:FindFirstChild("Region"):GetChildren()) do
            table.insert(All_Islands,v.Name)
        end
        for _,v in pairs(workspace:FindFirstChild("Npc"):WaitForChild("Combat"):GetChildren()) do
            table.insert(All_Combats_Seller,v.Name)
        end
        for _,v in pairs(workspace:FindFirstChild("Npc"):WaitForChild("Sword"):GetChildren()) do
            if v:IsA("Model") then
                table.insert(All_Swords_Seller,v.Name)
            end
        end
        for _,v in pairs(workspace:FindFirstChild("Npc"):WaitForChild("Misc"):GetChildren()) do
            if v:IsA("Model") then
                table.insert(_Misc,v.Name)
            end
        end
    end,print)
end

Teleport = Tap.Island:AddSection('Teleport'); do
    local SelectTeleporter = Teleport:AddDropdown("", {
        Title = "Select Island",
        Values = All_Islands,
        Multi = false,
        Default = 1,
    })
    SelectTeleporter:SetValue("Nil")
    SelectTeleporter:OnChanged(function(v)
        Configuration.SelectIsland = v
    end)
    Teleport:AddButton({
        Title = "Teleport/Island",
        Description = "",
        Callback = function()
            pcall(function()
                for i,v in pairs(workspace["Region"]:GetChildren()) do
                    if v.Name == Configuration.SelectIsland then
                        Kurone:Teleport(v.CFrame)
                    end
                end
            end)
        end
    })
    local SelectTeleporter2 = Teleport:AddDropdown("", {
        Title = "Combat Seller",
        Values = All_Combats_Seller,
        Multi = false,
        Default = 1,
    })
    SelectTeleporter2:SetValue("Nil")
    SelectTeleporter2:OnChanged(function(v)
        Configuration.SelectCombatSeller = v
    end)
    Teleport:AddButton({
        Title = "Teleport/Combat",
        Description = "",
        Callback = function()
            pcall(function()
                for i,v in pairs(VeNpc["Combat"]:GetChildren()) do
                    if v:IsA("Model") and v.Name == Configuration.SelectCombatSeller then
                        Kurone:Teleport(v:GetModelCFrame())
                    end
                end
            end)
        end
    })
    local SelectTeleporter3 = Teleport:AddDropdown("", {
        Title = "Sword Seller",
        Values = All_Swords_Seller,
        Multi = false,
        Default = 1,
    })
    SelectTeleporter3:SetValue("Nil")
    SelectTeleporter3:OnChanged(function(v)
        Configuration.SelectSwordSeller = v
    end)
    Teleport:AddButton({
        Title = "Teleport/Sword",
        Description = "",
        Callback = function()
            pcall(function()
                for i,v in pairs(VeNpc["Sword"]:GetChildren()) do
                    if v:IsA("Model") and v.Name == Configuration.SelectSwordSeller then
                        Kurone:Teleport(v:GetModelCFrame())
                    end
                end
            end)
        end
    })
    local SelectTeleporter4 = Teleport:AddDropdown("", {
        Title = "npc",
        Values = _Misc,
        Multi = false,
        Default = 1,
    })
    SelectTeleporter4:SetValue("Nil")
    SelectTeleporter4:OnChanged(function(v)
        Configuration.MiscNpc = v
    end)
    Teleport:AddButton({
        Title = "Teleport/Npc",
        Description = "",
        Callback = function()
            pcall(function()
                for i,v in pairs(VeNpc["Misc"]:GetChildren()) do
                    if v:IsA("Model") and v.Name == Configuration.MiscNpc then
                        Kurone:Teleport(v:GetModelCFrame())
                    end
                end
            end)
        end
    })
    Teleport:AddButton({
        Title = "Adventure Shop",
        Description = "",
        Callback = function()
            pcall(function()
                if VeNpc["Adventure Shop"]["Spawn"].Value then
                    Kurone:Teleport(VeNpc["Adventure Shop"]["Adventure Shop"]:GetModelCFrame())
                else
                    Fluent:Notify({
                        Title = "Kurone's Notify",
                        Content = "Adventure Shop not spawn yet",
                        SubContent = "", -- Optional
                        Duration = 5 -- Set to nil to make the notification not disappear
                    })
                end
            end)
        end
    })
    Teleport:AddButton({
        Title = "Shusui Seller",
        Description = "",
        Callback = function()
            pcall(function()
                Kurone:Teleport(workspace.Npc["Shusui Seller"]:GetModelCFrame())
            end)
        end
    })
end
Auto = Tap.Automatic:AddSection('Automatic'); do
    local GachaType = Auto:AddDropdown("Gacha", {
        Title = "Select Gacha",
        Values = {"Hakari","Higuruma","Zangetus/Starkk"},
        Multi = false,
        Default = 1,
    })
    GachaType:SetValue("Hakari")
    GachaType:OnChanged(function(v)
        Configuration.SelectGacha = v
    end)
    JoKerCard = Auto:AddParagraph({
        Title = "Joker Card",
        Content = "Total : N/A"
    })
    GUnBarrel = Auto:AddParagraph({
        Title = "Gun Barrel [Starkk]",
        Content = "Total : N/A"
    })
    local GambleGacha = Auto:AddToggle("", {Title = "Auto Gamble", Description = "" ,Default = false})
    GambleGacha:OnChanged(function(v)
        Configuration.GambleGacha = v
    end)
end
Misc = Tap.Miscs:AddSection(''); do
    Misc:AddButton({
        Title = "Redeem all code",
        Description = "",
        Callback = function()
            pcall(function()                
                for _,v in ipairs(LocalPlayer["CodeData"]:GetChildren()) do
                    if v:IsA("BoolValue") and not v.Value then
                        Kurone:chatMessage("!code "..v.Name)
                    end
                end
            end)
        end
    })
    local AutoGrabFruits = Misc:AddToggle("", {Title = "Auto Grab/Bring Fruits", Description = "in dev" ,Default = false})
    AutoGrabFruits:OnChanged(function(v)
        Configuration.GrabFruits = v
    end)
    Misc:AddButton({
        Title = "Title Equipment",
        Description = "",
        Callback = function()
            pcall(function()
                PlayerGui.HUD.Title.Visible = not PlayerGui.HUD.Title.Visible
            end)
        end
    })
    Misc:AddButton({
        Title = "Haki Color",
        Description = "",
        Callback = function()
            pcall(function()
                PlayerGui.HUD.Haki.Visible = not PlayerGui.HUD.Haki.Visible
            end)
        end
    })
end

--// Settings tabs
local Old = os.time()

Settings_M = Tap.Settings:AddSection("Misc") do
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
                Services["TeleportService"]:TeleportToPlaceInstance(game.PlaceId, tostring(SaveJobId) , game.Players.LocalPlayer)
            end)
            if suc then
                Fluent:Notify({
                    Title = "Kurone: Success.",
                    Content = "Teleporting Please wait",
                    Duration = 8
                })
            end
            if fail then
                Fluent:Notify({
                    Title = "Kurone : Failed to Teleport.",
                    Content = "make sure to enter not just click",
                    Duration = 8
                })
            end
        end
    })
    Settings_M:AddButton({
    Title = "Copy Your Job Id",
    Callback = function()
        everyClipboard(tostring(game.JobId))
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
            local TeleportService = Services["TeleportService"]
            --TeleportService:Teleport(game.placeId, game.jobId, game.Players.LocalPlayer)
            if #Services["Players"]:GetPlayers() <= 1 then
                Services["Players"].LocalPlayer:Kick("\nRejoining...")
                wait()
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            else
                TeleportService:TeleportToPlaceInstance(game.placeId, game.jobId, LocalPlayer)
            end
        end,
    })
end

local sadksafjkzxss

spawn(function()
    sadksafjkzxss = Services["RunService"].Heartbeat:Connect(function()
        if getgenv().Disconnect then sadksafjkzxss:Disconnect();sadksafjkzxss = nil end
        if Configuration.GambleGacha then
            if Configuration.SelectGacha == "Hakari" then
                if not PlayerGui:FindFirstChild("Gacha") then
                    if (CFrame.new(-3020, 15, -391).Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 3 then
                        Kurone:Teleport(CFrame.new(-3020, 15, -391))
                    else
                        Kurone:SendKeyEvent(Enum.KeyCode.E)
                    end
                elseif PlayerGui:FindFirstChild("Gacha") then
                    FireClickButton(PlayerGui:FindFirstChild("Gacha"):WaitForChild("Gacha")["Main"]["UI"]["Btn"]:FindFirstChild("Spinx100").Button)
                end
            elseif Configuration.SelectGacha == "Higuruma" then
                if not PlayerGui:FindFirstChild("Gacha 3") then
                    if (CFrame.new(-3029, 15, -391).Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 3 then
                        Kurone:Teleport(CFrame.new(-3029, 15, -391))
                    else
                        Kurone:SendKeyEvent(Enum.KeyCode.E)
                    end
                elseif PlayerGui:FindFirstChild("Gacha 3") then
                    FireClickButton(PlayerGui:FindFirstChild("Gacha 3"):WaitForChild("Gacha")["Main"]["UI"]["Btn"]:FindFirstChild("Spinx100").Button)
                end
            elseif Configuration.SelectGacha == "Zangetus/Starkk" then
                if not PlayerGui:FindFirstChild("Gacha 2") then
                    if (CFrame.new(-3032, 15, -453).Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 3 then
                        Kurone:Teleport(CFrame.new(-3032, 15, -453))
                    else
                        Kurone:SendKeyEvent(Enum.KeyCode.E)
                    end
                elseif PlayerGui:FindFirstChild("Gacha 2") then
                    FireClickButton(PlayerGui:FindFirstChild("Gacha 2"):WaitForChild("Gacha")["Main"]["UI"]["Btn"]:FindFirstChild("Spinx100").Button)
                end
            end
        end
    end)
end)

local Timer

Timer = Services["RunService"].Heartbeat:Connect(function() -- All RunService
    if getgenv().Disconnect then
        Timer:Disconnect();Timer = nil;print("Disconnect Heartbeat")
    end
    pcall(function()
        local TimeSinceLastPlay = os.time() - Old
        local hours = tostring(math.floor(TimeSinceLastPlay / 3600))
        local minutes = tostring(math.floor((TimeSinceLastPlay % 3600) / 60))
        local seconds = tostring(TimeSinceLastPlay % 60)
        Timeing:SetTitle("Server Joined "..hours.." H "..minutes.." M "..seconds.." S ")

        local CheckDefeat2 = VeNpc.Misc.Boss2.ProximityPrompt.ObjectText
        local SplitMessage2 = string.split(CheckDefeat2, "Defeat");
        local SplitMessage3 = string.split(SplitMessage2[2], "/50");    
        Summontotal:SetDesc("Total : "..tonumber(SplitMessage3[1]).."/50")
        BossTicketToSummontotal:SetDesc("Total : "..tonumber(LocalPlayer.InventoryData.Material["Boss Ticket"].Value))
        JoKerCard:SetDesc("Total : "..tonumber(LocalPlayer.InventoryData.Material["Joker Card"].Value))
        GUnBarrel:SetDesc("Total : "..tonumber(LocalPlayer.InventoryData.Material["Gun Barrel [Starkk]"].Value))
        ChestTimer:SetDesc("Count/Time : "..tonumber(workspace.Main:FindFirstChild("Raid Chest")["Count"].Value))
        if Configuration.CollentLoot then
            local IsOpenedChest = PlayerGui:FindFirstChild("Loot")
            if not IsOpenedChest and workspace.Main:FindFirstChild("Raid Chest") then
                Kurone:Teleport(workspace.Main["Raid Chest"].CFrame * CFrame.new(0, 5, 0))
                if keypress and keyrelease then
                    workspace.Main["Raid Chest"]["{}"].HoldDuration = 0
                    Kurone:SendKeyEvent(Enum.KeyCode.E)
                else
                    workspace.Main["Raid Chest"]["{}"].HoldDuration = 0
                    fireproximityprompt(workspace.Main["Raid Chest"]["{}"])
                end
            else
                for _,v in pairs(PlayerGui.Loot.Main.Iinv.Material:GetChildren()) do
                    if v:IsA("Frame") then
                        FireClickButton(v.Button)
                    end
                end
            end
        end
        Services["RunService"].Heartbeat:Wait() -- wait
    end,print)
end)

InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("KuroneUwU")
InterfaceManager:BuildInterfaceSection(Tap.Settings)
Window:SelectTab(1)

-- SaveManager:LoadAutoloadConfig()
-- Fluent:SetTheme("Darker")
if setfpscap then
    setfpscap(240)
end

ToRotate = nil
spawn(function()
    while task.wait() do
        if getgenv().Disconnect then break end
        ToRotate = random(1,6)
        wait(.3)
    end
end)
function Kurone:RandomRotateReal()
    if ToRotate == 1 then
        shared.Rotate = CFrame.new(0,Configuration.Distance,0) * CFrame.Angles(math.rad(-90), 0, 0)
    elseif ToRotate == 2 then
        shared.Rotate = CFrame.new(0,0,Configuration.Distance) * CFrame.Angles(0, math.rad(0), 0)
    elseif ToRotate == 3 then
        shared.Rotate = CFrame.new(0,0,-Configuration.Distance) * CFrame.Angles(0, math.rad(180), 0)
    elseif ToRotate == 4 then
        shared.Rotate = CFrame.new(0,-Configuration.Distance,0) * CFrame.Angles(math.rad(90), 0, 0)
    elseif ToRotate == 5 then
        shared.Rotate = CFrame.new(-Configuration.Distance,0,0) * CFrame.Angles(0, math.rad(-90), 0)
    elseif ToRotate == 6 then
        shared.Rotate = CFrame.new(Configuration.Distance,0,0) * CFrame.Angles(0, math.rad(90), 0)
    end
end
spawn(function()
    getgenv().ThreadAutoRotate = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadAutoRotate) end
        pcall(function() -- {"Above","Behind","Front","Below","RandomRotate"}
            if Configuration.MethodFarm == "Above" then
                shared.Rotate = CFrame.new(0,Configuration.Distance,0) * CFrame.Angles(math.rad(-90), 0, 0)
            elseif Configuration.MethodFarm == "Behind" then
                shared.Rotate = CFrame.new(0,0,Configuration.Distance) * CFrame.Angles(0, math.rad(0), 0)
            elseif Configuration.MethodFarm == "Front" then
                shared.Rotate = CFrame.new(0,0,-Configuration.Distance) * CFrame.Angles(0, math.rad(180), 0)
            elseif Configuration.MethodFarm == "Below" then
                shared.Rotate = CFrame.new(0,-Configuration.Distance,0) * CFrame.Angles(math.rad(90), 0, 0)
            elseif Configuration.MethodFarm == "RandomRotate" then
                Kurone:RandomRotateReal()
            end
        end)
    end)
end)
spawn(function()
    getgenv().ThreadGrabFruits = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadGrabFruits) end
        if Configuration.GrabFruits then
            pcall(function()
                local humanoid = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                for _, child in ipairs(workspace:GetChildren()) do
                    if LocalPlayer.Character and child:IsA("BackpackItem") and child:FindFirstChild("Handle") then
                        humanoid:EquipTool(child)
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoFarm = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadAutoFarm) end
        if Configuration.AutoFarm then
            local suc , fail = pcall(function()
                Kurone:Checkcc()
                local QuestData = PlayerGui.Quest.Frame:FindFirstChild("QuestData1") or PlayerGui.Quest.Frame:FindFirstChild("QuestData2") or PlayerGui.Quest.Frame:FindFirstChild("QuestData3") or PlayerGui.Quest.Frame:FindFirstChild("QuestData4") or PlayerGui.Quest.Frame:FindFirstChild("QuestData5");
                if QuestData then
                    for _,z in pairs(QuestData:GetChildren()) do
                        for _,x in pairs(z:GetChildren()) do
                            if x:IsA("TextLabel") then
                                local CheckTextQuest = x.Text
                                local CorrectQuest = string.split(CheckTextQuest, "Quest")
                                if not string.find(CorrectQuest[1], CQuest) then
                                    CanStartAutoFarm = false; print("$AutoAcceptQuest[2]: "..CorrectQuest[1].." Not Found, Canceling Quest")
                                    if keypress and keyrelease then
                                        FireClickButton(QuestData:FindFirstChild("Bar")["Cancel"])
                                    end
                                elseif string.find(CorrectQuest[1], CQuest) then
                                    CanStartAutoFarm = true
                                end
                            end
                        end
                    end
                end
                if not QuestData then
                    repeat wait()
                        Kurone:Teleport(CFrameQuest)
                    until (CFrameQuest.Position - Kurone:GetChar().HumanoidRootPart.Position).Magnitude <= 1.5 or not Configuration.AutoFarm;
                    if (CFrameQuest.Position - Kurone:GetChar().HumanoidRootPart.Position).Magnitude <= 3 then
                        if keypress and keyrelease then 
                            Kurone:SendKeyEvent(Enum.KeyCode.E)
                        else
                            for _,g in pairs(VeNpc.Quest:GetChildren()) do
                                if g.Name == GQuest then
                                    fireproximityprompt(g.ProximityPrompt)
                                end
                            end
                        end
                    end
                elseif QuestData and CanStartAutoFarm then
                    if workspace.Main[ParentMon][FolderMon]:FindFirstChild(NameMon) then
                        for _,v in pairs(workspace.Main[ParentMon][FolderMon]:GetChildren()) do
                            if Configuration.AutoFarm and v.Name == NameMon and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                                repeat task.wait()
                                    NeedFireTool = true
                                    Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                    Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                                    Kurone:EquipAndFire(function()
                                        local args = {
                                            [1] = "Server",
                                            [2] = Configuration.SelectWeapon,
                                            [3] = "M1s",
                                            [4] = random(1,5),
                                            [5] = Configuration.SelectCustomAttack
                                        }
                                        Serverside:FireServer(unpack(args))
                                    end)
                                until not Configuration.AutoFarm or not CanStartAutoFarm or v.Humanoid.Health == 0 or v:FindFirstChild("Already")
                            end
                        end
                    else
                        print("$AutoFarmLv[2]: "..NameMon.." Not Found, Teleporting To CFrame: "..tostring(CFrameMon)) ; Kurone:Teleport(CFrameMon)
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoBossNR = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadAutoBossNR) end
        if Configuration.TypeBossFarm then
            pcall(function()
                if Configuration.SelectBossType == "Normal" then
                    for _,v in pairs(workspace.Main.Boss:GetChildren()) do
                        if Configuration.TypeBossFarm and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                            repeat task.wait()
                                NeedFireTool = true
                                Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                Kurone:InstantKill(v)
                                Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                                Kurone:EquipAndFire(function()
                                    local args = {
                                        [1] = "Server",
                                        [2] = Configuration.SelectWeapon,
                                        [3] = "M1s",
                                        [4] = random(1,5),
                                        [5] = Configuration.SelectCustomAttack
                                    }
                                    Serverside:FireServer(unpack(args))
                                end)
                            until not Configuration.TypeBossFarm or v.Humanoid.Health <= 0 or not v.Parent or v:FindFirstChild("Already")
                            NeedFireTool = false
                        end
                    end
                elseif Configuration.SelectBossType == "Raid" then
                    for _,v in pairs(workspace.Main.RaidBoss:GetChildren()) do
                        if Configuration.TypeBossFarm and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                            repeat task.wait()
                                NeedFireTool = true
                                Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                Kurone:InstantKill(v)
                                Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                                Kurone:EquipAndFire(function()
                                    local args = {
                                        [1] = "Server",
                                        [2] = Configuration.SelectWeapon,
                                        [3] = "M1s",
                                        [4] = random(1,5),
                                        [5] = Configuration.SelectCustomAttack
                                    }
                                    Serverside:FireServer(unpack(args))
                                end)
                            until not Configuration.TypeBossFarm or v.Humanoid.Health <= 0 or not v.Parent or v:FindFirstChild("Already")
                            NeedFireTool = false
                        end
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadMission = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadMission) end
        if Configuration.AutoMission then
            pcall(function()
                print("$Debugger! Current Mission: "..Kurone:GetDataMission());
                if Configuration.TypeMission == "Jujutsu" then
                    if LocalPlayer.MissionData.Active.Value then
                        if Kurone:GetDataMission() == 1 then
                            Kurone:Teleport(workspace.Main["Mission Quest"]["1"]["Bronze Chest"]:GetModelCFrame())
                            if keypress and keyrelease then
                                Kurone:SendKeyEvent(Enum.KeyCode.E)
                            else
                                fireproximityprompt(workspace.Main["Mission Quest"]["1"]["Bronze Chest"].HumanoidRootPart.ProximityPrompt)
                            end
                        elseif Kurone:GetDataMission() == 2 then
                            Kurone:Teleport(workspace.Main["Mission Quest"]["2"].Goblet.CFrame)
                            wait()
                            if keypress and keyrelease then
                                Kurone:SendKeyEvent(Enum.KeyCode.E)
                            else
                                fireproximityprompt(workspace.Main["Mission Quest"]["2"].Goblet.ProximityPrompt)
                            end
                        elseif Kurone:GetDataMission() == 3 then
                            if workspace.Main.Forest["Curse Spirit"]:FindFirstChild("Curse Spirit [Lv.750]") then
                                for _, v in pairs(workspace.Main.Forest["Curse Spirit"]:GetChildren()) do
                                    if Configuration.TypeMission and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                                        repeat task.wait()
                                            NeedFireTool = true
                                            Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                            Kurone:BringReal(v)
                                            Kurone:EquipAndFire(function()
                                                local args = {
                                                    [1] = "Server",
                                                    [2] = Configuration.SelectWeapon,
                                                    [3] = "M1s",
                                                    [4] = random(1,5),
                                                    [5] = Configuration.SelectCustomAttack
                                                }
                                                Serverside:FireServer(unpack(args))
                                            end)
                                        until not Configuration.TypeMission or Configuration.TypeMission == false or v.Humanoid.Health <= 0 or v.Humanoid.Health == 0 or not v.Parent
                                        NeedFireTool = false
                                    end
                                end
                            else
                                Kurone:Teleport(workspace.Main.Forest["Curse Spirit"]["3"].CFrame)
                            end
                        elseif Kurone:GetDataMission() == 4 then
                            Kurone:Teleport(workspace.Main["Mission Quest"]["4"].Civilian:GetModelCFrame())
                            if keypress and keyrelease then
                                Kurone:SendKeyEvent(Enum.KeyCode.E)
                            else
                                fireproximityprompt(workspace.Main["Mission Quest"]["4"].Civilian.ProximityPrompt)
                            end
                        elseif Kurone:GetDataMission() == 5 then
                            if workspace.Main.Forest.Kashimo:FindFirstChild("Kashimo [Lv.???]") then
                                for _, v in pairs(workspace.Main.Forest.Kashimo:GetChildren()) do
                                    if Configuration.AutoMission and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                                        repeat task.wait()
                                            NeedFireTool = true
                                            Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                            Kurone:InstantKill(v)
                                            Kurone:BringReal(v)
                                            Kurone:EquipAndFire(function()
                                                local args = {
                                                    [1] = "Server",
                                                    [2] = Configuration.SelectWeapon,
                                                    [3] = "M1s",
                                                    [4] = random(1,5),
                                                    [5] = Configuration.SelectCustomAttack
                                                }
                                                Serverside:FireServer(unpack(args))
                                            end)
                                        until not Configuration.TypeBossFarm or v.Humanoid.Health <= 0 or not v.Parent or v:FindFirstChild("Already")
                                        NeedFireTool = false
                                    end
                                end
                            else
                                Kurone:Teleport(workspace.Main.Forest.Kashimo["1"].CFrame)
                            end
                        elseif Kurone:GetDataMission() == 6 then
                            Kurone:Teleport(workspace.Main["Mission Quest"]["5"].Portal.CFrame)
                            workspace.Main["Mission Quest"]["5"].Portal.ProximityPrompt.Enabled = true
                            if keypress and keyrelease then
                                Kurone:SendKeyEvent(Enum.KeyCode.E)
                            else
                                fireproximityprompt(workspace.Main["Mission Quest"]["5"].Portal.ProximityPrompt)
                            end
                        end
                    else
                        Kurone:Teleport(VeNpc.Quest.Mission:GetModelCFrame())
                        if keypress and keyrelease then 
                            Kurone:SendKeyEvent(Enum.KeyCode.E)
                        else
                            fireproximityprompt(VeNpc.Quest.Mission.ProximityPrompt)
                        end
                        task.wait(1)
                    end
                elseif Configuration.TypeMission == "Hueco" then
                    if LocalPlayer.MissionData.Active.Value then
                        if Kurone:GetDataMission() == -1 then
                            Kurone:Teleport(workspace.Main["Mission Quest 2"]["1"]["3"].CFrame)
                            if keypress and keyrelease then
                                Kurone:SendKeyEvent(Enum.KeyCode.E)
                            else
                                fireproximityprompt(workspace.Main["Mission Quest 2"]["1"]["3"].ProximityPrompt)
                            end
                        elseif Kurone:GetDataMission() == -2 then
                            for _, v in pairs(workspace.Main.Hueco.Arrancar:GetChildren()) do
                                if Configuration.AutoMission and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                                    repeat task.wait()
                                        NeedFireTool = true
                                        Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                        Kurone:InstantKill(v)
                                        Kurone:BringReal(v)
                                        Kurone:EquipAndFire(function()
                                            local args = {
                                                [1] = "Server",
                                                [2] = Configuration.SelectWeapon,
                                                [3] = "M1s",
                                                [4] = random(1,5),
                                                [5] = Configuration.SelectCustomAttack
                                            }
                                            Serverside:FireServer(unpack(args))
                                        end)
                                    until not Configuration.AutoMission or Configuration.AutoMission == false or v.Humanoid.Health <= 0 or v.Humanoid.Health == 0 or not v.Parent
                                    NeedFireTool = false
                                end
                            end
                        elseif Kurone:GetDataMission() == -3 then
                            Kurone:Teleport(workspace.Main["Mission Quest 2"]["2"]:GetChildren()[3].CFrame)
                            if keypress and keyrelease then
                                Kurone:SendKeyEvent(Enum.KeyCode.E)
                            else
                                fireproximityprompt(workspace.Main["Mission Quest 2"]["2"]:GetChildren()[3].ProximityPrompt)
                            end
                        elseif Kurone:GetDataMission() == -4 then
                            if workspace.Main.Hueco.Ichigo:FindFirstChild("Ichigo [Lv.???]") then
                                for _, v in pairs(workspace.Main.Hueco.Ichigo:GetChildren()) do
                                    if Configuration.AutoMission and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                                        repeat task.wait()
                                            NeedFireTool = true
                                            Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                            Kurone:InstantKill(v)
                                            Kurone:BringReal(v)
                                            Kurone:EquipAndFire(function()
                                                local args = {
                                                    [1] = "Server",
                                                    [2] = Configuration.SelectWeapon,
                                                    [3] = "M1s",
                                                    [4] = random(1,5),
                                                    [5] = Configuration.SelectCustomAttack
                                                }
                                                Serverside:FireServer(unpack(args))
                                            end)
                                        until not Configuration.AutoMission or Configuration.AutoMission == false or v.Humanoid.Health <= 0 or v.Humanoid.Health == 0 or not v.Parent
                                        NeedFireTool = false
                                    end
                                end
                            else
                                Kurone:Teleport(workspace.Main.Hueco.Ichigo["1"].CFrame)
                            end
                        else
                            Kurone:Teleport(VeNpc.Quest["Mission 2"]:GetModelCFrame())
                            wait()
                            if keypress and keyrelease then
                                Kurone:SendKeyEvent(Enum.KeyCode.E)
                            else
                                fireproximityprompt(VeNpc.Quest["Mission 2"].Union.ProximityPrompt)
                                task.wait(1)
                            end
                        end
                    else
                        Kurone:Teleport(VeNpc.Quest["Mission 2"]:GetModelCFrame())
                        if keypress and keyrelease then
                            Kurone:SendKeyEvent(Enum.KeyCode.E)
                        else
                            fireproximityprompt(VeNpc.Quest["Mission 2"].Union.ProximityPrompt)
                        end
                        task.wait(1)
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoDungeon = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadAutoDungeon) end
        if Configuration.AutoDungeon then
            pcall(function()
                if workspace.Main.Boss.Boss.Value then
                    for _,v in pairs(workspace.Main.Boss:GetChildren()) do
                        if Configuration.AutoDungeon and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                            repeat task.wait()
                                NeedFireTool = true
                                Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                Kurone:InstantKill(v)
                                Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                                Kurone:EquipAndFire(function()
                                    local args = {
                                        [1] = "Server",
                                        [2] = Configuration.SelectWeapon,
                                        [3] = "M1s",
                                        [4] = random(1,5),
                                        [5] = Configuration.SelectCustomAttack
                                    }
                                    Serverside:FireServer(unpack(args))
                                end)
                            until not Configuration.AutoDungeon or v.Humanoid.Health <= 0 or not v.Parent or v:FindFirstChild("Already")
                            NeedFireTool = false
                        end
                    end
                else
                    for _,v in pairs(workspace.Main.Raid:GetChildren()) do
                        if Configuration.AutoDungeon and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                            repeat task.wait()
                                NeedFireTool = true
                                Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                                Kurone:EquipAndFire(function()
                                    local args = {
                                        [1] = "Server",
                                        [2] = Configuration.SelectWeapon,
                                        [3] = "M1s",
                                        [4] = random(1,5),
                                        [5] = Configuration.SelectCustomAttack
                                    }
                                    Serverside:FireServer(unpack(args))
                                end)
                            until not Configuration.AutoDungeon or v.Humanoid.Health <= 0 or not v.Parent or v:FindFirstChild("Already")
                            NeedFireTool = false
                        end
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoReplay = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadAutoReplay) end
        if Configuration.AutoReplay then
            pcall(function()
                if PlayerGui.Raid.Replay.Visible then
                    if keypress and keyrelease then 
                        FireClickButton(PlayerGui.Raid.Replay.Button)
                    else
                        -- alright i use the old method
                        if PlayerGui.Raid.Replay.Visible then
                            task.defer(function()
                                PlayerGui.Raid.Replay.Size = UDim2.new(200, 200, 200, 200)
                                PlayerGui.Raid.Replay.Position = UDim2.new(0, -800 ,0, -700)
                                Services["VirtualUser"]:CaptureController()
                                Services["VirtualUser"]:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
                                -- VirtualUser:ClickButton1(Vector2.new(PlayerGui.Raid.Replay.Position), game:GetService("Workspace").CurrentCamera.CFrame)
                            end)
                        end
                    end
                end
                if PlayerGui.Raid.Start.Visible then
                    if keypress and keyrelease then 
                        FireClickButton(PlayerGui.Raid.Start.Button)
                    else
                        if PlayerGui.Raid.Start.Visible then
                            task.defer(function()
                                PlayerGui.Raid.Start.Size = UDim2.new(200, 200, 200, 200)
                                PlayerGui.Raid.Start.Position = UDim2.new(0, -800 ,0, -700)
                                Services["VirtualUser"]:CaptureController()
                                Services["VirtualUser"]:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame) 
                                --VirtualUser:ClickButton1(Vector2.new(PlayerGui.Raid.Start.Position), game:GetService("Workspace").CurrentCamera.CFrame)
                            end)
                        end
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadFalledAngel = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadFalledAngel) end
        if Configuration.FalledAngel then
            pcall(function()
                if workspace.Main["Fallen Angel"].Boss.Value then
                    for _, v in pairs(workspace.Main["Fallen Angel"]:GetChildren()) do
                        if Configuration.FalledAngel and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                            repeat task.wait()
                                NeedFireTool = true
                                Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                Kurone:InstantKill(v)
                                Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                                Kurone:EquipAndFire(function()
                                    local args = {
                                        [1] = "Server",
                                        [2] = Configuration.SelectWeapon,
                                        [3] = "M1s",
                                        [4] = random(1,5),
                                        [5] = Configuration.SelectCustomAttack
                                    }
                                    Serverside:FireServer(unpack(args))
                                end)
                            until not Configuration.FalledAngel or Configuration.FalledAngel == false or v.Humanoid.Health <= 0 or v.Humanoid.Health == 0 or not v.Parent
                            NeedFireTool = false
                        end
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadSkeletone = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadSkeletone) end
        if Configuration.AutoSkeleton then
            pcall(function()
                if workspace:WaitForChild("Main")["Cave"]["Skeleton"]:FindFirstChild("Skeleton Zombie [Lv.7500]") then
                    for _,v in pairs(workspace.Main.Cave.Skeleton:GetChildren()) do
                        if Configuration.AutoSkeleton and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                            repeat task.wait()
                                NeedFireTool = true
                                Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                Kurone:InstantKill(v)
                                Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                                Kurone:EquipAndFire(function()
                                    local args = {
                                        [1] = "Server",
                                        [2] = Configuration.SelectWeapon,
                                        [3] = "M1s",
                                        [4] = random(1,5),
                                        [5] = Configuration.SelectCustomAttack
                                    }
                                    Serverside:FireServer(unpack(args))
                                end)
                            until not Configuration.AutoSkeleton or Configuration.AutoSkeleton == false or v.Humanoid.Health <= 0 or v.Humanoid.Health == 0 or not v.Parent
                            NeedFireTool = false
                        end
                    end
                else
                    Kurone:Teleport(CFrame.new(-3572, 46, 1979))
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadMineOre = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadMineOre) end
        if Configuration.AutoMine then
            if workspace.Main["Fallen Angel"].Boss.Value and Configuration.FalledAngel then return end
            pcall(function()
                repeat task.wait()
                    if Kurone:GetHumanoid().Health ~= 0 then
                        Rayore = Kurone:GetRarestOre()
                        if not Rayore["{}"].Enabled then return end
                        local Center = Rayore:FindFirstChild("Stone")
                        Kurone:Teleport(Center.CFrame * CFrame.new(0,12,0))
                        task.wait()
                        Services.VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                        task.wait()
                    end
                until not Rayore["{}"].Enabled or not Configuration.AutoMine or Kurone:GetHumanoid().Health == 0
                Services.VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                task.wait()
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoExchange = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadMineOre) end
        if Configuration.AutoExchange then
            pcall(function()
                for _,v in pairs(PlayerGui.Exchange.BG.Iinv.Material[Configuration.MaterialItems]:GetChildren()) do
                    if v:IsA("TextButton") and v.Name == "Button" then
                        FireClickButton(v)
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoSummon = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadAutoSummon) end
        if Configuration.AutoSummonBoss then
            pcall(function()
                if keypress and keyrelease then
                    if PlayerGui.Misc.Boss.Visible then
                        if PlayerGui.Misc.Boss.Iinv.Stock[Configuration.SelectSummonBoss].Visible ~= true then
                            PlayerGui.Misc.Boss.Iinv.Stock[Configuration.SelectSummonBoss].Visible = true
                        end
                        for _,v in pairs(PlayerGui.Misc.Boss.Iinv.Stock[Configuration.SelectSummonBoss]:GetChildren()) do
                            if v:IsA("TextButton") and v.Name == "Spawn" then
                                FireClickButton(v)
                            end
                        end
                    else
                        PlayerGui.Misc.Boss.Visible = true ; PlayerGui.Misc.Boss.Iinv.Bg.Visible = false
                    end
                end
            end)
        else
            PlayerGui.Misc.Boss.Visible = false
            PlayerGui.Misc.Boss.Iinv.Bg.Visible = true
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoWorldBoss = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadAutoWorldBoss) end
        if Configuration.AutoWorldBoss then
            pcall(function()
                for _,v in pairs(workspace.Main.Skull:GetChildren()) do
                    if Configuration.AutoWorldBoss and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health ~= 0 and not v:FindFirstChild("Already") then
                        repeat task.wait()
                            NeedFireTool = true
                            Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                            Kurone:InstantKill(v)
                            Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                            Kurone:EquipAndFire(function()
                                local args = {
                                    [1] = "Server",
                                    [2] = Configuration.SelectWeapon,
                                    [3] = "M1s",
                                    [4] = random(1,5),
                                    [5] = Configuration.SelectCustomAttack
                                }
                                Serverside:FireServer(unpack(args))
                            end)
                        until not Configuration.AutoWorldBoss or v:FindFirstChild("Humanoid").Health == 0 or v:FindFirstChild("Already")
                        NeedFireTool = false
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoD4c = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadAutoD4c) end
        if Configuration.JoJoD4c then
            pcall(function()
                for _,v in pairs(workspace.Main.Valentine:GetChildren()) do
                    if Configuration.JoJoD4c and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                        repeat task.wait()
                            NeedFireTool = true
                            Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                            Kurone:InstantKill(v)
                            Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                            Kurone:EquipAndFire(function()
                                local args = {
                                    [1] = "Server",
                                    [2] = Configuration.SelectWeapon,
                                    [3] = "M1s",
                                    [4] = random(1,5),
                                    [5] = Configuration.SelectCustomAttack
                                }
                                Serverside:FireServer(unpack(args))
                            end)
                        until not Configuration.JoJoD4c or v.Humanoid.Health <= 0 or not v.Parent or v:FindFirstChild("Already")
                        NeedFireTool = false
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadAutoOkarun = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadAutoOkarun) end
        if Configuration.Karun then
            pcall(function()
                for _,v in pairs(workspace.Main.Tunnel:GetChildren()) do
                    if Configuration.Karun and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                        repeat task.wait()
                            NeedFireTool = true
                            Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                            Kurone:InstantKill(v)
                            Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                            Kurone:EquipAndFire(function()
                                local args = {
                                    [1] = "Server",
                                    [2] = Configuration.SelectWeapon,
                                    [3] = "M1s",
                                    [4] = random(1,5),
                                    [5] = Configuration.SelectCustomAttack
                                }
                                Serverside:FireServer(unpack(args))
                            end)
                        until not Configuration.Karun or v.Humanoid.Health <= 0 or not v.Parent or v:FindFirstChild("Already")
                        NeedFireTool = false
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadFullyAutoStark = Controller:newThread(0,function()
        if getgenv().Disconnect then Controller:removeThread(ThreadFullyAutoStark) end
        if Configuration.AutoStarkkLL then
            pcall(function()
                CheckDefeat = VeNpc.Misc.Boss2.ProximityPrompt.ObjectText;
                SplitMessage = string.split(CheckDefeat, "Defeat");
                SplitMessage2 = string.split(SplitMessage[2], "/");
                if tonumber(SplitMessage2[1]) <= 49 and not workspace.Main.Kurakura.Boss.Boss.Value then
                    if workspace.Main.Kurakura["Vasto Lorde"]:FindFirstChild("Vasto Lorde [Lv.7500]") then
                        for _,v in pairs(workspace.Main.Kurakura["Vasto Lorde"]:GetChildren()) do
                            if Configuration.AutoStarkkLL and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                                repeat task.wait()
                                    NeedFireTool = true
                                    Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                    Kurone:InstantKill(v)
                                    Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                                    Kurone:EquipAndFire(function()
                                        local args = {
                                            [1] = "Server",
                                            [2] = Configuration.SelectWeapon,
                                            [3] = "M1s",
                                            [4] = random(1,5),
                                            [5] = Configuration.SelectCustomAttack
                                        }
                                        Serverside:FireServer(unpack(args))
                                    end)
                                until not Configuration.AutoStarkkLL or v.Humanoid.Health <= 0 or not v.Parent or v:FindFirstChild("Already")
                                NeedFireTool = false
                            end
                        end
                    else
                        Kurone:Teleport(workspace.Main.Kurakura["Vasto Lorde"]["1"].CFrame)
                    end
                elseif workspace.Main.Kurakura.Boss.Boss.Value then -- workspace.Main.Kurakura.Boss:FindFirstChild("Starkk (LL) [Lv.???]")
                    for _,v in pairs(workspace.Main.Kurakura.Boss:GetChildren()) do
                        if Configuration.AutoStarkkLL and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not v:FindFirstChild("Already") then
                            repeat task.wait()
                                NeedFireTool = true
                                Kurone:Teleport(v.HumanoidRootPart.CFrame * shared.Rotate)
                                Kurone:InstantKill(v)
                                Kurone:BringReal(v,v.HumanoidRootPart.CFrame)
                                Kurone:EquipAndFire(function()
                                    local args = {
                                        [1] = "Server",
                                        [2] = Configuration.SelectWeapon,
                                        [3] = "M1s",
                                        [4] = random(1,5),
                                        [5] = Configuration.SelectCustomAttack
                                    }
                                    Serverside:FireServer(unpack(args))
                                end)
                            until not Configuration.AutoStarkkLL or v.Humanoid.Health <= 0 or not v.Parent or v:FindFirstChild("Already")
                            NeedFireTool = false
                        end
                    end
                elseif tonumber(SplitMessage2[1]) >= 50 and not workspace.Main.Kurakura.Boss.Boss.Value or not workspace.Main.Kurakura.Boss:FindFirstChild("Starkk (LL) [Lv.???]") then
                    Kurone:Teleport(VeNpc.Misc.Boss2:GetModelCFrame())
                    if keypress and keyrelease then 
                        Kurone:SendKeyEvent(Enum.KeyCode.E)
                    else
                        fireproximityprompt(VeNpc.Misc.Boss2.ProximityPrompt)
                    end
                end
            end)
        end
    end)
end)
spawn(function()
    getgenv().ThreadEffects = Controller:newThread(0,function()
        if getgenv().Disconnect then print("removeThread: Effects") Controller:removeThread(ThreadEffects) end
        if Configuration.RemoveEffects then
            pcall(function()
                workspace.Effects:ClearAllChildren()
            end)
        end
    end)
end)
spawn(function()
    while wait() do
        if getgenv().Disconnect then break end
        pcall(function()
            if Configuration.Wisper then
                if workspace.Main.Wisp.Wisp.Value then
                    workspace.Main.Wisp.Wisper.Torso["{}"].HoldDuration = 0
                    Kurone:Teleport(workspace.Main.Wisp.Wisper:GetModelCFrame())
                    if keypress and keyrelease then 
                        Kurone:SendKeyEvent(Enum.KeyCode.E)
                    else
                        fireproximityprompt(workspace.Main.Wisp.Wisper.Torso["{}"],5)
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait(1) do 
        if getgenv().Disconnect then break end
        pcall(function()
            if Configuration.Haki then
                if not LocalPlayer.Character:FindFirstChild("HakiActive") then
                    Serverside:FireServer("Server", "Misc", "Haki", true)
                end    
            end
        end)
    end
end)
spawn(function()
    while wait() do if getgenv().Disconnect then break end
        pcall(function()
            if Configuration.Strength then
                PlayerGui.HUD.Stats.Iinv.Setting.Event:FireServer("Strength",tonumber(Configuration.SilderPoints),1)
            end
        end)
    end
end)
spawn(function()
    while wait() do if getgenv().Disconnect then break end
        pcall(function()
            if Configuration.Defense then
                PlayerGui.HUD.Stats.Iinv.Setting.Event:FireServer("Defense",tonumber(Configuration.SilderPoints),1)
            end
        end)
    end
end)
spawn(function()
    while wait() do if getgenv().Disconnect then break end
        pcall(function()
            if Configuration.Sword then
                PlayerGui.HUD.Stats.Iinv.Setting.Event:FireServer("Sword",tonumber(Configuration.SilderPoints),1)
            end
        end)
    end
end)
spawn(function()
    while wait() do if getgenv().Disconnect then break end
        pcall(function()
            if Configuration.Special then
                PlayerGui.HUD.Stats.Iinv.Setting.Event:FireServer("Special",tonumber(Configuration.SilderPoints),1)
            end
        end)
    end
end)
-- spawn(function()
--     if not getgenv().ProtectedName then
--         -- local fakeplr = {["Name"] = "Protected", ["UserId"] = "1928342521"}
--         -- local otherfakeplayers = {["Name"] = "ROBLOX", ["UserId"] = "1"}
--         local lplr = LocalPlayer
--         local function plrthing(obj, property)
--             for i,v in pairs(Services["Players"]:GetPlayers()) do
--                 if v.Name ~= lplr then
--                     obj[property] = obj[property]:gsub(v.Name, Kurone:RandomCharacters(8,32))
--                     obj[property] = obj[property]:gsub(v.DisplayName, Kurone:RandomCharacters(8,32))
--                     obj[property] = obj[property]:gsub(v.UserId, math.random(10000,982412525))
--                 else
--                     obj[property] = obj[property]:gsub(v.Name, Kurone:RandomCharacters(8,32))
--                     obj[property] = obj[property]:gsub(v.DisplayName, Kurone:RandomCharacters(8,32))
--                     obj[property] = obj[property]:gsub(v.UserId, math.random(10000,982412525))
--                 end
--             end
--         end
--         local function newobj(v)
--             if v:IsA("TextLabel") or v:IsA("TextButton") then
--                 plrthing(v, "Text")
--                 v:GetPropertyChangedSignal("Text"):connect(function()
--                     plrthing(v, "Text")
--                 end)
--             end
--             if v:IsA("ImageLabel") then
--                 plrthing(v, "Image")
--                 v:GetPropertyChangedSignal("Image"):connect(function()
--                     plrthing(v, "Image")
--                 end)
--             end
--         end
--         for i,v in pairs(game:GetDescendants()) do
--             newobj(v)
--         end
--         game.DescendantAdded:connect(newobj)
--     end
-- end)
-- pcall(function() getgenv().ProtectedName = true end)
print("Loading Success Took "..string.format("%.2f",tick() - LoadingTime).." secs")
Fluent:Notify({
    Title = "Kurone",
    Content = "Loading Success Took "..string.format("%.2f",tick() - LoadingTime).." secs",
    Duration = 8
})