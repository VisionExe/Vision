-- [[ ATOMICALS X EVOLUTION LIBRARY ]] --
local LoaderAsset = 15975611966

local guiParent = gethui and gethui() or game:GetService("CoreGui")
local Atomicals = guiParent:FindFirstChild("Atomicals X Evolution")

if Atomicals then
    Atomicals:Destroy()
    wait(1)
end

local UI = game:GetObjects('rbxassetid://'..LoaderAsset)[1]
UI.Name = "FarmPanel"
UI.Parent = guiParent
UI.Enabled = true

-- [[ END REGION ]] --

local tweenService = game:GetService("TweenService")

-- [[ ABT UI ]] --

local Open = false

-- [[ FIRST PARENT ]] --

local Home = UI.Home
local Character = UI.Character
local CustomScriptPrompt = UI.CustomScriptPrompt
local Disconnected = UI.Disconnected
local GameDetection = UI.GameDetection
local ModeratorDetectionPrompt = UI.ModeratorDetectionPrompt
local Music = UI.Music
local Notification = UI.Notifications
local PlayerList = UI.Playerlist
local ScriptSearch = UI.ScriptSearch
local Script = UI.Scripts
local SecurityPrompt = UI.SecurityPrompt
local Settings = UI.Settings
local SmartBar = UI.SmartBar
local Starlight = UI.Starlight
local Status = UI.Status
local Toasts = UI.Toasts

-- [[ MAKE INVISIBLE ]] --

local function Close()
    tweenService:Create(SmartBar, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0,1, 73)}):Play()
end

local function Open()
    tweenService:Create(SmartBar, TweenInfo.new(0.5,Enum.EasingStyle.Quint),  {Position = UDim2.new(0.5, 0,1.001, -12)}):Play() 
end

UI.Toggle:MouseButton1Click:Connect(function()
    if Open then
        Open = false
        Close()
    else
        Open = true
        Open()
    end
end)
    
