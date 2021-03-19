local WebhookLink = _G.WebhookLink
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
sound.SoundId = "rbxassetid://6223512980"
local sound2 = Instance.new("Sound", Player.Character.HumanoidRootPart)
sound2.Name = math.random(100000, 10000000)
sound2.SoundId = "rbxassetid://6537801467"

-- House KOS List
local houseKOS = {
	"Xiv",
	"Catboy"
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
	"Noceres"
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
	"More info needed"-- Noceres
}

local function getHouse(plr)
	for i,v in pairs(plr.Character:GetChildren()) do
		if v:IsA("Model") and v:FindFirstChild("FakeHumanoid") then
			local name = v.Name
			name = name:split(" ")
			if name[2] then
				print(name[2])
				return name[2]
			else
				print("No House")
				return;
			end
		end
	end
end

-- Sends message saying who found the enemy and what server they are in
local function WebhookMessage(msg)
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
local function notify(text)
	sound:Play()
	StarterGui:SetCore("SendNotification", {
		Title = "Notification";
		Text = text;
		Duration = 5;
		Button1 = "OK";
	})
end

-- Notifies if players are found on join
for i,plr in pairs(Players:GetPlayers()) do
	print("-----------------")
	local KOSInHouse = false
	local House = getHouse(plr)
	if table.find(houseKOS, House) then
		KOSInHouse = true
		notify(plr.Name.." is in your game. They are on KOS. GET THEM!")
		WebhookMessage(plr.Name, House)
	end
	if KOSInHouse == false then
		if table.find(playerKOS, plr.Name) then
			notify(plr.Name.." is in your game. They are on KOS. GET THEM!")
			WebhookMessage(plr.Name)
		end
	end
end

-- Notifies if a player on the list joins your game
Players.PlayerAdded:Connect(function(plr)
	if table.find(playerKOS, plr.Name) then
		notify(plr.Name)
		WebhookMessage(plr.Name)
	end
end)
