local Tween = (function(Position)
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
    
    if tween then tween:Cancel() end
    if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):GetState() == Enum.HumanoidStateType.Seated or game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Health <= 0 then
        game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Jump = true
        game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Sit = false
    end
    if game:GetService("Players").LocalPlayer:DistanceFromCharacter(Position.Position) <= 3 then
        game:GetService("Players").LocalPlayer.Character:PivotTo(Position) -- Vector3
    end
    local Distance = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude

	if Distance < 300 then
		-- Speed = 18
	end

    local tween_s = game:service"TweenService"
	local TimeToGo = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude/Speed
	local info = TweenInfo.new(TimeToGo, Enum.EasingStyle.Linear)  -- Quad, Sine, Quint, Linear
	local tweenw, err = pcall(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.X, Position.Y, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
		tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = RealTarget})
		tween:Play()
	end)
end)
