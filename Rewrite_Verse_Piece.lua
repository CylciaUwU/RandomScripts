if Sylvia then return warn("Sylvia: Already executed!") end
pcall(function() getgenv().Sylvia = true end)

LoadingTime = tick()

-- env (ขี้เกียจเขียนตัวแปร)
loadstring(game:HttpGetAsync("https://gist.githubusercontent.com/CylciaUwU/776d16f2550998edf2adc1ed7f0a49e1/raw/23b6c2785006219016aab83fb2e97341580aadbb/env.lua"))()

function Constant(str)
	return str
end

if not game:IsLoaded() then game.Loaded:Wait() end;

--// Vars
local RenderStepped = RunService.Stepped
local Heartbeat = RunService.Heartbeat
-- local IsComputer = UserInputService.KeyboardEnabled and UserInputService.MouseEnabled

local LocalPlayer, PlayerGui = Players.LocalPlayer, Player.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
-- Game Service
local Remotes = ReplicatedStorage:WaitForChild(Constant("Remotes"))
local Serverside = Remotes:WaitForChild(Constant("Serverside"))

-- Stats Remote from decompiled LocalScript
local StatsEventFire = PlayerGui:WaitForChild("HUD")["Stats"]["Iinv"]["Setting"]:WaitForChild(Constant("Event"))

local Megumint = {};
Megumint.__index = Megumint;

local e = request or http_request
local a = e({
    Url = "https://gist.githubusercontent.com/CylciaUwU/30e45e7afd055ddbe643d7571b0d7850/raw/ca58f241c0aade24e298f763792647b48b1f0120/Repetator.luau",
    Method = "GET"
})
if a.StatusCode == 200 then
    Megumint.MainThread = getfenv().loadstring(a.Body)()
else
    return ("Repetator Not Found")
end

local InstMegumint = Megumint.MainThread.new()

local LocalPlayerUtils = {};
LocalPlayerUtils.__index = LocalPlayerUtils;

function LocalPlayerUtils:getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end
function LocalPlayerUtils:getRootPart()
    return self:getCharacter():FindFirstChild("HumanoidRootPart")
end
function LocalPlayerUtils:getHumanoid()
    return self:getCharacter():FindFirstChild("Humanoid")
end
function LocalPlayerUtils:getState()
    return self:getHumanoid():GetState()
end
function LocalPlayerUtils:isDead()
    return self:getState() == Enum.HumanoidStateType.Dead
end
function LocalPlayerUtils:changeState(...)
    local args = { ... }
    if #args == 0 then return end

    local success, err = pcall(function()
        self:getHumanoid():ChangeState(unpack(args))
        sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
    end)

    if not success then
        warn("Failed to change state:", err)
    end
end
function LocalPlayerUtils:Teleport(CFrame)
    local RootPart = self:getCharacter()
    RootPart:PivotTo(CFrame) -- or i just use Hrp instead PivotTo CFrame
end

local function RandomCharacters(length)
    local charset = {}
    for i = 48, 57 do table.insert(charset, char(i)) end
    for i = 65, 90 do table.insert(charset, char(i)) end
    for i = 97, 122 do table.insert(charset, char(i)) end

    local result = ""
    for i = 1, length do
        result = result .. charset[random(1, #charset)]
    end
    return result
end

local run = function(func) func() end

run(function()
    if getgenv().UIBUTTON then return end 
    local epicfunctionidonknow = function(...)
        local args={...}
        VirtualInputManager:SendKeyEvent(true,args[1],false,game)
        VirtualInputManager:SendKeyEvent(false,args[1],false,game)
    end

    do
        local UserInputService = game:GetService("UserInputService")
        local CoreGui = game:GetService("CoreGui")
        local TweenService = game:GetService("TweenService")
        local isPC = table.find({ Enum.Platform.Windows }, UserInputService:GetPlatform()) ~= nil
        local IsComputer = isPC -- useless
        local toggleUIConfig = {
            TypeOs = isPC and "Pc" or "Mb",
            SizeUi = isPC and UDim2.fromOffset(560, 600) or UDim2.fromOffset(600, 300),
            AutoSize = true,
            TweenUiSize = true,
            SpeedTweenUi = 0.25,
            StyleTweenUi = Enum.EasingStyle.Quad,
            Mutiply = 1.80,
            SizeX = 550,
            SafePercent = 20,
            AnimationUiToggle = true,
        }
        getgenv()["ToggleUI"] = toggleUIConfig
        if not isPC then
            local existingButton = CoreGui:FindFirstChild("UIBUTTON")
            if existingButton then
                existingButton:Destroy()
            end
            local UIBUTTON = Instance.new("ScreenGui", CoreGui)
            UIBUTTON.Name = "UIBUTTON"
            UIBUTTON.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            local Frame = Instance.new("Frame", UIBUTTON)
            Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            Frame.BorderSizePixel = 0
            Frame.Transparency = 1
            Frame.Position = UDim2.new(0.157, 0, 0.164, 0)
            Frame.Size = UDim2.new(0, 115, 0, 49)
            local ImageButton = Instance.new("ImageButton", Frame)
            ImageButton.BackgroundColor3 = Color3.new(1, 1, 1)
            ImageButton.BorderSizePixel = 0
            ImageButton.Active = true
            ImageButton.Draggable = true
            ImageButton.Position = UDim2.new(0.219, 0, -0.155, 0)
            ImageButton.Size = UDim2.new(0, 64, 0, 64)
            ImageButton.Image = crypt.base64decode("cmJ4YXNzZXRpZDovLzk0MTk1NjIxMTg=")
            local UICorner1 = Instance.new("UICorner", ImageButton)
            UICorner1.CornerRadius = UDim.new(0, 100)
            local UICorner2 = Instance.new("UICorner", Frame)
            UICorner2.CornerRadius = UDim.new(0, 10)
            local isOpen = true
            ImageButton.MouseButton1Click:Connect(function()
                ImageButton:TweenSize(UDim2.new(0, 60, 0, 60), Enum.EasingDirection.In, Enum.EasingStyle.Elastic, 0.1)
                task.delay(0.1, function()
                    ImageButton:TweenSize(UDim2.new(0, 64, 0, 64), Enum.EasingDirection.Out, Enum.EasingStyle.Elastic, 0.1)
                end)
                if isOpen then
                    ImageButton.Image = crypt.base64decode("cmJ4YXNzZXRpZDovLzk0MTk1NjIxMTg=")
                else
                    ImageButton.Image = crypt.base64decode("cmJ4YXNzZXRpZDovLzk0MTk1NjIxMTg=")
                end
                isOpen = not isOpen
                spawn(function()
                    local args = {"Enum.KeyCode.RightControl","Enum.KeyCode.RightShift","Enum.KeyCode.LeftControl"}
                    for _,v in next, args do
                        epicfunctionidonknow(v)
                    end
                end)
            end)
            local dragToggle = false
            local dragSpeed = 0.25
            local dragStart, startPos
            local function updateInput(input)
                local delta = input.Position - dragStart
                local position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
                TweenService:Create(Frame, TweenInfo.new(dragSpeed), { Position = position }):Play()
            end
            Frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragToggle = true
                    dragStart = input.Position
                    startPos = Frame.Position
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragToggle = false
                        end
                    end)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    if dragToggle then
                        Frame.Transparency = 1
                        updateInput(input)
                    else
                        Frame.Transparency = 1
                    end
                end
            end)
        end
    end
end)

pcall(function() getgenv().UIBUTTON = true end)

if not antiafk then
    run(function()
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

pcall(function() getgenv().antiafk = true end)

local OldcanCollide, canCollide = {}, {}
local vcName = RandomCharacters(36,72)
local VelocityCon
spawn(function()
    VelocityCon = RenderStepped:Connect(function()
        if getgenv().Disconnect and VelocityCon then
            VelocityCon:Disconnect()
            VelocityCon = nil
            print("Velocity disconnected")
            LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
            return
        end
        pcall(function()
            local humanoid = LocalPlayerUtils:getHumanoid()
            local rootPart = LocalPlayerUtils:getRootPart()
            local currentState = LocalPlayerUtils:getState()
            local isSitting = currentState == Enum.HumanoidStateType.Seated
            if test
            then
                if isSitting and humanoid.Health > 0 then
                    humanoid.Sit = false
                    local BV = rootPart:FindFirstChild(vcName)
                    if BV then BV:Destroy() end
                end
                if not LocalPlayerUtils:isDead() then
                    LocalPlayerUtils:changeState(Enum.HumanoidStateType.StrafingNoPhysics)
                end
                if rootPart.Anchored then rootPart.Anchored = false end
                if not humanoid.AutoRotate then humanoid.AutoRotate = true end
                LocalPlayer.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
                if not isSitting and humanoid.Health > 0 or LocalPlayerUtils:isDead() then
                    for _, part in ipairs(LocalPlayerUtils:getCharacter():GetChildren()) do --ที่ไม่ใช้ GetDescendants เวลากดตีมันเก็บแคช(เก็บใน Hrp มั้งจำไม่ได้)
                        if part:IsA("BasePart") then
                            if OldcanCollide[part] == nil then
                                OldcanCollide[part] = part.CanCollide
                                canCollide[part] = part.CanCollide
                            end
                            if OldcanCollide[part] ~= false then
                                if test
                                then
                                    part.CanCollide = false
                                else
                                    part.CanCollide = canCollide[part]
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
                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bv.Velocity = Vector3.zero
                end
            else
                LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
                local BV = rootPart:FindFirstChild(vcName)
                if BV then BV:Destroy() end
                LocalPlayerUtils:changeState(Enum.HumanoidStateType.None)
            end
        end)
    end)
end)

TextChatService = game:GetService("TextChatService") --- no variable in env.lua
function chatMessage(str)
    if not str then return end
    str = tostring(str)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.TextChannels.RBXGeneral:SendAsync(str)
    else
        ReplicatedStorage:WaitForChild(Constant("DefaultChatSystemChatEvents")):WaitForChild(Constant("SayMessageRequest")):FireServer(str, "All")
    end
end

local _Quest = {};
_Quest.__index = _Quest;

function _Quest:Levels_Chcker()
    return LocalPlayer["PlayerData"]:WaitForChild(Constant("Levels")).Value
end

--unfinished
-- function _Quest:NpcPos()
--     local Lv = self:Levels_Chcker()
-- end
-- function _Quest:Monster()
--     local Lv = self:Levels_Chcker()
-- end
-- function _Quest:ParentMonster()
--     local Lv = self:Levels_Chcker()
-- end
