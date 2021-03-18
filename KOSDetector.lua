local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local Players;
local Player;
local sound;

repeat wait() until game.IsLoaded and game:GetService("Players") ~= nil
Players = game:GetService("Players")
repeat wait() until Players.LocalPlayer ~= nil
Player = Players.LocalPlayer

repeat wait() until Player.Character ~= nil
wait(1)

print("test")

repeat wait() until Player.Character.HumanoidRootPart.RagingDemon ~= nil
sound = Player.Character.HumanoidRootPart.RagingDemon
print("test2")

-- Players on KOS
local bannedplayers = {
	"AltroScraps",
	"aahoura",
	"koehiii",
	"guest1455386",
	"XANCYUO",
	"Lanesmoe03"
}

local function notify(plr)
	sound:Play()
	StarterGui:SetCore("SendNotification", {
		Title = "Notification";
		Text = plr.." is in your game. They are on KOS. GET THEM!";
		Duration = 5;
		Button1 = "OK";
	})
end

for i,v in pairs(Players:GetPlayers()) do
print("checkedplayer")
	if table.find(bannedplayers, v.Name) then
		notify(v.Name)
	end
end

Players.PlayerAdded:Connect(function(Player)
	if table.find(bannedplayers, Player.Name) then
		notify(Player.Name)
	end
end)
