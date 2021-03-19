local WebhookLink = "https://discord.com/api/webhooks/791912583577206784/6hWeseY_iRunXQdmWLDu-lnTkwlRhM7jklAZ9nCRYB9JUZkTLClrxKeWBOBNknHpKYlg" --_G.WebhookLink
local StarterGui = game:GetService("StarterGui")
local Players;
local Player;

-- Wait until play is pressed
repeat wait() until game.IsLoaded and game:GetService("Players") ~= nil
Players = game:GetService("Players")
repeat wait() until Players.LocalPlayer ~= nil
Player = Players.LocalPlayer
repeat wait() until Player.Character ~= nil
repeat wait() until Player.Character.HumanoidRootPart ~= nil

-- Make sound object with random name
local sound = Instance.new("Sound", Player.Character.HumanoidRootPart)
sound.Name = math.random(100000, 10000000)
sound.SoundId = "rbxassetid://6537801467"
local sound2 = Instance.new("Sound", Player.Character.HumanoidRootPart)
sound2.Name = math.random(100000, 10000000)
sound2.SoundId = "rbxassetid://6223512980"

-- House KOS List
local houseKOS = {
	"Xiv",
	"Catboy",
	"Exia"
}

local houseKOSReasons = {
	"Annoying House which wiped 2 house members with tomeless pit",-- Xiv
	"Kinda gay tbh :/"-- Catboy
}

-- KOS list
local playerKOS = {
	"AltroScraps",
	"aahoura",
	"koehiii",
	"guest1455386",
	"XANCYUO",
	"eliteghosthaircut",
	"caym354",
	"eIaMain",
	"EliteGhost2992",
	"jaiden2195",
	"potatoladnine",
	"Gentrems",
	"Pls_dzinShifter",
	"Noceres",
	"reptarogs"
}

local playerKOSReasons = {
	"FF Bard, Xiv member",-- AltroScraps
	"Xiv member. Helped with tomeless",-- aahoura
	"Xiv member. Helped with tomeless",-- koehiii
	"Xiv member. Helped with tomeless",-- guest1455386
	"Snitch ass bitch",-- XANCYUO
	"Gaia dweller. Chases people through servers to ruin prog",-- eliteghosthaircut
	"Gaia dweller. Chases people through servers to ruin prog",-- caym354
	"Gaia dweller. Chases people through servers to ruin prog",-- eIaMain
	"Gaia dweller. Chases people through servers to ruin prog",-- EliteGhost2992
	"Gaia dweller. Chases people through servers to ruin prog",-- jaiden2195
	"Gaia dweller. Chases people through servers to ruin prog",-- potatoladnine
	"Gaian dsage. Basic dweller",-- Gentrems
	"Gaian shinobi. Basic dweller",-- Pls_dzinShifter
	"More info needed",-- Noceres,
	"Kinda cringe"
}

local function getHouse(plr)
	for i,v in pairs(plr.Character:GetChildren()) do
		if v:IsA("Model") and v:FindFirstChild("FakeHumanoid") then
			local name = v.Name
			name = name:split(" ")
			if name[2] then
				return name[2]
			else
				return;
			end
		end
	end
end

-- Sends message saying who found the enemy and what server they are in
local function WebhookMessage(msg, rsn)
	local Message = {
		["content"] = "@here",
		["embeds"] = {
			{
				["title"] = "Found Player on KOS",
				["color"] = 16711680,

				["fields"] = {
					{
						["name"] = "Job ID: ",
						["value"] = game.JobId
					},
					{
						["name"] = "Player Found:",
						["value"] = msg
					},
					{
						["name"] = "Reasoning:",
						["value"] = rsn
					}
				},

				["footer"] = {
					["text"] = "by CanadianMRE#6288"
				}
			}
		}
	}


	syn.request({
		Url = tostring(WebhookLink),
		Method = 'POST',
		Headers = {
			['Content-Type'] = 'application/json'
		},
		Body = game:GetService('HttpService'):JSONEncode(Message)
	});
end



-- Notifier
local function notify(text, rsn)
	StarterGui:SetCore("SendNotification", {
		Title = "Illusionist";
		Text = text;
		Duration = 5000;
		Button1 = "OK";
	})
end

-- Notifies if players are found on join
for i,plr in pairs(Players:GetPlayers()) do
	local KOSInHouse = false
	local House = getHouse(plr)
	for o, v in pairs(houseKOS) do
		if House == v then
        	sound:Play()
			KOSInHouse = true
			notify(plr.Name.." is in your game. They are on KOS. GET THEM!", houseKOSReasons[o])
			WebhookMessage(plr.Name, houseKOSReasons[o])
		end
	end
	if KOSInHouse == false then
		for o, v in pairs(playerKOS) do
			if plr.Name == v then
            	sound:Play()
				notify(plr.Name.." is in your game. They are on KOS. GET THEM!", houseKOSReasons[o])
				WebhookMessage(plr.Name, playerKOSReasons[o])
			end
		end
	end
end

-- Notifies if a player on the list joins your game
Players.PlayerAdded:Connect(function(plr)
	local KOSInHouse = false
	local House = getHouse(plr)
	for o, v in pairs(houseKOS) do
		if House == v then
        	sound:Play()
			KOSInHouse = true
			notify(plr.Name.." is in your game. They are on KOS. GET THEM!", houseKOSReasons[o])
			WebhookMessage(plr.Name, houseKOSReasons[o])
		end
	end
	if KOSInHouse == false then
		for o, v in pairs(playerKOS) do
			if plr.Name == v then
            	sound:Play()
				notify(plr.Name.." is in your game. They are on KOS. GET THEM!", houseKOSReasons[o])
				WebhookMessage(plr.Name, playerKOSReasons[o])
			end
		end
	end
end)

-- Illusionist shit
for i, plr in pairs(Players:GetPlayers()) do
	if plr.Backpack:FindFirstChild("Observe") then
        sound2:Play()
		notify(plr.Name, "Illusionist")
	end
end

Players.PlayerAdded:Connect(function(plr)
    if plr.Backpack:FindFirstChild("Observe") then
        sound2:Play()
		notify(plr.Name, "Illusionist")
	end
end)
