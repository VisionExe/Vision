local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local UIG=Instance.new("UIGradient")
local DropShadowHolder = Instance.new("Frame")
local DropShadow = Instance.new("ImageLabel")
local UICornerMain = Instance.new("UICorner")
local UIGradient=Instance.new("UIGradient")
local UIGradientTitle=Instance.new("UIGradient")

local function object(class, properties)
	local localObject = Instance.new(class)

	pcall(function()
		localObject.BorderSizePixel = 0
		localObject.BackgroundColor3 = Color3.fromRGB(255,255,255)
		localObject.AutoButtonColor = false
	end)

	for property, value in next, properties do
		localObject[property] = value
	end

	local methods = {}

	function methods:object(class, properties)
		if not properties["Parent"] then
			properties.Parent = localObject
		end
		return object(class, properties)
	end

	function methods:round(radius)
		radius = radius or 4
		object("UICorner", {
			Parent = localObject,
			CornerRadius = UDim.new(0, radius)
		})
		return methods
	end

	function methods:tween(mutations)
		ts:Create(localObject, TweenInfo.new(0.25), mutations):Play()
	end

	methods.AbsoluteObject = localObject

	return setmetatable(methods, {
		__index = function(_, k)
			return localObject[k]
		end,
		__newindex = function(_, k, v)
			localObject[k] = v
		end,
	})
end

--[[if not ((rs:IsStudio() and game.Players.LocalPlayer.PlayerGui) or game.CoreGui):FindFirstChild("Abstract Notifications") then

end]]

local gui = object("ScreenGui", {
	Parent = (rs:IsStudio() and game.Players.LocalPlayer.PlayerGui) or game.CoreGui
})

local notifications = {
	theme = "dark",
	colorSchemes = {
		dark = {
			Main = Color3.fromRGB(40, 40, 45),
			Secondary = Color3.fromRGB(30, 30, 35),
			Icon = Color3.fromRGB(255, 255, 255),
			Text = Color3.fromRGB(255, 255, 255),
			SecondaryText = Color3.fromRGB(200, 200, 200),
			Accept = Color3.fromRGB(60, 40, 200),
			Dismiss = Color3.fromRGB(60, 60, 65)
		}
	},
	closeOpened = nil
}

function notifications:notify(options)
	local theme = self.colorSchemes[notifications.theme]
	local callbacksBool = options.Accept or options.Dismiss
	options.Title = options.Title or "Notification"
	if not callbacksBool then
		options.Length = 3
	end
	if self.closeOpened then
		self.closeOpened()
	end

	local mainFrame = gui:object("Frame", {
		Size = UDim2.fromOffset(400, (callbacksBool and 100) or 56),
		Position = UDim2.new(1, -20, 1, -10),
		AnchorPoint = Vector2.new(1, 1),
		BackgroundColor3 = theme.Main,
		Visible = false,
		BackgroundTransparency = 1 --
	}):round()

	local content = mainFrame:object("Frame", {
		Size = UDim2.new(1, 0, 1, ((callbacksBool and -44) or 0)),
		BackgroundTransparency = 1
	})

	local icon = content:object("ImageLabel", {
		Image = (options.Icon and ("rbxassetid://" .. tostring(options.Icon))) or "rbxassetid://6031071053",
		BackgroundTransparency = 1,
		ImageColor3 = theme.Icon,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 15, 0.5, 0),
		Size = UDim2.fromOffset(30, 30),
		ImageTransparency = 1
	})

	local title = content:object("TextLabel", {
		TextColor3 = theme.Text,
		Font = Enum.Font.SourceSansSemibold,
		TextSize = 18,
		Position = UDim2.fromOffset(60, 10),
		Size = UDim2.new(1, -70, 0, 18),
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Text = options.Title,
		RichText = true,
		TextTransparency = 1 --
	})

	local description; if options.Description then
		description = content:object("TextLabel", {
			TextColor3 = theme.SecondaryText,
			Font = Enum.Font.SourceSans,
			TextSize = 18,
			Position = UDim2.new(0, 60, 1, -10),
			Size = UDim2.new(1, -70, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0, 1),
			Text = options.Description,
			TextWrapped = true,
			RichText = true,
			TextTransparency = 1 --
		})
	end

	local callbacksContainer; if callbacksBool then 
		callbacksContainer = mainFrame:object("Notip", {
			Size = UDim2.new(1, 0, 0, 44),
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.fromScale(0, 1),
			BackgroundColor3 = theme.Secondary,
			BackgroundTransparency = 1 --
		}):round()

		local roundCorrection = callbacksContainer:object("Frame", {
			Size = UDim2.fromScale(1, 0.5),
			BackgroundColor3 = theme.Secondary,
			BackgroundTransparency = 1 --
		})
	end

	DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = Notip
    DropShadowHolder.BackgroundTransparency = 0.000
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.BorderColor3 = Color3.fromRGB(255,255,255)
    DropShadowHolder.ZIndex = 0

    DropShadow.Name = "DropShadow"
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1.000
    DropShadow.BorderSizePixel = 0
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 45, 1, 45)
    DropShadow.ZIndex = 0
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.fromRGB(255,255,255)
    DropShadow.ImageTransparency = 0.300
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

    loadstring(game:HttpGet(("https://raw.githubusercontent.com/VisionExe/Vision/main/AtomicR.lua"),true))()
    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))}
    UIGradient.Parent = DropShadow

    local TweenService = game:GetService("TweenService")
    local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
    tween:Play()
        function toggleui()
          toggled = not toggled
          spawn(function()
              if toggled then wait(0.3) end
          end)
          Tween(Main, {0.3, 'Sine', 'InOut'}, {
              Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
          })
      end

	local close

	local acceptButton; if options.Accept then
		options.Accept.Callback = options.Accept.Callback or function() end
		acceptButton = callbacksContainer:object("TextButton", {
			Size = UDim2.new(0, 100, 0.5, 0),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundColor3 = theme.Accept,
			AnchorPoint = Vector2.new(0.5, 0.5),
			TextColor3 = theme.Text,
			Font = Enum.Font.SourceSans,
			TextSize = 18,
			Text = options.Accept.Text or "Yes",
			BackgroundTransparency = 1, --
			TextTransparency = 1 --
		}):round()

		if acceptButton.TextBounds.X > 100 then
			acceptButton.Size = UDim2.new(0, acceptButton.TextBounds.X + 10, 0.5, 0)
		end

		acceptButton.MouseButton1Click:connect(function()
			options.Accept.Callback()
			close()
		end)
	end

	local dismissButton; if options.Dismiss then
		options.Dismiss.Callback = options.Dismiss.Callback or function() end
		dismissButton = callbacksContainer:object("TextButton", {
			Size = UDim2.new(0, 100, 0.5, 0),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundColor3 = theme.Dismiss,
			AnchorPoint = Vector2.new(0.5, 0.5),
			TextColor3 = theme.Text,
			Font = Enum.Font.SourceSans,
			TextSize = 18,
			Text = options.Dismiss.Text or "No",
			BackgroundTransparency = 1, --
			TextTransparency = 1 --
		}):round()

		if dismissButton.TextBounds.X > 100 then
			dismissButton.Size = UDim2.new(0, dismissButton.TextBounds.X + 10, 0.5, 0)
		end

		dismissButton.MouseButton1Click:connect(function()
			options.Dismiss.Callback()
			close()
		end)
	end

	local closing = false

	close = function()
		closing = false
		self.closeOpened = nil
		spawn(function()
			icon:tween{ImageTransparency = 1}
			title:tween{TextTransparency = 1}
			if description then description:tween{TextTransparency = 1} end
			if acceptButton then acceptButton:tween{BackgroundTransparency = 1, TextTransparency = 1} end
			if dismissButton then dismissButton:tween{BackgroundTransparency = 1, TextTransparency = 1} end
			task.wait(0.15)
			if callbacksContainer then callbacksContainer:tween{BackgroundTransparency = 1} end
			task.wait(0.1)
			mainFrame:tween{BackgroundTransparency = 1, Position = UDim2.new(1, -20, 1, -10)}
			task.wait(0.25)
			mainFrame.AbsoluteObject:Destroy()
		end)
	end

	self.closeOpened = close

	if options.Description and description.TextBounds.Y > 18 then
		mainFrame.Size = UDim2.fromOffset(mainFrame.AbsoluteSize.X, description.TextBounds.Y + (38 + ((callbacksBool and 44) or 0)))
	end

	mainFrame.Size = UDim2.fromOffset(math.clamp(math.max((((acceptButton and acceptButton.AbsoluteSize.X) or 100) + ((dismissButton and dismissButton.AbsoluteSize.X) or 100) + 30) or 230, 70 + description.TextBounds.X), 230, 400), mainFrame.AbsoluteSize.Y)

	description.Size = UDim2.new(1, -70, 0, description.TextBounds.Y)

	if options.Accept and options.Dismiss then
		acceptButton.Position = UDim2.new(0.5, 5, 0.5, 0)
		acceptButton.AnchorPoint = Vector2.new(0, 0.5)
		dismissButton.Position = UDim2.new(0.5, -5, 0.5, 0)
		dismissButton.AnchorPoint = Vector2.new(1, 0.5)
	end

	mainFrame.Visible = true

	spawn(function()
		mainFrame:tween{BackgroundTransparency = 0, Position = UDim2.new(1, -20, 1, -20)}
		task.wait(0.1)
		if callbacksContainer then callbacksContainer:tween{BackgroundTransparency = 0} end
		task.wait(0.15)
		icon:tween{ImageTransparency = 0}
		title:tween{TextTransparency = 0}
		if description then description:tween{TextTransparency = 0} end
		if acceptButton then acceptButton:tween{BackgroundTransparency = 0, TextTransparency = 0} end
		if dismissButton then dismissButton:tween{BackgroundTransparency = 0, TextTransparency = 0} end
		if options.Length then
			task.wait(options.Length)
			if not closing then
				wait(6)
				close()
			end
		end
	end)
end

function notifications:notification(options)
	self:notify(options)
end

function notifications:message(options)
	self:notify(options)
end

return notifications


wait(99999999999999999999999)
