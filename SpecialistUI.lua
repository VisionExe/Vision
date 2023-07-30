--[[

 UI Library for gabriel
 Credit to me :3

  ________    _         ___ __                             __         
 /_  __/ /_  (_)____   / (_) /_  _________ ________  __   / /_  __  __
  / / / __ \/ / ___/  / / / __ \/ ___/ __ `/ ___/ / / /  / __ \/ / / /
 / / / / / / (__  )  / / / /_/ / /  / /_/ / /  / /_/ /  / /_/ / /_/ / 
/_/ /_/ /_/_/____/  /_/_/_.___/_/   \__,_/_/   \__, /  /_.___/\__, /  
                                              /____/         /____/   

  ____   ___            _                     _       _ _     _   
 | ___| / _ \  ___ __ _| |___ _ __   ___  ___(_) __ _| (_)___| |_ 
 |___ \| | | |/ __/ _` | / __| '_ \ / _ \/ __| |/ _` | | / __| __|
  ___) | |_| | (_| (_| | \__ \ |_) |  __/ (__| | (_| | | \__ \ |_ 
 |____/ \___/ \___\__,_|_|___/ .__/ \___|\___|_|\__,_|_|_|___/\__|
                             |_|                                  

                             Helped by silentben8x.

]]--

--# NN

local library = {}
library.flags = {}
library.currentTab = nil
local toggled = false
local mouse = game.Players.LocalPlayer:GetMouse()

local theme = {
	main = Color3.fromRGB(37, 37, 37),
	secondary = Color3.fromRGB(42, 42, 42),
	accent = Color3.fromRGB(255, 255, 255),
	accent2 = Color3.fromRGB(57, 57, 57)
}

function Tween(obj,size,delay)
	obj:TweenSize(size,"Out","Sine",delay,false)
end

function Tween2(obj, t, data)
	game:GetService("TweenService"):Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
	return true
end

function Ripple(obj)
	spawn(function()
		if obj.ClipsDescendants ~= true then
			obj.ClipsDescendants = true
		end
		local Ripple = Instance.new("ImageLabel")
		Ripple.Name = "Ripple"
		Ripple.Parent = obj
		Ripple.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Ripple.BackgroundTransparency = 1.000
		Ripple.ZIndex = 8
		Ripple.Image = "rbxassetid://2708891598"
		Ripple.ImageTransparency = 0.800
		Ripple.ScaleType = Enum.ScaleType.Fit
		Ripple.ImageColor3 = Color3.fromRGB(0,0,0)
		Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
		Tween2(Ripple, {.3, 'Linear', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
		wait(0.15)
		Tween2(Ripple, {.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
		wait(.3)
		Ripple:Destroy()
	end)
end

local changeingTab = false
function SwitchTab(Tab)
	if changeingTab == true then print("Changing Tab") return end
	local Old = library.currentTab
	if Old == nil then
		library.currentTab = Tab[1]
		Tab[1].Visible = true
		return
	end
	if Tab[1].Visible == true then return end
	changeingTab = true
	Tween(Old.Parent,UDim2.new(0, 440,0, 0),.15)
	Old.Visible = false
	wait(0.5)
	Tab[1].Visible = true
	Tween(Tab[1].Parent,UDim2.new(0, 440,0, 318),.15)
	library.currentTab = Tab[1]
	wait(.1)
	changeingTab = false
end

function drag(frame, hold) -- Skidded from Kiriot or Wally ~V3rmillion~
	if not hold then
		hold = frame
	end
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	hold.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function library:Create(title)
	local ArtemisSpecialist = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local MainFrameC = Instance.new("UICorner")
	local SideFrame = Instance.new("Frame")
	local SideFrameC = Instance.new("UICorner")
	local TabContainer = Instance.new("ScrollingFrame")
	local TabOpen = Instance.new("TextButton")
	local TabContainerL = Instance.new("UIListLayout")
	local TabContainerP = Instance.new("UIPadding")
	local TabHolder = Instance.new("Frame")
	local TabHolderC = Instance.new("UICorner")
	local TopFrame = Instance.new("Frame")
	local SideFrameC_2 = Instance.new("UICorner")
	local Title = Instance.new("TextLabel")
	local Glow = Instance.new("ImageLabel")

	function DestroyUI()
		ArtemisSpecialist:Destroy()
	end

	ArtemisSpecialist.Name = "ArtemisSpecialist"
	ArtemisSpecialist.Parent = game:GetService("RunService"):IsStudio() and game.Players.LocalPlayer:WaitForChild("PlayerGui") or game:WaitForChild("CoreGui")

	MainFrame.Name = "MainFrame"
	MainFrame.Parent = ArtemisSpecialist
	MainFrame.BackgroundColor3 = theme.main
	MainFrame.Position = UDim2.new(0.345118761, 0, 0.277912617, 0)
	MainFrame.Size = UDim2.new(0, 587, 0, 366)
	MainFrame.BorderSizePixel = 0

	--	

	function ToggleUI()
		toggled = not toggled
		print(toggled)
		if not MainFrame.ClipsDescendants then
			MainFrame.ClipsDescendants = true
		end
		if toggled then
			Tween(MainFrame,UDim2.new(0, 587,0, 0),0.15)
		else
			Tween(MainFrame,UDim2.new(0,587,0,366),0.15)
		end
	end

	MainFrameC.CornerRadius = UDim.new(0, 4)
	MainFrameC.Name = "MainFrameC"
	MainFrameC.Parent = MainFrame

	SideFrame.Name = "SideFrame"
	SideFrame.Parent = MainFrame
	SideFrame.BackgroundColor3 = theme.secondary
	SideFrame.Position = UDim2.new(0.0120000103, 0, 0.117999971, 0)
	SideFrame.Size = UDim2.new(0, 130, 0, 318)

	SideFrameC.CornerRadius = UDim.new(0, 4)
	SideFrameC.Name = "SideFrameC"
	SideFrameC.Parent = SideFrame
	
	Glow.Name = "Glow"
	Glow.Parent = MainFrame
	Glow.AnchorPoint = Vector2.new(0.5, 0.5)
	Glow.BackgroundTransparency = 1.000
	Glow.BorderSizePixel = 0
	Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Glow.Size = UDim2.new(1, 47, 1, 47)
	Glow.ZIndex = 0
	Glow.Image = "rbxassetid://6014261993"
	Glow.ImageTransparency = 0.500
	Glow.ScaleType = Enum.ScaleType.Slice
	Glow.SliceCenter = Rect.new(49, 49, 450, 450)
	
	task.spawn(function()
		while Glow do
			Glow.ImageColor3 = Color3.fromRGB(math.random(1, 225), math.random(1, 225), math.random(1, 225))
			task.wait(1)
		end
	end)

	TabContainer.Name = "TabContainer"
	TabContainer.Parent = SideFrame
	TabContainer.Active = true
	TabContainer.BackgroundColor3 = theme.secondary
	TabContainer.BackgroundTransparency = 1.000
	TabContainer.BorderSizePixel = 0
	TabContainer.Position = UDim2.new(0.0510812625, 0, 0.0220125783, 0)
	TabContainer.Size = UDim2.new(0, 117, 0, 305)
	TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabContainer.ScrollBarThickness = 0

	TabContainerL.Name = "TabContainerL"
	TabContainerL.Parent = TabContainer
	TabContainerL.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabContainerL.SortOrder = Enum.SortOrder.LayoutOrder
	TabContainerL.Padding = UDim.new(0, 5)

	TabContainerP.Name = "TabContainerP"
	TabContainerP.Parent = TabContainer
	TabContainerP.PaddingTop = UDim.new(0, 5)

	TabHolder.Name = "TabHolder"
	TabHolder.Parent = MainFrame
	TabHolder.BorderSizePixel = 0
	TabHolder.BackgroundColor3 = theme.secondary
	TabHolder.Position = UDim2.new(0.244000047, 0, 0.117999971, 0)
	TabHolder.Size = UDim2.new(0, 440, 0, 318)
	TabHolder.ClipsDescendants = true

	TabHolderC.CornerRadius = UDim.new(0, 4)
	TabHolderC.Name = "TabHolderC"
	TabHolderC.Parent = TabHolder

	TopFrame.Name = "TopFrame"
	TopFrame.Parent = MainFrame
	TopFrame.BackgroundColor3 = theme.secondary
	TopFrame.Position = UDim2.new(0.0123288939, 0, 0.0191256832, 0)
	TopFrame.Size = UDim2.new(0, 575, 0, 33)

	SideFrameC_2.CornerRadius = UDim.new(0, 4)
	SideFrameC_2.Name = "SideFrameC"
	SideFrameC_2.Parent = TopFrame

	Title.Name = "Title"
	Title.Parent = TopFrame
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0.0112130605, 0, 0, 0)
	Title.Size = UDim2.new(0, 569, 0, 33)
	Title.Font = Enum.Font.GothamMedium
	Title.Text = title
	Title.TextColor3 = theme.accent
	Title.TextSize = 16.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	drag(MainFrame, TopFrame)

	TabContainerL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabContainer.CanvasSize = UDim2.new(0, 0, 0, TabContainerL.AbsoluteContentSize.Y + 18)
	end)

	local Holder = {}

	function Holder:Tab(name,icon)
		local TabOpen = Instance.new("TextButton")
		local TabOpenC = Instance.new("UICorner")
		local TabIcon = Instance.new("ImageLabel")
		local TabOpenP = Instance.new("UIPadding")
		local Section = Instance.new("ScrollingFrame")
		local SectionP = Instance.new("UIPadding")
		local TabHolderC = Instance.new("UICorner")
		local SectionL = Instance.new("UIListLayout")

		TabOpen.Name = "TabOpen"
		TabOpen.Parent = TabContainer
		TabOpen.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
		TabOpen.BackgroundTransparency = 1.000
		TabOpen.BorderSizePixel = 0
		TabOpen.Position = UDim2.new(0, 0, 0.0216489695, 0)
		TabOpen.Size = UDim2.new(0, 116, 0, 30)
		TabOpen.AutoButtonColor = false
		TabOpen.Font = Enum.Font.GothamMedium
		TabOpen.Text = ("       %s"):format(name)
		TabOpen.TextColor3 = theme.accent
		TabOpen.TextSize = 14.000
		TabOpen.TextXAlignment = Enum.TextXAlignment.Left

		TabOpenC.CornerRadius = UDim.new(0, 4)
		TabOpenC.Name = "TabOpenC"
		TabOpenC.Parent = TabOpen

		TabIcon.Name = "TabIcon"
		TabIcon.Parent = TabOpen
		TabIcon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TabIcon.BackgroundTransparency = 1.000
		TabIcon.Position = UDim2.new(0, 0, 0.166666672, 0)
		TabIcon.Size = UDim2.new(0, 20, 0, 20)
		TabIcon.Image = ("rbxassetid://%s"):format((icon or 4370341699))
		TabIcon.ImageColor3 = theme.accent
		TabIcon.ScaleType = Enum.ScaleType.Fit

		TabOpenP.Name = "TabOpenP"
		TabOpenP.Parent = TabOpen
		TabOpenP.PaddingLeft = UDim.new(0, 5)

		Section.Name = name
		Section.Parent = TabHolder
		Section.Active = true
		Section.BackgroundColor3 = theme.secondary
		Section.BorderSizePixel = 0
		Section.Position = UDim2.new(-0.00145454495, 0, -0.00149685144, 0)
		Section.Size = UDim2.new(0, 440, 0, 318)
		Section.Visible = false
		Section.ScrollBarThickness = 1
		Section.ScrollBarImageColor3 = theme.accent
		Section.CanvasSize = UDim2.new(0,0,0,0)

		TabHolderC.CornerRadius = UDim.new(0, 4)
		TabHolderC.Name = "TabHolderC"
		TabHolderC.Parent = Section

		SectionP.Name = "SectionP"
		SectionP.Parent = Section
		SectionP.PaddingLeft = UDim.new(0, 5)
		SectionP.PaddingTop = UDim.new(0, 5)

		SectionL.Name = "SectionL"
		SectionL.Parent = Section
		SectionL.SortOrder = Enum.SortOrder.LayoutOrder
		SectionL.Padding = UDim.new(0, 5)

		SectionL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Section.CanvasSize = UDim2.new(0, 0, 0, SectionL.AbsoluteContentSize.Y + 18)
		end)

		local IsTabOpen = false
		TabOpen.MouseButton1Click:Connect(function()
			spawn(function()
				Ripple(TabOpen)
			end)
			SwitchTab({Section})
		end)
		if library.currentTab == nil then SwitchTab({Section}) end

		local TabHolder = {}

		function TabHolder:Section(name)
			local SectionSplit = Instance.new("Frame")
			local SectionC = Instance.new("UICorner")
			local SectionName = Instance.new("TextLabel")
			local SectionOpened = Instance.new("ImageLabel")
			local TabL = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")

			SectionSplit.Name = "SectionSplit"
			SectionSplit.Parent = Section
			SectionSplit.BackgroundColor3 = Color3.fromRGB(37, 44, 72)
			SectionSplit.BackgroundTransparency = 1.000
			SectionSplit.BorderSizePixel = 0
			SectionSplit.ClipsDescendants = true
			SectionSplit.Size = UDim2.new(0.981000066, 0, -0.025559105, 44)

			SectionC.CornerRadius = UDim.new(0, 6)
			SectionC.Name = "SectionC"
			SectionC.Parent = SectionSplit

			SectionName.Name = "SectionName"
			SectionName.Parent = SectionSplit
			SectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionName.BackgroundTransparency = 1.000
			SectionName.Position = UDim2.new(0.18319124, 0, -1.18047225, 0)
			SectionName.Size = UDim2.new(0, 401, 0, 36)
			SectionName.Font = Enum.Font.GothamMedium
			SectionName.Text = name
			SectionName.TextColor3 = theme.accent
			SectionName.TextSize = 16.000
			SectionName.TextXAlignment = Enum.TextXAlignment.Left

			SectionOpened.Name = "SectionOpened"
			SectionOpened.Parent = SectionName
			SectionOpened.BackgroundTransparency = 1.000
			SectionOpened.BorderSizePixel = 0
			SectionOpened.Position = UDim2.new(0, -33, 0, 5)
			SectionOpened.Size = UDim2.new(0, 26, 0, 26)
			SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
			SectionOpened.ImageColor3 = theme.accent

			TabL.Name = "TabL"
			TabL.Parent = SectionSplit
			TabL.SortOrder = Enum.SortOrder.LayoutOrder
			TabL.VerticalAlignment = Enum.VerticalAlignment.Center
			TabL.Padding = UDim.new(0, 3)

			UIPadding.Parent = SectionSplit
			UIPadding.PaddingLeft = UDim.new(0, 35)
			UIPadding.PaddingTop = UDim.new(0, 5)

		end

		function TabHolder:Button(name,callback)
			local ButtonFrame = Instance.new("Frame")
			local Button = Instance.new("TextButton")
			local ButtonC = Instance.new("UICorner")

			ButtonFrame.Name = "ButtonFrame"
			ButtonFrame.Parent = Section
			ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonFrame.BackgroundTransparency = 1.000
			ButtonFrame.BorderSizePixel = 0
			ButtonFrame.Size = UDim2.new(0, 428, 0, 38)

			Button.Name = "Button"
			Button.Parent = ButtonFrame
			Button.BackgroundColor3 = theme.main
			Button.BorderSizePixel = 0
			Button.ClipsDescendants = true
			Button.Size = UDim2.new(0, 428, 0, 38)
			Button.AutoButtonColor = false
			Button.Font = Enum.Font.GothamMedium
			Button.Text = "   "..name
			Button.TextColor3 = theme.accent
			Button.TextSize = 16.000
			Button.TextXAlignment = Enum.TextXAlignment.Left

			ButtonC.CornerRadius = UDim.new(0, 6)
			ButtonC.Name = "ButtonC"
			ButtonC.Parent = Button

			Button.MouseButton1Click:Connect(function()
				spawn(function()
					Ripple(Button)
				end)
				spawn(callback)
			end)
		end

		function TabHolder:Label(name)
			local LabelFrame = Instance.new("Frame")
			local Label = Instance.new("TextLabel")
			local LabelC = Instance.new("UICorner")

			LabelFrame.Name = "LabelFrame"
			LabelFrame.Parent = Section
			LabelFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			LabelFrame.BackgroundTransparency = 1.000
			LabelFrame.BorderSizePixel = 0
			LabelFrame.Position = UDim2.new(0, 0, 0.274760395, 0)
			LabelFrame.Size = UDim2.new(0, 428, 0, 25)

			Label.Name = "Label"
			Label.Parent = LabelFrame
			Label.BackgroundColor3 = theme.main
			Label.BorderSizePixel = 0
			Label.ClipsDescendants = true
			Label.Size = UDim2.new(0, 428, 0, 25)
			Label.Font = Enum.Font.GothamMedium
			Label.Text = name
			Label.TextColor3 = theme.accent
			Label.TextSize = 16.000
			Label.TextXAlignment = Enum.TextXAlignment.Center

			LabelC.CornerRadius = UDim.new(0, 6)
			LabelC.Name = "ButtonC"
			LabelC.Parent = Label
			return Label
		end

		function TabHolder:Toggle(name,flag,val,callback)
			local callback = callback or function() end
			local val = val or false
			assert(name,"Name Missing")
			assert(flag,"Flag Missing")
			library.flags[flag] = val

			local ToggleFrame = Instance.new("Frame")
			local ToggleBtn = Instance.new("TextButton")
			local ToggleBtnC = Instance.new("UICorner")
			local ToggleDisable = Instance.new("Frame")
			local ToggleSwitch = Instance.new("Frame")
			local ToggleSwitchC = Instance.new("UICorner")
			local ToggleDisableC = Instance.new("UICorner")

			ToggleFrame.Name = "ToggleFrame"
			ToggleFrame.Parent = Section
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleFrame.BackgroundTransparency = 1.000
			ToggleFrame.BorderSizePixel = 0
			ToggleFrame.Size = UDim2.new(0, 428, 0, 38)

			ToggleBtn.Name = "ToggleBtn"
			ToggleBtn.Parent = ToggleFrame
			ToggleBtn.BackgroundColor3 = theme.main
			ToggleBtn.BorderSizePixel = 0
			ToggleBtn.Size = UDim2.new(0, 428, 0, 38)
			ToggleBtn.AutoButtonColor = false
			ToggleBtn.Font = Enum.Font.GothamMedium
			ToggleBtn.Text = "   "..name
			ToggleBtn.TextColor3 = theme.accent
			ToggleBtn.TextSize = 16.000
			ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left

			ToggleBtnC.CornerRadius = UDim.new(0, 6)
			ToggleBtnC.Name = "ToggleBtnC"
			ToggleBtnC.Parent = ToggleBtn

			ToggleDisable.Name = "ToggleDisable"
			ToggleDisable.Parent = ToggleBtn
			ToggleDisable.BackgroundColor3 = theme.secondary
			ToggleDisable.BorderSizePixel = 0
			ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
			ToggleDisable.Size = UDim2.new(0, 36, 0, 22)

			ToggleSwitch.Name = "ToggleSwitch"
			ToggleSwitch.Parent = ToggleDisable
			ToggleSwitch.BackgroundColor3 = theme.accent2
			ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)

			ToggleSwitchC.CornerRadius = UDim.new(0, 6)
			ToggleSwitchC.Name = "ToggleSwitchC"
			ToggleSwitchC.Parent = ToggleSwitch

			ToggleDisableC.CornerRadius = UDim.new(0, 6)
			ToggleDisableC.Name = "ToggleDisableC"
			ToggleDisableC.Parent = ToggleDisable

			local funcs = {
				SetState = function(self, state)
					if state == nil then state = not library.flags[flag] end
					if library.flags[flag] == state then return end
					game.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0), BackgroundColor3 = (state and theme.accent or theme.accent2)}):Play()
					library.flags[flag] = state
					callback(state)
				end,
				Module = ToggleFrame
			}

			if val == true then
				funcs:SetState(flag,true)
			end

			ToggleBtn.MouseButton1Click:Connect(function()
				funcs:SetState()
			end)
			return funcs
		end

		function TabHolder:KeyBind(name,default,callback)
			callback = callback or function() end
			assert(name,"Name Missing")
			assert(default,"Missing Default Key")

			local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
			local banned = {
				Return = true;
				Space = true;
				Tab = true;
				Backquote = true;
				CapsLock = true;
				Escape = true;
				Unknown = true;
			}
			local shortNames = {
				RightControl = 'Right Ctrl',
				LeftControl = 'Left Ctrl',
				LeftShift = 'Left Shift',
				RightShift = 'Right Shift',
				Semicolon = ";",
				Quote = '"',
				LeftBracket = '[',
				RightBracket = ']',
				Equals = '=',
				Minus = '-',
				RightAlt = 'Right Alt',
				LeftAlt = 'Left Alt'
			}

			local bindKey = default
			local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")

			local KeybindFrame = Instance.new("Frame")
			local KeybindBtn = Instance.new("TextButton")
			local KeybindBtnC = Instance.new("UICorner")
			local KeybindValue = Instance.new("TextButton")
			local KeybindValueC = Instance.new("UICorner")
			local KeybindL = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")

			KeybindFrame.Name = "KeybindFrame"
			KeybindFrame.Parent = Section
			KeybindFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			KeybindFrame.BackgroundTransparency = 1.000
			KeybindFrame.BorderSizePixel = 0
			KeybindFrame.Size = UDim2.new(0, 428, 0, 38)

			KeybindBtn.Name = "KeybindBtn"
			KeybindBtn.Parent = KeybindFrame
			KeybindBtn.BackgroundColor3 = theme.main
			KeybindBtn.BorderSizePixel = 0
			KeybindBtn.Size = UDim2.new(0, 428, 0, 38)
			KeybindBtn.AutoButtonColor = false
			KeybindBtn.Font = Enum.Font.GothamMedium
			KeybindBtn.Text = "   "..name
			KeybindBtn.TextColor3 = theme.accent
			KeybindBtn.TextSize = 16.000
			KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left

			KeybindBtnC.CornerRadius = UDim.new(0, 6)
			KeybindBtnC.Name = "KeybindBtnC"
			KeybindBtnC.Parent = KeybindBtn

			KeybindValue.Name = "KeybindValue"
			KeybindValue.Parent = KeybindBtn
			KeybindValue.BackgroundColor3 = theme.secondary
			KeybindValue.BorderSizePixel = 0
			KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
			KeybindValue.Size = UDim2.new(0, 40, 0, 28)
			KeybindValue.AutoButtonColor = false
			KeybindValue.Font = Enum.Font.Gotham
			KeybindValue.Text = keyTxt
			KeybindValue.TextColor3 = theme.accent
			KeybindValue.TextSize = 14.000

			KeybindValueC.CornerRadius = UDim.new(0, 6)
			KeybindValueC.Name = "KeybindValueC"
			KeybindValueC.Parent = KeybindValue

			KeybindL.Name = "KeybindL"
			KeybindL.Parent = KeybindBtn
			KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
			KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
			KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center

			UIPadding.Parent = KeybindBtn
			UIPadding.PaddingRight = UDim.new(0, 6)

			game.UserInputService.InputBegan:Connect(function(inp, gpe)
				if gpe then return end
				if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
				if inp.KeyCode ~= bindKey then return end
				callback(bindKey.Name)
			end)

			KeybindValue.MouseButton1Click:Connect(function()
				KeybindValue.Text = "..."
				wait()
				local key, uwu = game.UserInputService.InputEnded:Wait()
				local keyName = tostring(key.KeyCode.Name)
				if key.UserInputType ~= Enum.UserInputType.Keyboard then
					KeybindValue.Text = keyTxt
					return
				end
				if banned[keyName] then
					KeybindValue.Text = keyTxt
					return
				end
				wait()
				bindKey = Enum.KeyCode[keyName]
				KeybindValue.Text = shortNames[keyName] or keyName
			end)

			KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
				KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
			end)
			KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
		end

		function TabHolder:TextBox(name,flag,defualt,callback)
			local callback = callback or function() end
			assert(name,"Name Missing")
			assert(flag,"Flag Missing")
			assert(defualt,"Defualt Missing")
			library.flags[flag] = defualt
			local TextboxFrame = Instance.new("Frame")
			local TextboxBack = Instance.new("TextButton")
			local TextboxBackC = Instance.new("UICorner")
			local BoxBG = Instance.new("TextButton")
			local BoxBGC = Instance.new("UICorner")
			local TextBox = Instance.new("TextBox")
			local TextboxBackL = Instance.new("UIListLayout")
			local TextboxBackP = Instance.new("UIPadding")

			TextboxFrame.Name = "TextboxFrame"
			TextboxFrame.Parent = Section
			TextboxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextboxFrame.BackgroundTransparency = 1.000
			TextboxFrame.BorderSizePixel = 0
			TextboxFrame.Size = UDim2.new(0, 428, 0, 38)

			TextboxBack.Name = "TextboxBack"
			TextboxBack.Parent = TextboxFrame
			TextboxBack.BackgroundColor3 = theme.main
			TextboxBack.BorderSizePixel = 0
			TextboxBack.Size = UDim2.new(0, 428, 0, 38)
			TextboxBack.AutoButtonColor = false
			TextboxBack.Font = Enum.Font.GothamMedium
			TextboxBack.Text = "   "..name
			TextboxBack.TextColor3 = theme.accent
			TextboxBack.TextSize = 16.000
			TextboxBack.TextXAlignment = Enum.TextXAlignment.Left

			TextboxBackC.CornerRadius = UDim.new(0, 6)
			TextboxBackC.Name = "TextboxBackC"
			TextboxBackC.Parent = TextboxBack

			BoxBG.Name = "BoxBG"
			BoxBG.Parent = TextboxBack
			BoxBG.BackgroundColor3 = theme.secondary
			BoxBG.BorderSizePixel = 0
			BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
			BoxBG.Size = UDim2.new(0, 57, 0, 28)
			BoxBG.AutoButtonColor = false
			BoxBG.Font = Enum.Font.Gotham
			BoxBG.Text = ""
			BoxBG.TextColor3 = theme.accent
			BoxBG.TextSize = 14.000

			BoxBGC.CornerRadius = UDim.new(0, 6)
			BoxBGC.Name = "BoxBGC"
			BoxBGC.Parent = BoxBG

			TextBox.Parent = BoxBG
			TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.BackgroundTransparency = 1.000
			TextBox.BorderSizePixel = 0
			TextBox.Size = UDim2.new(1, 0, 1, 0)
			TextBox.Font = Enum.Font.Gotham
			TextBox.Text = defualt
			TextBox.TextColor3 = theme.accent
			TextBox.TextSize = 14.000

			TextboxBackL.Name = "TextboxBackL"
			TextboxBackL.Parent = TextboxBack
			TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
			TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
			TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center

			TextboxBackP.Name = "TextboxBackP"
			TextboxBackP.Parent = TextboxBack
			TextboxBackP.PaddingRight = UDim.new(0, 6)

			TextBox.FocusLost:Connect(function()
				if TextBox.Text == "" then
					TextBox.Text = defualt
				end
				library.flags[flag] = TextBox.Text
				callback(TextBox.Text)
			end)

			TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
				BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
			end)
			BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
		end

		function TabHolder:Dropdown(name,flag,options,resettext,callback)
			local callback = callback or function() end
			local options = options or {}
			assert(name,"Name Missing")
			assert(flag,"Flag Missing")
			library.flags[flag] = nil

			local DropdownFrame = Instance.new("Frame")
			local DropdownTop = Instance.new("TextButton")
			local DropdownTopC = Instance.new("UICorner")
			local DropdownOpen = Instance.new("TextButton")
			local DropdownText = Instance.new("TextBox")
			local DropdownFrameL = Instance.new("UIListLayout")

			DropdownFrame.Name = "DropdownFrame"
			DropdownFrame.Parent = Section
			DropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownFrame.BackgroundTransparency = 1.000
			DropdownFrame.BorderSizePixel = 0
			DropdownFrame.ClipsDescendants = true
			DropdownFrame.Size = UDim2.new(0, 428, 0, 38)

			DropdownTop.Name = "DropdownTop"
			DropdownTop.Parent = DropdownFrame
			DropdownTop.BackgroundColor3 = theme.main
			DropdownTop.BorderSizePixel = 0
			DropdownTop.Size = UDim2.new(0, 428, 0, 38)
			DropdownTop.AutoButtonColor = false
			DropdownTop.Font = Enum.Font.GothamMedium
			DropdownTop.Text = ""
			DropdownTop.TextColor3 = theme.accent
			DropdownTop.TextSize = 16.000
			DropdownTop.TextXAlignment = Enum.TextXAlignment.Left

			DropdownTopC.CornerRadius = UDim.new(0, 6)
			DropdownTopC.Name = "DropdownTopC"
			DropdownTopC.Parent = DropdownTop

			DropdownOpen.Name = "DropdownOpen"
			DropdownOpen.Parent = DropdownTop
			DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
			DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownOpen.BackgroundTransparency = 1.000
			DropdownOpen.BorderSizePixel = 0
			DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
			DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
			DropdownOpen.Font = Enum.Font.Gotham
			DropdownOpen.Text = "+"
			DropdownOpen.TextColor3 = theme.accent
			DropdownOpen.TextSize = 24.000
			DropdownOpen.TextWrapped = true

			DropdownText.Name = "DropdownText"
			DropdownText.Parent = DropdownTop
			DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownText.BackgroundTransparency = 1.000
			DropdownText.BorderSizePixel = 0
			DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
			DropdownText.Size = UDim2.new(0, 184, 0, 38)
			DropdownText.Font = Enum.Font.GothamMedium
			DropdownText.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
			DropdownText.PlaceholderText = "Wipe Options"
			DropdownText.Text = name
			DropdownText.TextColor3 = theme.accent
			DropdownText.TextSize = 16.000
			DropdownText.TextXAlignment = Enum.TextXAlignment.Left

			DropdownFrameL.Name = "DropdownFrameL"
			DropdownFrameL.Parent = DropdownFrame
			DropdownFrameL.SortOrder = Enum.SortOrder.LayoutOrder
			DropdownFrameL.Padding = UDim.new(0, 4)

			local setAllVisible = function()
				local options = DropdownFrame:GetChildren() 
				for i=1, #options do
					local option = options[i]
					if option:IsA("TextButton") and option.Name:match("Option_") then
						option.Visible = true
					end
				end
			end

			local searchDropdown = function(text)
				local options = DropdownFrame:GetChildren()
				for i=1, #options do
					local option = options[i]
					if text == "" then
						setAllVisible()
					else
						if option:IsA("TextButton") and option.Name:match("Option_") then
							if option.Text:lower():match(text:lower()) then
								option.Visible = true
							else
								option.Visible = false
							end
						end
					end
				end
			end

			local open = false
			local ToggleDropVis = function()
				open = not open
				if open then setAllVisible() end
				DropdownOpen.Text = (open and "-" or "+")
				DropdownFrame.Size = UDim2.new(0, 428, 0, (open and DropdownFrameL.AbsoluteContentSize.Y + 4 or 38))
			end

			DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
			DropdownText.Focused:Connect(function()
				if open then return end
				ToggleDropVis()
			end)

			DropdownText:GetPropertyChangedSignal("Text"):Connect(function()
				if not open then return end
				searchDropdown(DropdownText.Text)
			end)

			DropdownFrameL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if not open then return end
				DropdownFrame.Size = UDim2.new(0, 428, 0, (DropdownFrameL.AbsoluteContentSize.Y + 4))
			end)

			local funcs = {}

			funcs.AddOption = function(self,option)
				local Option = Instance.new("TextButton")
				local OptionC = Instance.new("UICorner")

				Option.Name = "Option_"..option
				Option.Parent = DropdownFrame
				Option.BackgroundColor3 = theme.main
				Option.BorderSizePixel = 0
				Option.Position = UDim2.new(0, 0, 0.328125, 0)
				Option.Size = UDim2.new(0, 428, 0, 26)
				Option.AutoButtonColor = false
				Option.Font = Enum.Font.Gotham
				Option.Text = option
				Option.TextColor3 = theme.accent
				Option.TextSize = 14.000

				OptionC.CornerRadius = UDim.new(0, 6)
				OptionC.Name = "OptionC"
				OptionC.Parent = Option

				Option.MouseButton1Click:Connect(function()
					ToggleDropVis()
					callback(Option.Text)
					if not resettext then
						DropdownText.Text = Option.Text
					end
					library.flags[flag] = Option.Text
				end)
			end

			funcs.SetOptions = function(self, options)
				for _, v in next, DropdownFrame:GetChildren() do
					if v.Name:match("Option_") then
						v:Destroy()
					end
				end
				for _,v in next, options do
					funcs:AddOption(v)
				end
			end

			funcs:SetOptions(options)

			return funcs
		end

		function TabHolder:Slider(name,flag,defualt,min,max,precise,callback)
			local callback = callback or function() end
			local min = min or 1
			local max = max or 100
			local defualt = defualt or min
			local precise = precise or false
			library.flags[flag] = defualt
			assert(name,"Name Missing")
			assert(flag,"Flag Missing")

			local SliderFrame = Instance.new("Frame")
			local SliderBack = Instance.new("TextButton")
			local SliderBackC = Instance.new("UICorner")
			local SliderBar = Instance.new("Frame")
			local SliderBarC = Instance.new("UICorner")
			local SliderPart = Instance.new("Frame")
			local SliderPartC = Instance.new("UICorner")
			local SliderValBG = Instance.new("TextButton")
			local SliderValBGC = Instance.new("UICorner")
			local SliderValue = Instance.new("TextBox")
			local MinSlider = Instance.new("TextButton")
			local AddSlider = Instance.new("TextButton")

			SliderFrame.Name = "SliderFrame"
			SliderFrame.Parent = Section
			SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderFrame.BackgroundTransparency = 1.000
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Size = UDim2.new(0, 428, 0, 38)

			SliderBack.Name = "SliderBack"
			SliderBack.Parent = SliderFrame
			SliderBack.BackgroundColor3 = theme.main
			SliderBack.BorderSizePixel = 0
			SliderBack.Size = UDim2.new(0, 428, 0, 38)
			SliderBack.AutoButtonColor = false
			SliderBack.Font = Enum.Font.GothamMedium
			SliderBack.Text = "   "..name
			SliderBack.TextColor3 = theme.accent
			SliderBack.TextSize = 16.000
			SliderBack.TextXAlignment = Enum.TextXAlignment.Left

			SliderBackC.CornerRadius = UDim.new(0, 6)
			SliderBackC.Name = "SliderBackC"
			SliderBackC.Parent = SliderBack

			SliderBar.Name = "SliderBar"
			SliderBar.Parent = SliderBack
			SliderBar.AnchorPoint = Vector2.new(0, 0.5)
			SliderBar.BackgroundColor3 = theme.secondary
			SliderBar.BorderSizePixel = 0
			SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
			SliderBar.Size = UDim2.new(0, 140, 0, 12)

			SliderBarC.CornerRadius = UDim.new(0, 4)
			SliderBarC.Name = "SliderBarC"
			SliderBarC.Parent = SliderBar

			SliderPart.Name = "SliderPart"
			SliderPart.Parent = SliderBar
			SliderPart.BackgroundColor3 = theme.accent
			SliderPart.BorderSizePixel = 0
			SliderPart.Size = UDim2.new(0, 0, 1, 0)

			SliderPartC.CornerRadius = UDim.new(0, 4)
			SliderPartC.Name = "SliderPartC"
			SliderPartC.Parent = SliderPart

			SliderValBG.Name = "SliderValBG"
			SliderValBG.Parent = SliderBack
			SliderValBG.BackgroundColor3 = theme.secondary
			SliderValBG.BorderSizePixel = 0
			SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
			SliderValBG.Size = UDim2.new(0, 44, 0, 28)
			SliderValBG.AutoButtonColor = false
			SliderValBG.Font = Enum.Font.Gotham
			SliderValBG.Text = ""
			SliderValBG.TextColor3 = theme.accent
			SliderValBG.TextSize = 14.000

			SliderValBGC.CornerRadius = UDim.new(0, 6)
			SliderValBGC.Name = "SliderValBGC"
			SliderValBGC.Parent = SliderValBG

			SliderValue.Name = "SliderValue"
			SliderValue.Parent = SliderValBG
			SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderValue.BackgroundTransparency = 1.000
			SliderValue.BorderSizePixel = 0
			SliderValue.Size = UDim2.new(1, 0, 1, 0)
			SliderValue.Font = Enum.Font.Gotham
			SliderValue.Text = "16"
			SliderValue.TextColor3 = theme.accent
			SliderValue.TextSize = 14.000

			MinSlider.Name = "MinSlider"
			MinSlider.Parent = SliderFrame
			MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			MinSlider.BackgroundTransparency = 1.000
			MinSlider.BorderSizePixel = 0
			MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
			MinSlider.Size = UDim2.new(0, 20, 0, 20)
			MinSlider.Font = Enum.Font.Gotham
			MinSlider.Text = "-"
			MinSlider.TextColor3 = theme.accent
			MinSlider.TextSize = 24.000
			MinSlider.TextWrapped = true

			AddSlider.Name = "AddSlider"
			AddSlider.Parent = SliderFrame
			AddSlider.AnchorPoint = Vector2.new(0, 0.5)
			AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			AddSlider.BackgroundTransparency = 1.000
			AddSlider.BorderSizePixel = 0
			AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
			AddSlider.Size = UDim2.new(0, 20, 0, 20)
			AddSlider.Font = Enum.Font.Gotham
			AddSlider.Text = "+"
			AddSlider.TextColor3 = theme.accent
			AddSlider.TextSize = 24.000
			AddSlider.TextWrapped = true

			local funcs = {
				SetValue = function(self, value)
					local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
					if value then
						percent = (value - min) / (max - min)
					end
					percent = math.clamp(percent, 0, 1)
					if precise then
						value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
					else
						value = value or math.floor(min + (max - min) * percent)
					end
					library.flags[flag] = tonumber(value)
					SliderValue.Text = tostring(value)
					SliderPart.Size = UDim2.new(percent, 0, 1, 0)
					callback(tonumber(value))
				end
			}

			MinSlider.MouseButton1Click:Connect(function()
				local currentValue = library.flags[flag]
				currentValue = math.clamp(currentValue - 1, min, max)
				funcs:SetValue(currentValue)
			end)

			AddSlider.MouseButton1Click:Connect(function()
				local currentValue = library.flags[flag]
				currentValue = math.clamp(currentValue + 1, min, max)
				funcs:SetValue(currentValue)
			end)

			funcs:SetValue(defualt)

			local dragging, boxFocused, allowed = false, false, {
				[""] = true,
				["-"] = true,
				["."] = true,
			}

			SliderBar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					funcs:SetValue()
					dragging = true
				end
			end)

			game.UserInputService.InputEnded:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			game.UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					funcs:SetValue()
				end
			end)

			SliderValue.Focused:Connect(function()
				boxFocused = true
			end)

			SliderValue.FocusLost:Connect(function()
				boxFocused = false
				if SliderValue.Text == "" then
					funcs:SetValue(defualt)
				end
			end)

			SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
				if not boxFocused then
					return
				end

				if SliderValue.Text == "" then
					return
				end

				local text = SliderValue.Text
					
				if not tonumber(SliderValue.Text) then 
					SliderValue.Text = ""
				end

				if tonumber(SliderValue.Text) > max then
					funcs:SetValue(max)
				end
				
				funcs:SetValue(tonumber(text))
			end)
			return funcs
		end
		return TabHolder
	end
	return Holder
end
