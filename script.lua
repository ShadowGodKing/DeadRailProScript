--[[
💀 Dead Rail Pro Script
Made for mobile + PC (KRNL)
Author: NyxSoulFire
--]]

-- SETTINGS --
getgenv().AutoLoot = false
getgenv().AutoSell = false
getgenv().AutoTPBond = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local TrainFolder = workspace:WaitForChild("Trains")
local ATMFolder = workspace:WaitForChild("ATMs")

-- Chat Commands --
LocalPlayer.Chatted:Connect(function(msg)
	msg = msg:lower()
	if msg == "/start" then
		getgenv().AutoLoot = true
		getgenv().AutoSell = true
		getgenv().AutoTPBond = true
	elseif msg == "/stop" then
		getgenv().AutoLoot = false
		getgenv().AutoSell = false
		getgenv().AutoTPBond = false
	elseif msg == "/loot" then
		getgenv().AutoLoot = not getgenv().AutoLoot
	elseif msg == "/sell" then
		getgenv().AutoSell = not getgenv().AutoSell
	elseif msg == "/tpbond" then
		getgenv().AutoTPBond = not getgenv().AutoTPBond
	end
end)

-- Auto TP to Bonds on Train --
task.spawn(function()
	while task.wait(1) do
		if getgenv().AutoTPBond then
			for _, train in pairs(TrainFolder:GetChildren()) do
				for _, bond in pairs(train:GetDescendants()) do
					if bond:IsA("ProximityPrompt") and bond.Parent:FindFirstChild("Cash") then
						LocalPlayer.Character:PivotTo(bond.Parent.CFrame + Vector3.new(0, 3, 0))
						wait(0.3)
						fireproximityprompt(bond)
					end
				end
			end
		end
	end
end)

-- Auto Loot ATMs --
task.spawn(function()
	while task.wait(1) do
		if getgenv().AutoLoot then
			for _, atm in pairs(ATMFolder:GetChildren()) do
				local prompt = atm:FindFirstChildWhichIsA("ProximityPrompt", true)
				if prompt then
					LocalPlayer.Character:PivotTo(prompt.Parent.CFrame + Vector3.new(0, 3, 0))
					wait(0.2)
					fireproximityprompt(prompt)
				end
			end
		end
	end
end)

-- Auto Sell Loot --
task.spawn(function()
	while task.wait(1) do
		if getgenv().AutoSell then
			local sellZone = workspace:FindFirstChild("SellZone")
			if sellZone then
				LocalPlayer.Character:PivotTo(sellZone.CFrame + Vector3.new(0, 3, 0))
				wait(0.5)
			end
		end
	end
end)

print("✅ Dead Rail Pro Script Loaded - Mobile/PC Ready")
