local espList = {
	["rbxassetid://4803700925"] = "Bracelet",
	["rbxassetid://4803701385"] = "Cup",
	["rbxassetid://5568274673"] = "Sealed Book"
}

local colorList = {
	["Bracelet"] = "135, 135, 135",
	["Cup"] = "188, 155, 93",
	["Sealed Book"] = "185, 185, 0"
}

local espPartList = {
	["248, 248, 248"] = "Paper"
}

-- Makes a label when called
local function CreateLabel(v, name, color)
	local Billboard = Instance.new("BillboardGui")
	Billboard.Name = math.random(100000,10000000)
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Name = math.random(100000,10000000)

	Billboard.Parent = v
	Billboard.AlwaysOnTop = true
	Billboard.LightInfluence = 1
	Billboard.Size = UDim2.new(0, 50, 0, 50)
	Billboard.StudsOffset = Vector3.new(0, 0, 0)

	TextLabel.Parent = Billboard
	TextLabel.BackgroundColor3 = color
	TextLabel.BackgroundTransparency = 1
	TextLabel.Size = UDim2.new(0.5, 0, 1, 0)
	TextLabel.Text = name
	TextLabel.TextColor3 = color
	TextLabel.TextScaled = true
end

local function ESPList(v)
	local mesh = v:FindFirstChildWhichIsA("MeshPart")
	if mesh then
		local meshId = mesh.MeshId
		if meshId == "rbxassetid://5377886306" then
			--Stops crystals from showing on the esp
		elseif espList[meshId] then
			local name = espList[meshId]
			local color = mesh.Color
			--[[if colorList[name] then
				color = colorList[name]
			end]]
			CreateLabel(mesh, name, color)
		end
	else
		for i, v in pairs(v:GetChildren()) do
			if v:IsA("Part") then
				local color = v.Color
				local colorSplit = tostring(color.R)..", "..tostring(color.G)..", "..tostring(color.B)
				if espPartList[colorSplit] then
					CreateLabel(v, espPartList[colorSplit], color)
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
