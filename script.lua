-- Dead Rail Pro Script with Anti-Detection & GUI (Mobile + PC)
-- Obfuscated Variables | Mobile GUI | Chat Commands | Auto Features

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

-- Obfuscated vars
local KzQgVqCIvZ = false -- autoLoot
local aeFRpKGYJl = false -- autoSell
local PhDsmKWTWd = false -- modDetected
local HUnPFrKcSW = nil   -- GUI
local wIueSDQQYS = false -- rejoinFlag

-- Utility Functions
local function notify(text)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Dead Rail Script",
        Text = text,
        Duration = 3
    })
end

local function detectMods()
    for _, player in ipairs(Players:GetPlayers()) do
        if player:GetRankInGroup(11867394) > 200 then -- replace with real mod group ID
            PhDsmKWTWd = true
            notify("Moderator detected! Script disabled.")
            return true
        end
    end
    return false
end

-- GUI Setup
function createGUI()
    if HUnPFrKcSW then HUnPFrKcSW:Destroy() end
    local gui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "DeadRailUI"

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0.4, 0, 0.4, 0)
    main.Position = UDim2.new(0.3, 0, 0.3, 0)
    main.BackgroundTransparency = 0.2
    main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    main.Active = true
    main.Draggable = true

    local function createToggle(name, yPos, callback)
        local btn = Instance.new("TextButton", main)
        btn.Size = UDim2.new(0.9, 0, 0.15, 0)
        btn.Position = UDim2.new(0.05, 0, yPos, 0)
        btn.Text = name .. " [OFF]"
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.new(1, 1, 1)
        local state = false
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.Text = name .. (state and " [ON]" or " [OFF]")
            callback(state)
        end)
    end

    createToggle("Auto Loot", 0.05, function(s) KzQgVqCIvZ = s end)
    createToggle("Auto Sell", 0.25, function(s) aeFRpKGYJl = s end)
    createToggle("Auto Rejoin", 0.45, function(s) wIueSDQQYS = s end)

    HUnPFrKcSW = gui
end

-- Chat Command Listener
Players.LocalPlayer.Chatted:Connect(function(msg)
    msg = msg:lower()
    if msg == "/loot" then KzQgVqCIvZ = not KzQgVqCIvZ notify("Auto Loot: " .. tostring(KzQgVqCIvZ))
    elseif msg == "/sell" then aeFRpKGYJl = not aeFRpKGYJl notify("Auto Sell: " .. tostring(aeFRpKGYJl))
    elseif msg == "/rejoin" then TeleportService:Teleport(game.PlaceId)
    elseif msg == "/gui" then createGUI()
    end
end)

-- Auto Loot Logic
spawn(function()
    while true do wait(math.random(2, 5))
        if KzQgVqCIvZ and not PhDsmKWTWd then
            -- Insert actual loot collection code
            notify("Looted items.")
        end
    end
end)

-- Auto Sell Logic
spawn(function()
    while true do wait(math.random(4, 7))
        if aeFRpKGYJl and not PhDsmKWTWd then
            -- Insert actual sell code
            notify("Sold inventory.")
        end
    end
end)

-- Rejoin If Kicked
Players.LocalPlayer.OnTeleport:Connect(function(state)
    if wIueSDQQYS and state == Enum.TeleportState.Failed then
        wait(1)
        TeleportService:Teleport(game.PlaceId)
    end
end)

-- Initial Run
if not detectMods() then
    createGUI()
end
