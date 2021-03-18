local WebhookLink = "https://discord.com/api/webhooks/791912583577206784/6hWeseY_iRunXQdmWLDu-lnTkwlRhM7jklAZ9nCRYB9JUZkTLClrxKeWBOBNknHpKYlg"
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

-- House KOS List
local houseKOS = {
	"XIV"
}

-- KOS list
local playerKOS = {
	"AltroScraps",
	"aahoura",
	"koehiii",
	"guest1455386",
	"XANCYUO"
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
				["description"] = "Found by: "..Player.Name,
				["color"] = 16711680,

				["fields"] = {
					{
						["name"] = "Job ID: ",
						["value"] = game.JobId
					},
					{
						["name"] = "Account Join Link: ",
						["value"] = "https://www.roblox.com/users/"..Player.UserId
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
local function notify(plr)
	sound:Play()
	StarterGui:SetCore("SendNotification", {
		Title = "Notification";
		Text = plr.." is in your game. They are on KOS. GET THEM!";
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
		notify(plr.Name)
		WebhookMessage(plr.Name, House)
	end
	if KOSInHouse == false then
		if table.find(playerKOS, plr.Name) then
			notify(plr.Name)
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
