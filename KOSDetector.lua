local WebhookLink = "https://discord.com/api/webhooks/822336289969799178/p6kO3QI1-4Ph_UNAhhdMblWDCWGTWvlBu_4BvrVXtKEWdwcvng8ssviRci1R_4ss9bBj"
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- House KOS List
local houseKOS = {
	["Xiv"] = "using their members to wipe some of ours in tomeless.",
	["Catboy"] = "having a gay house name."
}

-- KOS list
local playerKOS = {
	["AltroScraps"] = "being a Xiv member.",
	["aahoura"] = "being a Xiv member. Also helped with tomeless wipe.",
	["koehiii"] = "being a Xiv member. Also helped with tomeless wipe.",
	["guest1455386"] = "being a Xiv member. Also helped with tomeless wipe.",
	["XANCYUO"] = "being a snitch ass bitch",
	["eliteghosthaircut"] = "being a gaiadweller who chases through servers.",
	["caym354"] = "being a gaiadweller who chases through servers.",
	["eIaMain"] = "being a gaiadweller who chases through servers.",
	["EliteGhost2992"] = "being a gaiadweller who chases through servers.",
	["jaiden2195"] = "being a gaiadweller who chases through servers.",
	["potatoladnine"] = "being a gaiadweller who chases through servers.",
	["Gentrems"] = "being a gaiadweller.",
	["Pls_dzinShifter"] = "being a gaiadweller."
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
local function WebhookMessage(plr, rsn)
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
						["value"] = plr
					},
					{
						["name"] = "Reasoning:",
						["value"] = "For "..rsn
					}
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
	StarterGui:SetCore("SendNotification", {
		Title = "KOSList";
		Text = text;
		Duration = 5000;
		Button1 = "OK";
	})
end

-- Notifier
local function illuNotify(text)
	StarterGui:SetCore("SendNotification", {
		Title = "Illusionist";
		Text = text;
		Duration = 5000;
		Button1 = "OK";
	})
end

local function checkKOS(plr, character)
	local KOSInHouse = false
	local House = getHouse(plr)
	
	if houseKOS[House] then
		KOSInHouse = true
		notify(plr.Name.." is in your game. They are on KOS due to "..houseKOS[House])
		WebhookMessage(plr.Name, houseKOS[plr.Name])
	end
	if KOSInHouse == false then
		if playerKOS[plr.Name] then
			notify(plr.Name.." is in your game. They are on KOS due to "..playerKOS[plr.Name])
			WebhookMessage(plr.Name, playerKOS[plr.Name])
		end
	end
	if plr.Backpack then
		if plr.Backpack:FindFirstChild("Observe") or plr.Backpack:FindFirstChild("Custos") or plr.Backpack:FindFirstChild("Claritum") then
			illuNotify(plr.Name, "Illusionist")
		end
	end
end

-- Notifies if players are found on join
for i,plr in pairs(Players:GetPlayers()) do
	if plr.Character then
	    checkKOS(plr, character)
	else
		plr.CharacterAdded:Connect(function(character)
			checkKOS(plr, character)
		end)
	end
end

-- Notifies if a player on the list joins your game
Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(character)
		checkKOS(plr, character)
	end)
end)
