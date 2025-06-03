-- Boost Panel UI (Nov-scripts boost)

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "Nov-scripts"
gui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 450, 0, 300)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

-- Side Tab Frame
local sideTab = Instance.new("Frame", mainFrame)
sideTab.Size = UDim2.new(0, 100, 1, 0)
sideTab.Position = UDim2.new(0, 0, 0, 0)
sideTab.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", sideTab).CornerRadius = UDim.new(0, 8)

-- Effect (Boost) Button
local effectButton = Instance.new("TextButton", sideTab)
effectButton.Size = UDim2.new(1, -20, 0, 40)
effectButton.Position = UDim2.new(0, 10, 0, 20)
effectButton.Text = "Boost"
effectButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
effectButton.TextColor3 = Color3.new(1, 1, 1)
effectButton.Font = Enum.Font.Gotham
effectButton.TextSize = 14
Instance.new("UICorner", effectButton).CornerRadius = UDim.new(0, 6)

-- Boost Panel
local boostPanel = Instance.new("Frame", mainFrame)
boostPanel.Size = UDim2.new(1, -110, 1, -20)
boostPanel.Position = UDim2.new(0, 110, 0, 10)
boostPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", boostPanel).CornerRadius = UDim.new(0, 10)

-- Boost Toggle Button
local boostToggle = Instance.new("TextButton", boostPanel)
boostToggle.Size = UDim2.new(0, 100, 0, 40)
boostToggle.Position = UDim2.new(0, 10, 0, 10)
boostToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
boostToggle.Text = "Boost: OFF"
boostToggle.TextColor3 = Color3.new(1, 1, 1)
boostToggle.Font = Enum.Font.GothamBold
boostToggle.TextSize = 14
Instance.new("UICorner", boostToggle).CornerRadius = UDim.new(0, 6)

-- Close Button
local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 60, 0, 24)
closeButton.Position = UDim2.new(1, -70, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Text = "Close"
closeButton.Font = Enum.Font.Gotham
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextSize = 14
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

-- Open UI Button (Hidden until close)
local openUI = Instance.new("TextButton", gui)
openUI.Size = UDim2.new(0, 80, 0, 28)
openUI.Position = UDim2.new(0.5, -40, 0.5, -14)
openUI.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
openUI.Text = "Nov-scripts"
openUI.TextColor3 = Color3.new(1, 1, 1)
openUI.Font = Enum.Font.Gotham
openUI.TextSize = 14
openUI.Visible = false
openUI.Active = true
openUI.Draggable = true
Instance.new("UICorner", openUI).CornerRadius = UDim.new(0, 8)

-- Boost Logic
local boosted = false
local function enableBoost()
	pcall(function()
		setfflag("FIntTaskSchedulerTargetFps", "240")
		setfflag("RenderingQualityLevel", "0")
	end)
	local lighting = game:GetService("Lighting")
	pcall(function()
		lighting.GlobalShadows = false
		lighting.FogEnd = 1e10
		lighting.Brightness = 0
		lighting.EnvironmentDiffuseScale = 0
		lighting.EnvironmentSpecularScale = 0
	end)
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("Decal") or v:IsA("Texture") then
			pcall(function() v:Destroy() end)
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			pcall(function() v.Enabled = false end)
		elseif v:IsA("Part") or v:IsA("MeshPart") then
			pcall(function()
				v.Material = Enum.Material.SmoothPlastic
				v.Reflectance = 0
			end)
		end
	end
	collectgarbage("collect")
end

local function disableBoost()
	local lighting = game:GetService("Lighting")
	pcall(function()
		lighting.GlobalShadows = true
		lighting.FogEnd = 1000
		lighting.Brightness = 2
		lighting.EnvironmentDiffuseScale = 1
		lighting.EnvironmentSpecularScale = 1
	end)
end

-- Button Logic
boostToggle.MouseButton1Click:Connect(function()
	boosted = not boosted
	if boosted then
		boostToggle.Text = "Boost: ON"
		enableBoost()
	else
		boostToggle.Text = "Boost: OFF"
		disableBoost()
	end
end)

closeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	openUI.Visible = true
end)

openUI.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	openUI.Visible = false
end)
