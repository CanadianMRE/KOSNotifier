local espMeshList = {
	["rbxassetid://4803700925"] = "Bracelet",
	["rbxassetid://4803701385"] = "Cup",
	["rbxassetid://5568274673"] = "Sealed Book",
	["rbxassetid://5574837725"] = "Cursed Book",
}

local colorList = {
	["Bracelet"] = Color3.fromRGB(135, 135, 135),
	["Cup"] = Color3.fromRGB(188, 155, 93),
	["Sealed Book"] = Color3.fromRGB(185, 185, 0),
	["Cursed Book"] = Color3.fromRGB(74, 5, 176)
}

local espPartList = {
	[tostring(Color3.fromRGB(248, 248, 248))] = "Paper"
}

-- Makes a label when called
local function CreateLabel(v, name, color)
	local Billboard = Instance.new("BillboardGui")
	syn.protect_gui(Billboard)
	Billboard.Name = math.random(100000,10000000)
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Name = math.random(100000,10000000)

	Billboard.Parent = game:GetService("CoreGui")
	Billboard.Adornee = v
	Billboard.AlwaysOnTop = true
	Billboard.LightInfluence = 1
	Billboard.Size = UDim2.new(0, 50, 0, 50)
	Billboard.StudsOffset = Vector3.new(0.3, 0.1, -0.2)

	TextLabel.Parent = Billboard
	TextLabel.BackgroundColor3 = color
	TextLabel.BackgroundTransparency = 1
	TextLabel.Size = UDim2.new(0.5, 0, 1, 0)
	TextLabel.Text = name
	TextLabel.TextColor3 = color
	TextLabel.TextScaled = true
	TextLabel.BorderMode = "Outline"
	TextLabel.BorderSizePixel = 2
	TextLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
end

local function ESPList(v)
	local mesh = v:FindFirstChildWhichIsA("MeshPart")
	if mesh then
		local meshId = mesh.MeshId
		if meshId == "rbxassetid://5377886306" then
			--Stops crystals from showing on the esp
		elseif espMeshList[meshId] then
			local name = espMeshList[meshId]
			local color = "255, 255, 255"
			if colorList[name] then
				color = colorList[name]
			end
			CreateLabel(mesh, name, color)
		end
	else
		for i, n in pairs(v:GetChildren()) do
			if n:IsA("UnionOperation") then
				if espPartList[tostring(n.Color)] then
					CreateLabel(n, espPartList[tostring(n.Color)], Color3.fromRGB(248, 248, 248))
				end
			elseif n:IsA("Part") and n:FindFirstChildWhichIsA("ParticleEmitter") then
				local emitter = n:FindFirstChildWhichIsA("ParticleEmitter")
				if emitter.Texture == "rbxassetid://282305485" then
					CreateLabel(n, "Soul Piece", Color3.fromRGB(176, 5, 5))
				end
			end
		end
	end
end

for i,v in pairs(game.Workspace.Map.DlTrinket:GetChildren()) do
	ESPList(v)
end

game.Workspace.Map.DlTrinket.ChildAdded:Connect(function(v)
	ESPList(v)
end)
