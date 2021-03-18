local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local Players;
local Player;

repeat wait() until game.IsLoaded and game:GetService("Players") ~= nil
Players = game:GetService("Players")
repeat wait() until Players.LocalPlayer ~= nil
Player = Players.LocalPlayer
repeat wait() until Player.Character ~= nil
repeat wait() until Player.Character.HumanoidRootPart ~= nil
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
	"XANCYUO",
	"Lanesmoe03"
}

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
for i,v in pairs(Players:GetPlayers()) do
	print("checkedplayer")
	if table.find(playerKOS, v.Name) then
		notify(v.Name)
	end
end

-- Notifies if a player on the list joins your game
Players.PlayerAdded:Connect(function(Player)
	if table.find(playerKOS, Player.Name) then
		notify(Player.Name)
	end
end)
