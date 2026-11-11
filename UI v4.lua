local UI_TITLE = "UI v4 Developer discord : @nelessk"

local function ShowVergilError(message)
    warn("[Vergil White] " .. tostring(message))
    pcall(function()
        local players = game:GetService("Players")
        local user = players.LocalPlayer
        local playerGui = user and user:FindFirstChildOfClass("PlayerGui")
        local gui = Instance.new("ScreenGui")
        gui.Name = "VergilWhite_Error"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.DisplayOrder = 10000
        gui.Parent = playerGui or game:GetService("CoreGui")
        local f = Instance.new("Frame")
        f.Size = UDim2.fromOffset(530, 190)
        f.Position = UDim2.new(.5, -265, .5, -95)
        f.BackgroundColor3 = Color3.fromRGB(18,18,18)
        f.BorderSizePixel = 1
        f.BorderColor3 = Color3.fromRGB(255,255,255)
        f.Parent = gui
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1,-24,0,32)
        title.Position = UDim2.fromOffset(12,6)
        title.Font = Enum.Font.Code
        title.TextSize = 19
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.TextColor3 = Color3.new(1,1,1)
        title.BackgroundTransparency = 1
        title.Text = "VERGIL WHITE - ERROR"
        title.Parent = f
        local details = Instance.new("TextLabel")
        details.Size = UDim2.new(1,-24,1,-50)
        details.Position = UDim2.fromOffset(12,40)
        details.Font = Enum.Font.Code
        details.TextSize = 14
        details.TextXAlignment = Enum.TextXAlignment.Left
        details.TextYAlignment = Enum.TextYAlignment.Top
        details.TextColor3 = Color3.fromRGB(215,215,215)
        details.BackgroundTransparency = 1
        details.TextWrapped = true
        details.Text = string.sub(tostring(message),1,1100)
        details.Parent = f
    end)
end

local loaded, problem = xpcall(function()


local Env = (type(getgenv) == "function" and getgenv()) or _G
if Env.VergilLibrary and type(Env.VergilLibrary) == "table" and Env.VergilLibrary.Exit then
    pcall(function() Env.VergilLibrary:Exit() end)
end

local cloneref = cloneref or function(Object) return Object end


local Players = cloneref(game:GetService("Players"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local RunService = cloneref(game:GetService("RunService"))
local HttpService = cloneref(game:GetService("HttpService"))
local TweenService = cloneref(game:GetService("TweenService"))
local TextService = cloneref(game:GetService("TextService"))
local MarketplaceService = cloneref(game:GetService("MarketplaceService"))
local Lighting = cloneref(game:GetService("Lighting"))
local CoreGui = cloneref(game:GetService("CoreGui"))


local LocalPlayer = Players.LocalPlayer


local function GetHui()

    local gui = LocalPlayer and (LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 5))
    if gui then return gui end
    if type(gethui) == "function" then
        local ok, parent = pcall(gethui)
        if ok and typeof(parent) == "Instance" then return parent end
    end
    return CoreGui
end

local Library = {
    Flags = { },
    SetFlags = { },
    MenuKeybind = tostring(Enum.KeyCode.RightShift),

    Directory = "UI-v4",
    Folders = {
        Assets = "/Assets",
        Configs = "/Configs"
    },

    Name = "UI v4",
    Version = "4.0.0-library",
    FontSize = 13,
    FontUrl = "https://github.com/bluescan/proggyfonts/raw/master/ProggyOriginal/ProggyClean.ttf",

    Animation = {
        Time = 0.30,
        Style = "Quint",
        Direction = "Out",

        FadeTime = 0.20,
        FadeStyle = "Sine",
    },

    BlurEnabled = false,
    BlurSize = 0,
    SnowEnabled = false,
    SnowAmount = 0,


    Theme = {
        ["Background"]     = Color3.fromRGB(17, 17, 18),
        ["Window"]         = Color3.fromRGB(14, 14, 15),
        ["Hover"]          = Color3.fromRGB(34, 34, 35),
        ["Border"]         = Color3.fromRGB(64, 64, 66),
        ["Outline"]        = Color3.fromRGB(56, 56, 58),
        ["Button Outline"] = Color3.fromRGB(85, 85, 88),
        ["Text"]           = Color3.fromRGB(250, 250, 250),
        ["Dim Text"]       = Color3.fromRGB(197, 197, 197),
        ["Inactive Text"]  = Color3.fromRGB(132, 132, 132),
        ["Option Text"]    = Color3.fromRGB(156, 156, 156),
        ["Accent"]         = Color3.fromRGB(255, 255, 255),
        ["Element Accent"] = Color3.fromRGB(236, 236, 236),
    },

    Connections = { },
    Threads = { },
    Themed = { },
    OpenFrames = { },
    Floating = { },
    Landing = { },
    ShadowWanted = { },
    KeyList = nil,
    MenuOpen = true,
    Order = 0,
    Font = nil,
    Holder = nil,
    PopupHolder = nil,
    DragHolder = nil,
}
Library.__index = Library

local Flags = Library.Flags
local SetFlags = Library.SetFlags
local Theme = Library.Theme
local ConfigsFolder = Library.Directory .. Library.Folders.Configs


local StrokeInner = (Enum.BorderStrokePosition and Enum.BorderStrokePosition.Inner) or nil

local function New(Class, Props)

    local ok, Object = pcall(Instance.new, Class)
    local ShadowFallback = not ok and Class == "UIShadow"
    if ShadowFallback then
        Object = Instance.new("Frame")
        Object.BackgroundTransparency = 1
        Object.Size = UDim2.fromOffset(0, 0)
    elseif not ok then
        error("GUI class " .. tostring(Class) .. ": " .. tostring(Object), 2)
    end
    Object.Name = "Vergil_" .. tostring(Class)

    if Object:IsA("GuiObject") then
        Object.BorderSizePixel = 0

        if Object:IsA("TextLabel") or Object:IsA("TextButton") or Object:IsA("TextBox") then
            local fontOk = pcall(function() Object.FontFace = Library.Font end)
            if not fontOk then Object.Font = Enum.Font.Code end
            Object.TextSize = Library.FontSize
            Object.TextColor3 = Theme.Text
            Object.TextStrokeTransparency = 1
            Object.BackgroundTransparency = 1
            Object.Text = ""
        end

        if Object:IsA("GuiButton") then
            Object.AutoButtonColor = false
        end
    end

    for Property, Value in Props do
        if Property ~= "Parent" then
            local assigned, why = pcall(function() Object[Property] = Value end)
            if not assigned then

                if not (Class == "UIStroke" or Class == "UIListLayout" or ShadowFallback) then
                    warn("[Vergil/compat] " .. Class .. "." .. tostring(Property) .. ": " .. tostring(why))
                end
            end
        end
    end

    if Props.Parent then
        local attached = pcall(function() Object.Parent = Props.Parent end)
        if not attached and Class == "ScreenGui" then
            local PlayerGui = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")
            if PlayerGui then Object.Parent = PlayerGui else error("Cannot attach ScreenGui to any parent", 2) end
        elseif not attached then
            error("Cannot parent " .. tostring(Class), 2)
        end
    end
    return Object
end

local function Wrap(Object)
    return { Instance = Object }
end


local function Connect(Signal, Callback)
    local Connection = Signal:Connect(Callback)
    table.insert(Library.Connections, Connection)
    return Connection
end

local function Spawn(Function)
    local Thread = task.spawn(Function)
    table.insert(Library.Threads, Thread)
    return Thread
end

local function SafeCall(Function, ...)
    if type(Function) ~= "function" then
        return false
    end

    local Ok, Result = pcall(Function, ...)
    if not Ok then
        warn("[Vergil] callback error: " .. tostring(Result))
    end

    return Ok, Result
end

local function Tween(Object, Properties, Time)
    local Info = TweenInfo.new(
        Time or Library.Animation.Time,
        Enum.EasingStyle[Library.Animation.Style] or Enum.EasingStyle.Quart,
        Enum.EasingDirection[Library.Animation.Direction] or Enum.EasingDirection.Out
    )

    local NewTween = TweenService:Create(Object, Info, Properties)
    NewTween:Play()
    return NewTween
end


local ActiveMotion = setmetatable({}, { __mode = "k" })
local function Smooth(Object, Channel, Properties, Duration, Ease)
    if not Object then return nil end
    local Channels = ActiveMotion[Object]
    if not Channels then
        Channels = {}
        ActiveMotion[Object] = Channels
    end
    local Previous = Channels[Channel]
    if Previous then Previous:Cancel() end

    local Info = TweenInfo.new(
        math.clamp((Duration or 0.30) * ((Library.Animation.Time or 0.30) / 0.30), 0.05, 1.2),
        Ease or Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )
    local Animation = TweenService:Create(Object, Info, Properties)
    Channels[Channel] = Animation
    Animation.Completed:Connect(function()
        if Channels[Channel] == Animation then Channels[Channel] = nil end
    end)
    Animation:Play()
    return Animation
end

local function Corner(Object, Pixels)

    pcall(function()
        local Item = Instance.new("UICorner")
        Item.CornerRadius = UDim.new(0, Pixels or 4)
        Item.Parent = Object
    end)
end

local function Glide(Item, Key, Properties, Instant)
    local Running = Item.Tweens[Key]

    if Running then
        Running:Cancel()
        Item.Tweens[Key] = nil
    end

    if Instant then
        for Property, Value in Properties do
            Item.Frame[Property] = Value
        end

        return nil
    end

    local NewTween = Tween(Item.Frame, Properties)
    Item.Tweens[Key] = NewTween
    return NewTween
end

local function Themed(Function)
    table.insert(Library.Themed, Function)
    Function()
    return Function
end

local function FadeProperties(Object)
    if Object:IsA("UIStroke") then
        return { "Transparency" }
    end

    if not Object:IsA("GuiObject") then
        return nil
    end

    local Properties = { "BackgroundTransparency" }

    if Object:IsA("TextLabel") or Object:IsA("TextButton") or Object:IsA("TextBox") then
        table.insert(Properties, "TextTransparency")
        table.insert(Properties, "TextStrokeTransparency")
    elseif Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
        table.insert(Properties, "ImageTransparency")
    end

    if Object:IsA("ScrollingFrame") then
        table.insert(Properties, "ScrollBarImageTransparency")
    end

    return Properties
end

local function FadeInfo(Kind)
    local Animation = Library.Animation

    if Kind == "Window" then
        return TweenInfo.new(
            Animation.FadeTime,
            Enum.EasingStyle[Animation.FadeStyle] or Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )
    end

    return TweenInfo.new(
        Animation.Time,
        Enum.EasingStyle[Animation.Style] or Enum.EasingStyle.Quart,
        Enum.EasingDirection[Animation.Direction] or Enum.EasingDirection.Out
    )
end

local function Fader(Root, UseScale, Kind)
    local Fade = {
        Open = Root.Visible,
        Snapshot = nil,
        Tween = nil,
        Shadows = { },
    }

    local Driver = Instance.new("NumberValue")
    Driver.Value = Fade.Open and 1 or 0

    local Scale = UseScale and New("UIScale", { Parent = Root }) or nil

    local function DetachShadows()
        for _, Object in Root:GetDescendants() do
            if Object:IsA("UIShadow") then
                Fade.Shadows[Object] = Object.Parent
                Object.Parent = nil
            end
        end
    end

    local function RestoreShadows()
        for Shadow, Parent in Fade.Shadows do
            if Library.ShadowWanted[Shadow] ~= false then
                Shadow.Parent = Parent
            end
        end
        table.clear(Fade.Shadows)
    end

    local function Capture()
        local Snapshot = { }
        local Objects = Root:GetDescendants()
        table.insert(Objects, Root)

        for _, Object in Objects do
            local Properties = FadeProperties(Object)

            if Properties then
                local Values = { }
                for _, Property in Properties do
                    Values[Property] = Object[Property]
                end
                table.insert(Snapshot, { Object, Values })
            end
        end

        return Snapshot
    end

    local function Apply(Alpha)
        for _, Entry in Fade.Snapshot do
            local Object = Entry[1]
            for Property, Value in Entry[2] do
                Object[Property] = Value + (1 - Value) * (1 - Alpha)
            end
        end

        if Scale then
            Scale.Scale = 0.97 + 0.03 * Alpha
        end
    end

    Connect(Driver.Changed, function(Alpha)
        if Fade.Snapshot then
            Apply(Alpha)
        end
    end)

    local function Settle()
        Fade.Tween = nil

        if Fade.Open then
            if Fade.Snapshot then
                Apply(1)
            end
            Fade.Snapshot = nil
            RestoreShadows()
        else
            Root.Visible = false
        end
    end

    function Fade:Set(Bool)
        if Bool == Fade.Open then
            return
        end

        Fade.Open = Bool

        if Fade.Tween then
            Fade.Tween:Cancel()
        end

        DetachShadows()

        if not Fade.Snapshot then
            Fade.Snapshot = Capture()
            Driver.Value = Bool and 0 or 1
            Apply(Driver.Value)
        end

        if Bool then
            Root.Visible = true
        end

        local NewTween = TweenService:Create(Driver, FadeInfo(Kind), { Value = Bool and 1 or 0 })
        NewTween:Play()
        Fade.Tween = NewTween

        NewTween.Completed:Connect(function(State)
            if State == Enum.PlaybackState.Completed and Fade.Tween == NewTween then
                Settle()
            end
        end)
    end

    function Fade:Finish()
        if not Fade.Tween then
            return
        end

        Fade.Tween:Cancel()
        Driver.Value = Fade.Open and 1 or 0
        Settle()
    end

    return Fade
end

local function NextOrder()
    Library.Order += 1
    return Library.Order
end

local function IsClick(Input)
    return Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch
end

local function IsMove(Input)
    return Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch
end


local function FixedScrollbar(Scroll, Host, RightOffset, TopInset, BottomInset)
    local Fixed = Color3.fromRGB(50, 50, 50)
    Scroll.ScrollBarThickness = 0

    local Track = New("TextButton", {
        Parent = Host,
        Position = UDim2.new(1, -(RightOffset or 8), 0, TopInset or 4),
        Size = UDim2.new(0, 5, 1, -((TopInset or 4) + (BottomInset or 4))),
        BackgroundTransparency = 1,
        Text = "",
        Visible = false,
        ZIndex = 10,
    })
    Track.AutoButtonColor = false
    local Thumb = New("TextButton", {
        Parent = Track,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.fromOffset(5, 18),
        BackgroundTransparency = 0,
        BackgroundColor3 = Fixed,
        Text = "",
        ZIndex = 11,
    })
    Thumb.AutoButtonColor = false

    local TotalRange = 0
    local UsableTrack = 0
    local ThumbHeight = 18
    local Dragging = false
    local DragStartY, DragStartScroll = 0, 0

    local function Refresh()
        if not Scroll.Parent or not Track.Parent then return end
        local WindowHeight = Scroll.AbsoluteWindowSize.Y
        if WindowHeight <= 0 then WindowHeight = Scroll.AbsoluteSize.Y end
        local ContentHeight = math.max(Scroll.AbsoluteCanvasSize.Y, Scroll.CanvasSize.Y.Offset)
        local Height = Track.AbsoluteSize.Y
        TotalRange = math.max(0, ContentHeight - WindowHeight)
        if Scroll.ScrollingEnabled == false or TotalRange < 2 or Height < 24 then
            Track.Visible = false
            return
        end
        Track.Visible = true
        ThumbHeight = math.clamp(math.floor(WindowHeight / ContentHeight * Height + 0.5), 18, Height)
        UsableTrack = math.max(Height - ThumbHeight, 0)
        local At = math.clamp(Scroll.CanvasPosition.Y / TotalRange, 0, 1)
        Thumb.Size = UDim2.fromOffset(5, ThumbHeight)
        Thumb.Position = UDim2.fromOffset(0, math.floor(At * UsableTrack + 0.5))

        Thumb.BackgroundColor3 = Fixed
    end

    local function SetFromTrackY(Y)
        if TotalRange <= 0 or UsableTrack <= 0 then return end
        local RelativeY = Y - Track.AbsolutePosition.Y - ThumbHeight / 2
        local Fraction = math.clamp(RelativeY / UsableTrack, 0, 1)
        Scroll.CanvasPosition = Vector2.new(Scroll.CanvasPosition.X, Fraction * TotalRange)
    end

    Connect(Track.InputBegan, function(Input)
        if IsClick(Input) then

            local Y = Input.Position.Y
            local ThumbTop = Thumb.AbsolutePosition.Y
            if Y < ThumbTop or Y > ThumbTop + Thumb.AbsoluteSize.Y then
                SetFromTrackY(Y)
            end
            Dragging = true
            DragStartY, DragStartScroll = Y, Scroll.CanvasPosition.Y
        end
    end)
    Connect(Thumb.InputBegan, function(Input)
        if IsClick(Input) then
            Dragging = true
            DragStartY, DragStartScroll = Input.Position.Y, Scroll.CanvasPosition.Y
        end
    end)
    Connect(UserInputService.InputChanged, function(Input)
        if Dragging and IsMove(Input) and TotalRange > 0 and UsableTrack > 0 then
            local Delta = Input.Position.Y - DragStartY
            local NextY = math.clamp(DragStartScroll + Delta / UsableTrack * TotalRange, 0, TotalRange)
            Scroll.CanvasPosition = Vector2.new(Scroll.CanvasPosition.X, NextY)
        end
    end)
    Connect(UserInputService.InputEnded, function(Input)
        if IsClick(Input) then Dragging = false end
    end)
    for _, Property in {"CanvasPosition", "CanvasSize", "AbsoluteCanvasSize", "AbsoluteWindowSize", "ScrollingEnabled", "AbsoluteSize"} do
        Connect(Scroll:GetPropertyChangedSignal(Property), Refresh)
    end
    Connect(Track:GetPropertyChangedSignal("AbsoluteSize"), Refresh)
    task.defer(Refresh)
    return Track, Thumb
end

local function MouseAbs()
    return UserInputService:GetMouseLocation() + Library.Holder.AbsolutePosition
end

local function IsMouseOver(Object)
    if not Object or not Object.Parent or not Object.Visible then
        return false
    end

    local Mouse = MouseAbs()
    local Position, Size = Object.AbsolutePosition, Object.AbsoluteSize

    return Mouse.X >= Position.X and Mouse.X <= Position.X + Size.X
        and Mouse.Y >= Position.Y and Mouse.Y <= Position.Y + Size.Y
end

local function PlaceBelow(Popup, Anchor, OffsetY, AlignRight)
    local Position = Anchor.AbsolutePosition - Library.PopupHolder.AbsolutePosition
    local X = Position.X

    if AlignRight then
        X = Position.X + Anchor.AbsoluteSize.X - Popup.AbsoluteSize.X
    end

    Popup.Position = UDim2.fromOffset(X, Position.Y + Anchor.AbsoluteSize.Y + (OffsetY or 4))
end

local function Round(Number, Step)
    Step = tonumber(Step) or 1
    if Step <= 0 then
        Step = 1
    end

    local Rounded = math.floor(Number / Step + 0.5) * Step
    local Text = tostring(Step)
    local Dot = Text:find(".", 1, true)
    local Digits = Dot and (#Text - Dot) or 0

    return tonumber(string.format("%." .. Digits .. "f", Rounded))
end

local function ToRichColor(Color)
    return string.format("rgb(%d, %d, %d)", math.floor(Color.R * 255), math.floor(Color.G * 255), math.floor(Color.B * 255))
end

local function AccentSequence(Base)
    local Accent = Theme.Accent
    return ColorSequence.new{
        ColorSequenceKeypoint.new(0, Base),
        ColorSequenceKeypoint.new(0.25, Accent),
        ColorSequenceKeypoint.new(0.5, Base),
        ColorSequenceKeypoint.new(0.75, Accent),
        ColorSequenceKeypoint.new(1, Base),
    }
end

local function Outline(Parent, ColorKey, Thick)
    local Inner = New("UIStroke", {
        Parent = Parent,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        LineJoinMode = Enum.LineJoinMode.Miter,
        BorderStrokePosition = StrokeInner,
        ZIndex = 2,
    })
    Themed(function() Inner.Color = Theme[ColorKey or "Outline"] end)

    New("UIStroke", {
        Parent = Parent,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        LineJoinMode = Enum.LineJoinMode.Miter,
        Color = Color3.new(0, 0, 0),
        Thickness = Thick and 2 or 1,
        BorderOffset = UDim.new(0, 1),
        BorderStrokePosition = StrokeInner,
    })

    return Inner
end

local function Shade(Parent, Rotation, From, To)
    return New("UIGradient", {
        Parent = Parent,
        Rotation = Rotation or 90,
        Color = ColorSequence.new(From or Color3.new(1, 1, 1), To or Color3.fromRGB(201, 201, 201)),
    })
end

local function Highlight(Parent, BaseKey, Position, Size)
    local Line = New("Frame", {
        Parent = Parent,
        BackgroundColor3 = Color3.new(1, 1, 1),
        Position = Position or UDim2.new(0, 0, 0, 0),
        Size = Size or UDim2.new(1, 0, 0, 1),
        ZIndex = 3,
    })

    local Gradient = New("UIGradient", { Parent = Line })
    Themed(function()
        Gradient.Color = AccentSequence((Theme[BaseKey] or Theme.Background):Lerp(Color3.new(0, 0, 0), 0.2))
    end)

    return Line
end

local function TitleGradient(Label, Rotation)
    local Gradient = New("UIGradient", { Parent = Label, Rotation = Rotation or 0 })
    Themed(function() Gradient.Color = AccentSequence(Color3.new(1, 1, 1)) end)
    return Gradient
end

local function MainGradient(Label)
    local Gradient = New("UIGradient", { Parent = Label })
    Themed(function()
        Gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(250, 249, 255)),
            ColorSequenceKeypoint.new(0.128, Color3.fromRGB(135, 140, 160)),
            ColorSequenceKeypoint.new(0.233, Color3.fromRGB(102, 109, 132)),
            ColorSequenceKeypoint.new(0.597, Theme.Accent),
            ColorSequenceKeypoint.new(1, Theme.Accent),
        }
    end)
    return Gradient
end

local function Draggable(Handle, Target)
    local Dragging, DragStart, StartPosition = false, nil, nil

    Connect(Handle.InputBegan, function(Input)
        if IsClick(Input) then
            Dragging = true
            DragStart = Input.Position
            StartPosition = Target.Position
        end
    end)

    Connect(UserInputService.InputEnded, function(Input)
        if IsClick(Input) then
            Dragging = false
        end
    end)

    Connect(UserInputService.InputChanged, function(Input)
        if Dragging and IsMove(Input) then
            local Delta = Input.Position - DragStart
            Target.Position = UDim2.new(
                StartPosition.X.Scale, StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y
            )
        end
    end)
end

local KeyNames = {
    LeftShift = "LShift", RightShift = "RShift",
    LeftControl = "LCtrl", RightControl = "RCtrl",
    LeftAlt = "LAlt", RightAlt = "RAlt",
    MouseButton1 = "MB1", MouseButton2 = "MB2", MouseButton3 = "MB3",
    Return = "Enter", CapsLock = "Caps",
    Backspace = "None", Escape = "None", Unknown = "None", None = "None",
}

local function KeyName(Key)
    local Name = tostring(Key):match("([^%.]+)$") or "None"
    return KeyNames[Name] or Name
end


Library.SafeCall = function(Self, Function, ...)
    return SafeCall(Function, ...)
end

Library.Connect = function(Self, Signal, Callback)
    return Connect(Signal, Callback)
end

Library.Thread = function(Self, Function)
    return Spawn(Function)
end

Library.Round = function(Self, Number, Step)
    return Round(Number, Step)
end

Library.IsMouseOverFrame = function(Self, Object)
    return IsMouseOver(Object or (Self.Instance))
end

Library.ChangeTheme = function(Self, Key, Color)
    Theme[Key] = Color

    for _, Function in Library.Themed do
        Function()
    end
end

Library.CloseAll = function(Self, Except)
    for _, Frame in Library.OpenFrames do
        if Frame ~= Except then
            Frame:SetOpen(false)
        end
    end
end

Library.Exit = function(Self)
    if Library.WindowAccentMotion then
        Library.WindowAccentMotion:Cancel()
        Library.WindowAccentMotion = nil
    end
    for _, Connection in Library.Connections do
        Connection:Disconnect()
    end

    for _, Thread in Library.Threads do
        task.cancel(Thread)
    end

    for _, Object in { Library.Holder, Library.PopupHolder, Library.DragHolder, Library.SnowHolder, Library.Blur } do
        if Object then pcall(function() Object:Destroy() end) end
    end
    if Library.Loading then
        Library.Loading.Gui:Destroy()
    end
    Library.Unloaded = true
    Env.VergilLibrary = nil
end

Library.GetConfig = function(Self)
    local Config = { }

    for Index, Value in Library.Flags do
        if type(Value) == "table" and Value.Key then
            Config[Index] = { Key = tostring(Value.Key), Mode = Value.Mode }
        elseif type(Value) == "table" and Value.Color then
            Config[Index] = { Color = "#" .. Value.HexValue, Alpha = Value.Alpha }
        else
            Config[Index] = Value
        end
    end

    return HttpService:JSONEncode(Config)
end

Library.LoadConfig = function(Self, Config)
    local Ok, Result = pcall(function()
        local Decoded = HttpService:JSONDecode(Config)

        for Index, Value in Decoded do
            local SetFunction = Library.SetFlags[Index]

            if SetFunction then
                if type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                else
                    SetFunction(Value)
                end
            end
        end
    end)

    return Ok, Result
end

Library.GetConfigsList = function(Self, Element)
    local List = { }

    if type(listfiles) == "function" then
        local Ok, Files = pcall(listfiles, ConfigsFolder)
        if Ok and type(Files) == "table" then
            for _, File in Files do
                local Name = File:match("([^/\\]+)%.json$")
                if Name then
                    table.insert(List, Name)
                end
            end
        end
    end

    table.sort(List)

    if Element and Element.Refresh then
        Element:Refresh(List)
    end

    return List
end


if type(isfolder) == "function" and type(makefolder) == "function" then
    if not isfolder(Library.Directory) then
        makefolder(Library.Directory)
    end

    for _, Folder in Library.Folders do
        if not isfolder(Library.Directory .. Folder) then
            makefolder(Library.Directory .. Folder)
        end
    end
end


Library.Font = Font.fromEnum(Enum.Font.Code)


Library.Holder = New("ScreenGui", {
    Parent = GetHui(),
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 100,
})

Library.PopupHolder = New("ScreenGui", {
    Parent = GetHui(),
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 101,
})

Library.DragHolder = New("ScreenGui", {
    Parent = GetHui(),
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 102,
})


Library.NotifHolder = New("Frame", {
    Parent = Library.Holder,
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -14, 0, 14),
    Size = UDim2.new(1, -28, 1, -28),
    ClipsDescendants = false,
})

New("UIListLayout", {
    Parent = Library.NotifHolder,
    VerticalAlignment = Enum.VerticalAlignment.Top,
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 5),
})

Connect(RunService.RenderStepped, function()
    for _, Frame in Library.OpenFrames do
        if Frame.Reposition then
            Frame:Reposition()
        end
    end
end)


Library.Blur = New("BlurEffect", { Parent = Lighting, Size = 0 })

Library.SnowHolder = New("ScreenGui", {
    Parent = GetHui(),
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    DisplayOrder = 99,
})

local SnowFrame = New("Frame", {
    Parent = Library.SnowHolder,
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
    Visible = false,
})

local SnowAlpha = Instance.new("NumberValue")
SnowAlpha.Value = 0
local Flakes = { }

local function Viewport()
    local Size = SnowFrame.AbsoluteSize
    if Size.X < 1 then
        Size = workspace.CurrentCamera.ViewportSize
    end
    return Size
end

local function NewFlake()
    local Size = Viewport()
    local Pixels = math.random(1, 3)

    return {
        Frame = New("Frame", {
            Parent = SnowFrame,
            Size = UDim2.fromOffset(Pixels, Pixels),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1,
        }),
        X = math.random() * Size.X,
        Y = math.random() * Size.Y,
        Speed = 15 + Pixels * 15 + math.random() * 15,
        Drift = math.random(-8, 8),
        Sway = 0.5 + math.random(),
        Phase = math.random() * math.pi * 2,
        Opacity = 0.35 + math.random() * 0.55,
    }
end

Library.SetSnowAmount = function(Self, Amount)

    Amount = 0
    Library.SnowAmount = Amount

    while #Flakes < Amount do
        table.insert(Flakes, NewFlake())
    end

    while #Flakes > Amount do
        table.remove(Flakes).Frame:Destroy()
    end
end

Library.UpdateEffects = function(Self)
    local Open = Library.MenuOpen

    TweenService:Create(Library.Blur, FadeInfo("Window"), { Size = (Open and Library.BlurEnabled) and Library.BlurSize or 0 }):Play()

    SnowAlpha.Value = 0
end

local Clock = 0

Connect(RunService.RenderStepped, function(Delta)
    local Alpha = SnowAlpha.Value

    SnowFrame.Visible = Alpha > 0.001
    if not SnowFrame.Visible then
        return
    end

    Clock += Delta
    local Size = Viewport()

    for _, Flake in Flakes do
        Flake.Y += Flake.Speed * Delta
        Flake.X += (Flake.Drift + math.sin(Clock * Flake.Sway + Flake.Phase) * 12) * Delta

        if Flake.Y > Size.Y + 4 then
            Flake.Y = -4
            Flake.X = math.random() * Size.X
        end

        if Flake.X < -4 then
            Flake.X += Size.X + 8
        elseif Flake.X > Size.X + 4 then
            Flake.X -= Size.X + 8
        end

        Flake.Frame.Position = UDim2.fromOffset(Flake.X, Flake.Y)
        Flake.Frame.BackgroundTransparency = 1 - Flake.Opacity * Alpha
    end
end)

Library:SetSnowAmount(Library.SnowAmount)


local LogStyle = {
    MinWidth = 0,
    MaxWidth = 760,
    Height = 26,
    TextSize = 12,
    PaddingX = 7,
    Enter = 0.32,
    Exit = 0.64,
    MaxVisible = 5,
}
local OpenLogs = {}


local function MeasureLogWidth(Message)
    local Measured = nil

    local Ok, Rect = pcall(function()
        return TextService:GetTextSize(Message, LogStyle.TextSize, Enum.Font.Code, Vector2.new(4096, 48))
    end)
    if Ok and Rect then
        Measured = Rect.X
    end
    if not Measured then

        local OkLength, CharacterCount = pcall(function() return utf8.len(Message) end)
        Measured = (OkLength and CharacterCount or #Message) * (LogStyle.TextSize * 0.61)
    end

    local ViewWidth = 800
    local Camera = workspace.CurrentCamera
    if Camera and Camera.ViewportSize.X > 0 then
        ViewWidth = Camera.ViewportSize.X
    end
    local Maximum = math.max(1, math.min(LogStyle.MaxWidth, ViewWidth - 28))
    local Minimum = math.min(LogStyle.MinWidth, Maximum)
    return math.clamp(math.ceil(Measured + LogStyle.PaddingX * 2), Minimum, Maximum)
end

Library.Notification = function(Self, Params)
    Params = Params or {}
    if Library.Unloaded or not Library.NotifHolder or not Library.NotifHolder.Parent then
        return nil
    end

    local Message = tostring(Params.Name or Params.name or Params.Text or "notification")
    local Width = MeasureLogWidth(Message)
    local Duration = math.clamp(tonumber(Params.Time or Params.time) or 3, 0.6, 30)


    local Slot = New("Frame", {
        Parent = Library.NotifHolder,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, LogStyle.Height),
        ClipsDescendants = false,
        LayoutOrder = NextOrder(),
    })
    local Panel = New("Frame", {
        Parent = Slot,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, Width + 22, 0, 0),
        Size = UDim2.fromOffset(Width, LogStyle.Height),
        BackgroundColor3 = Color3.fromRGB(18, 18, 19),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
    })
    local Stroke = New("UIStroke", {
        Parent = Panel,
        Color = Color3.fromRGB(63, 63, 65),
        Thickness = 1,
        Transparency = 1,
    })
    local Label = New("TextLabel", {
        Parent = Panel,
        Position = UDim2.fromOffset(LogStyle.PaddingX, 0),
        Size = UDim2.new(1, -LogStyle.PaddingX * 2, 1, -1),
        Font = Enum.Font.Code,
        TextSize = LogStyle.TextSize,
        TextColor3 = Color3.fromRGB(250, 250, 250),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextTransparency = 1,
        TextStrokeTransparency = 0.55,
        TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
        RichText = false,
        TextWrapped = false,
        ZIndex = 7,
        Text = Message,
    })
    local ProgressBack = New("Frame", {
        Parent = Panel,
        Position = UDim2.new(0, 1, 1, -3),
        Size = UDim2.new(1, -2, 0, 1),
        ZIndex = 9,
        BackgroundColor3 = Color3.fromRGB(54, 54, 54),
        BackgroundTransparency = 1,
    })
    local ProgressFill = New("Frame", {
        Parent = ProgressBack,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        ZIndex = 10,
    })

    local Entry = { Closed = false, Removed = false, Slot = Slot }
    table.insert(OpenLogs, Entry)

    function Entry:Close()
        if self.Closed then return end
        self.Closed = true
        local Index = table.find(OpenLogs, self)
        if Index then table.remove(OpenLogs, Index) end
        if not Slot.Parent then return end

        local ExitInfo = TweenInfo.new(LogStyle.Exit, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        local Leaving = TweenService:Create(Panel, ExitInfo, {
            Position = UDim2.new(1, Width + 22, 0, 0),
            BackgroundTransparency = 1,
        })
        TweenService:Create(Stroke, ExitInfo, { Transparency = 1 }):Play()
        TweenService:Create(Label, ExitInfo, { TextTransparency = 1 }):Play()
        TweenService:Create(ProgressBack, ExitInfo, { BackgroundTransparency = 1 }):Play()
        TweenService:Create(ProgressFill, ExitInfo, { BackgroundTransparency = 1 }):Play()
        Leaving.Completed:Connect(function()
            self.Removed = true
            if Slot.Parent then Slot:Destroy() end
        end)
        Leaving:Play()
    end

    if #OpenLogs > LogStyle.MaxVisible then
        local Oldest = OpenLogs[1]
        if Oldest and Oldest ~= Entry then Oldest:Close() end
    end

    local InInfo = TweenInfo.new(LogStyle.Enter, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local Opening = TweenService:Create(Panel, InInfo, {
        Position = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 0.06,
    })
    TweenService:Create(Stroke, InInfo, { Transparency = 0.04 }):Play()
    TweenService:Create(Label, InInfo, { TextTransparency = 0.08 }):Play()
    TweenService:Create(ProgressBack, InInfo, { BackgroundTransparency = 0.25 }):Play()
    TweenService:Create(ProgressFill, InInfo, { BackgroundTransparency = 0 }):Play()

    Opening.Completed:Connect(function(State)
        if State ~= Enum.PlaybackState.Completed or Entry.Closed or not Slot.Parent then return end
        local Countdown = TweenService:Create(ProgressFill,
            TweenInfo.new(Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            { Size = UDim2.new(0, 0, 1, 0) })
        Countdown:Play()
        task.delay(Duration, function()
            if not Entry.Closed then Entry:Close() end
        end)
    end)
    Opening:Play()
    return Entry
end


local TooltipBox = New("Frame", {
    Parent = Library.PopupHolder,
    Visible = false,
    Active = false,
    ZIndex = 1200,
    BackgroundTransparency = 1,
    BackgroundColor3 = Color3.fromRGB(18, 18, 19),
    Size = UDim2.fromOffset(30, 25),
})
local TooltipEdge = New("UIStroke", {
    Parent = TooltipBox,
    Color = Color3.fromRGB(86, 86, 88),
    Transparency = 1,
    Thickness = 1,
})
local TooltipText = New("TextLabel", {
    Parent = TooltipBox,
    Position = UDim2.fromOffset(8, 5),
    Size = UDim2.new(1, -16, 1, -10),
    Text = "",
    Font = Enum.Font.Code,
    TextSize = 12,
    TextColor3 = Color3.fromRGB(222, 222, 225),
    TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
    TextStrokeTransparency = 0.68,
    TextTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
    TextWrapped = true,
    RichText = false,
    ZIndex = 1201,
})

local HoverHelp = {
    Delay = 1.0,
    Owner = nil,
    Ticket = 0,
    Visible = false,
    Tween = nil,
    LabelTween = nil,
    EdgeTween = nil,
}
Library.HoverHelp = HoverHelp

local function TooltipPosition()
    local Screen = Library.PopupHolder.AbsoluteSize
    if Screen.X <= 0 or Screen.Y <= 0 then
        local Camera = workspace.CurrentCamera
        Screen = Camera and Camera.ViewportSize or Vector2.new(800, 600)
    end
    local Cursor = UserInputService:GetMouseLocation()
    local Width = TooltipBox.Size.X.Offset
    local Height = TooltipBox.Size.Y.Offset
    local X = math.clamp(math.floor(Cursor.X + 12), 4, math.max(4, Screen.X - Width - 4))
    local Y = math.floor(Cursor.Y + 19)
    if Y + Height > Screen.Y - 5 then
        Y = math.floor(Cursor.Y - Height - 12)
    end
    Y = math.clamp(Y, 4, math.max(4, Screen.Y - Height - 4))
    TooltipBox.Position = UDim2.fromOffset(X, Y)
end

local function TooltipFade(Visible)
    if HoverHelp.Tween then HoverHelp.Tween:Cancel() end
    if HoverHelp.LabelTween then HoverHelp.LabelTween:Cancel() end
    if HoverHelp.EdgeTween then HoverHelp.EdgeTween:Cancel() end
    if Visible then TooltipBox.Visible = true end
    local Duration = Visible and 0.22 or 0.16
    local Info = TweenInfo.new(Duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    HoverHelp.Tween = TweenService:Create(TooltipBox, Info, {
        BackgroundTransparency = Visible and 0.06 or 1,
    })
    HoverHelp.LabelTween = TweenService:Create(TooltipText, Info, {
        TextTransparency = Visible and 0 or 1,
    })
    HoverHelp.EdgeTween = TweenService:Create(TooltipEdge, Info, {
        Transparency = Visible and 0.18 or 1,
    })
    HoverHelp.Tween:Play()
    HoverHelp.LabelTween:Play()
    HoverHelp.EdgeTween:Play()
    if not Visible then
        local FadeOut = HoverHelp.Tween
        FadeOut.Completed:Connect(function(State)
            if State == Enum.PlaybackState.Completed and HoverHelp.Tween == FadeOut
                and not HoverHelp.Visible then
                TooltipBox.Visible = false
            end
        end)
    end
end

function HoverHelp:Hide()
    self.Ticket += 1
    self.Owner = nil
    if not self.Visible and not TooltipBox.Visible then return end
    self.Visible = false
    TooltipFade(false)
end

local function TooltipShow(Object, Message)
    if not Object or not Object.Parent or Library.Unloaded or not Library.MenuOpen then return end
    local Window = Library.WindowObject
    if Window and not Window.IsOpen then return end
    local Screen = Library.PopupHolder.AbsoluteSize
    local MaxWidth = math.max(90, math.min(300, Screen.X - 18))
    local TextWidth = MaxWidth - 16
    local TextSize
    local Ok, Result = pcall(function()
        return TextService:GetTextSize(Message, 12, Enum.Font.Code, Vector2.new(TextWidth, 1000))
    end)
    if Ok and Result then
        TextSize = Result
    else
        TextSize = Vector2.new(math.min(TextWidth, #Message * 7), 15)
    end
    local Width = math.min(MaxWidth, math.ceil(TextSize.X) + 16)
    local Height = math.ceil(TextSize.Y) + 12
    TooltipBox.Size = UDim2.fromOffset(math.max(24, Width), math.max(24, Height))
    TooltipText.Text = Message
    TooltipPosition()
    HoverHelp.Visible = true
    TooltipFade(true)
end

local function AttachHoverHelp(Object, Description, Page)
    if Description == nil then return end
    local Message = tostring(Description)
    if Message == "" then return end
    local Hovering = false
    local function Eligible()
        if not Hovering or Library.Unloaded or not Library.MenuOpen or not Object.Parent then return false end
        local Window = Library.WindowObject
        if Window and not Window.IsOpen then return false end
        if Page and Window and Window.Current ~= Page then return false end
        if not Object.Visible or Object.AbsoluteSize.X < 1 or Object.AbsoluteSize.Y < 1 then return false end
        return IsMouseOver(Object)
    end

    Connect(Object.MouseEnter, function()
        Hovering = true
        HoverHelp:Hide()
        HoverHelp.Owner = Object
        local Ticket = HoverHelp.Ticket
        task.delay(HoverHelp.Delay, function()
            if HoverHelp.Ticket == Ticket and HoverHelp.Owner == Object and Eligible() then
                TooltipShow(Object, Message)
            end
        end)
    end)
    Connect(Object.MouseLeave, function()
        Hovering = false
        if HoverHelp.Owner == Object then HoverHelp:Hide() end
    end)
    Connect(Object.InputBegan, function(Input)
        if IsClick(Input) and HoverHelp.Owner == Object then HoverHelp:Hide() end
    end)
end

Connect(UserInputService.InputChanged, function(Input)
    if HoverHelp.Visible and IsMove(Input) then TooltipPosition() end
end)
Connect(UserInputService.InputBegan, function(Input)
    if HoverHelp.Visible and (IsClick(Input) or Input.UserInputType == Enum.UserInputType.Keyboard) then
        HoverHelp:Hide()
    end
end)


Library.Loader = function(Self, Params)
    Params = Params or { }
    local Assets = Library.Directory .. Library.Folders.Assets
    local Sheets = { }
    for Index = 1, 3 do
        local Path = `{Assets}/von_{Index}.png`
        if not isfile(Path) then
            writefile(Path, base64decode(game:HttpGet(`https://raw.githubusercontent.com/skekkstunsua-lgtm/von/refs/heads/main/von_{Index}.txt`)))
        end
        Sheets[Index] = getcustomasset(Path)
    end
    ContentProvider:PreloadAsync(Sheets)
    local Gui = New("ScreenGui", {
        Parent = GetHui(),
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        DisplayOrder = 103,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    local Main = New("Frame", {
        Parent = Gui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(256, 314),
        BackgroundTransparency = 0,
    })
    Themed(function() Main.BackgroundColor3 = Theme.Window end)
    local Scale = New("UIScale", { Parent = Main, Scale = 0.85 })
    local Stroke = New("UIStroke", {
        Parent = Main,
        Color = Color3.new(1, 1, 1),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        LineJoinMode = Enum.LineJoinMode.Miter,
        BorderStrokePosition = StrokeInner,
        ZIndex = 2,
    })
    local StrokeGradient = New("UIGradient", { Parent = Stroke })
    Themed(function() StrokeGradient.Color = AccentSequence(Theme.Accent:Lerp(Theme.Window, 0.6)) end)
    New("UIStroke", {
        Parent = Main,
        Color = Color3.new(0, 0, 0),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        LineJoinMode = Enum.LineJoinMode.Miter,
        BorderOffset = UDim.new(0, 1),
        BorderStrokePosition = StrokeInner,
    })
    local Title = New("TextLabel", {
        Parent = Main,
        Position = UDim2.fromOffset(10, 8),
        Size = UDim2.new(1, -20, 0, 14),
        RichText = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = Params.Name or Library.Name,
    })
    MainGradient(Title)
    local Tag = New("TextLabel", {
        Parent = Main,
        Position = UDim2.fromOffset(10, 8),
        Size = UDim2.new(1, -20, 0, 14),
        TextXAlignment = Enum.TextXAlignment.Right,
        Text = "loader",
    })
    Themed(function() Tag.TextColor3 = Theme["Dim Text"] end)
    local LogoHolder = New("Frame", {
        Parent = Main,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 28),
        Size = UDim2.fromOffset(236, 236),
        BackgroundTransparency = 0,
    })
    Themed(function() LogoHolder.BackgroundColor3 = Theme.Background end)
    Outline(LogoHolder)
    local Logo = New("ImageLabel", {
        Parent = LogoHolder,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(220, 220),
        BackgroundTransparency = 1,
        Image = Sheets[1],
        ImageRectSize = Vector2.new(170, 170),
    })
    local Status = New("TextLabel", {
        Parent = Main,
        Position = UDim2.fromOffset(10, 274),
        Size = UDim2.new(1, -20, 0, 12),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = "loading...",
    })
    Themed(function() Status.TextColor3 = Theme["Dim Text"] end)
    local Percent = New("TextLabel", {
        Parent = Main,
        Position = UDim2.fromOffset(10, 274),
        Size = UDim2.new(1, -20, 0, 12),
        TextXAlignment = Enum.TextXAlignment.Right,
        Text = "0%",
    })
    Themed(function() Percent.TextColor3 = Theme.Accent end)
    local Track = New("Frame", {
        Parent = Main,
        Position = UDim2.fromOffset(10, 294),
        Size = UDim2.new(1, -20, 0, 6),
        BackgroundTransparency = 0,
    })
    Themed(function() Track.BackgroundColor3 = Theme.Hover end)
    Outline(Track)
    local Fill = New("Frame", {
        Parent = Track,
        Size = UDim2.fromScale(0, 1),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.new(1, 1, 1),
        ClipsDescendants = true,
    })
    local FillGradient = New("UIGradient", { Parent = Fill })
    Themed(function() FillGradient.Color = ColorSequence.new(Theme["Element Accent"], Theme.Accent) end)
    local Shimmer = New("Frame", {
        Parent = Fill,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.new(1, 1, 1),
    })
    local ShimmerGradient = New("UIGradient", {
        Parent = Shimmer,
        Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.5, 0.55),
            NumberSequenceKeypoint.new(1, 1),
        },
    })
    local LastFrame = nil
    local Animation = Connect(RunService.RenderStepped, function()
        local Now = os.clock()
        StrokeGradient.Rotation = Now * 90 % 360
        ShimmerGradient.Offset = Vector2.new(Now * 0.8 % 2 - 1, 0)
        local Frame = math.floor(Now * 25) % 75
        if Frame == LastFrame then
            return
        end
        LastFrame = Frame
        local Cell = Frame % 36
        Logo.Image = Sheets[Frame // 36 + 1]
        Logo.ImageRectOffset = Vector2.new(Cell % 6 * 170, Cell // 6 * 170)
    end)
    TweenService:Create(Scale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
    local Loader = { Gui = Gui }
    Library.Loading = Loader
    function Loader:SetProgress(Alpha, Text)
        Alpha = math.clamp(Alpha, 0, 1)
        Tween(Fill, { Size = UDim2.fromScale(Alpha, 1) }, 0.25)
        Percent.Text = `{math.floor(Alpha * 100)}%`
        if Text then
            Status.Text = Text
        end
        task.wait()
    end
    function Loader:Finish()
        Loader:SetProgress(1, "done")
        task.wait(0.35)
        local Out = TweenService:Create(Scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Scale = 0 })
        Out:Play()
        Out.Completed:Wait()
        Animation:Disconnect()
        Gui:Destroy()
        Library.Loading = nil
        if Library.WindowObject then
            Library.WindowObject:SetOpen(true)
        end
    end
    return Loader
end


local Drag = nil

local function CanDrag()
    local Window = Library.WindowObject

    if Drag or not Window or not Window.IsOpen or Window.Fader.Tween then
        return false
    end

    local Page = Window.Current
    return not (Page and Page.Fader.Tween)
end

local function SettleLanding()
    for Section in Library.Landing do
        Section:Settle()
    end
end

local function NewPlaceholder(Column, Height, Instant)
    local Frame = New("Frame", {
        Parent = Column.Scroll,
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -4, 0, Instant and Height or 0),
    })

    local Stroke = New("UIStroke", {
        Parent = Frame,
        Color = Theme.Accent,
        Transparency = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        LineJoinMode = Enum.LineJoinMode.Miter,
        BorderStrokePosition = StrokeInner,
    })

    Tween(Frame, { BackgroundTransparency = 0.86, Size = UDim2.new(1, -4, 0, Height) })
    Tween(Stroke, { Transparency = 0 })

    return {
        Frame = Frame,
        Stroke = Stroke,
        Height = Height,
        Placeholder = true,
        Tweens = { },
    }
end

local function DropPlaceholder(Placeholder, Shrink)
    local Goal = { BackgroundTransparency = 1 }

    if Shrink then
        Goal.Size = UDim2.new(1, -4, 0, 0)
    end

    Tween(Placeholder.Stroke, { Transparency = 1 })
    Tween(Placeholder.Frame, Goal).Completed:Connect(function()
        Placeholder.Frame:Destroy()
    end)
end

local function SlotAt(Mouse)
    local Window = Library.WindowObject
    local Page = Window and Window.Current

    if not Page or not Window.IsOpen then
        return nil
    end

    local Area = Window.Items.Content.Instance

    if not IsMouseOver(Area) then
        return nil
    end

    local Middle = Area.AbsolutePosition.X + Area.AbsoluteSize.X / 2
    local Column = Page.Columns[Mouse.X < Middle and 1 or 2]
    local Y = Mouse.Y - Column.Scroll.AbsolutePosition.Y + Column.Scroll.CanvasPosition.Y
    local Index = 1

    for _, Item in Column.Items do
        if not Item.Placeholder and Y > Item.Y + (Item.Hidden and 0 or Item.Height / 2) then
            Index += 1
        end
    end

    return Column, Index
end

local function Reshape()
    local Section = Drag.Section
    local Size = Drag.Size

    if Drag.Column then
        Size = Vector2.new(Drag.Column.Scroll.AbsoluteSize.X - 4, Section.Height)
    end

    Drag.Offset = Vector2.new(math.min(Drag.Offset.X, Size.X - 16), Drag.Offset.Y)
    Glide(Section, "Size", { Size = UDim2.fromOffset(Size.X, Size.Y) })
end

local function SetSlot(Column, Index)
    if Column == Drag.Column and Index == Drag.Index then
        return
    end

    local Old = Drag.Column
    local Placeholder = Drag.Placeholder

    if Old then
        table.remove(Old.Items, table.find(Old.Items, Placeholder))

        if Old ~= Column then
            DropPlaceholder(Placeholder, true)
            Placeholder = nil
            Old:Layout()
        end
    end

    if Column then
        local Snap = nil

        if not Placeholder then
            Placeholder = NewPlaceholder(Column, Drag.Section.Height)
            Snap = Placeholder
        end

        table.insert(Column.Items, Index, Placeholder)
        Column:Layout(false, Snap)
    end

    Drag.Column, Drag.Index, Drag.Placeholder = Column, Index, Placeholder

    if Column ~= Old then
        Reshape()
    end
end

local function BeginDrag(Section)
    local Frame = Section.Frame
    local Column = Section.Column
    local Position = Frame.AbsolutePosition

    Library:CloseAll()

    Drag = {
        Section = Section,
        Position = Position,
        Offset = MouseAbs() - Position,
        Size = Section.FloatSize or Frame.AbsoluteSize,
    }

    if Column then
        local Index = table.find(Column.Items, Section)
        local Placeholder = NewPlaceholder(Column, Section.Height, true)

        Column.Items[Index] = Placeholder
        Drag.Column, Drag.Index, Drag.Placeholder = Column, Index, Placeholder
        Column:Layout(false, Placeholder)
    end

    Section:Lift()
end

local function EndDrag()
    local Current = Drag
    local Column, Placeholder = Current.Column, Current.Placeholder

    Drag = nil

    if Column then
        local Index = table.find(Column.Items, Placeholder)

        table.remove(Column.Items, Index)
        DropPlaceholder(Placeholder)
        Current.Section:Dock(Column, Index)
    else
        Current.Section:Float()
    end
end

Connect(RunService.RenderStepped, function(Delta)
    if not Drag then
        return
    end

    local Mouse = MouseAbs()
    local Origin = Library.DragHolder.AbsolutePosition

    Drag.Position = Drag.Position:Lerp(Mouse - Drag.Offset, math.min(Delta * 24, 1))
    Drag.Section.Frame.Position = UDim2.fromOffset(Drag.Position.X - Origin.X, Drag.Position.Y - Origin.Y)

    local Column, Index = SlotAt(Mouse)

    if Column then
        local Scroll = Column.Scroll
        local Top = Scroll.AbsolutePosition.Y
        local Bottom = Top + Scroll.AbsoluteSize.Y
        local Direction = 0

        if Mouse.Y < Top + 24 then
            Direction = -1
        elseif Mouse.Y > Bottom - 24 then
            Direction = 1
        end

        if Direction ~= 0 then
            local Limit = math.max(Scroll.AbsoluteCanvasSize.Y - Scroll.AbsoluteWindowSize.Y, 0)
            Scroll.CanvasPosition = Vector2.new(0, math.clamp(Scroll.CanvasPosition.Y + Direction * 320 * Delta, 0, Limit))
        end
    end

    SetSlot(Column, Index)
end)

Connect(UserInputService.InputEnded, function(Input)
    if Drag and IsClick(Input) then
        EndDrag()
    end
end)


Library.CreateColorpicker = function(Self, Data)
    local Colorpicker = {
        Hue = 0,
        Saturation = 0,
        Value = 1,
        Alpha = 0,

        Color = Color3.new(1, 1, 1),
        HexValue = "FFFFFF",

        Flag = Data.Flag,
        IsOpen = false,
        Items = { },
    }

    local Swatch = New("TextButton", {
        Parent = Data.Parent,
        Size = UDim2.fromOffset(22, 11),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.new(1, 1, 1),
        LayoutOrder = NextOrder(),
    })
    Outline(Swatch)


    local Popup = New("TextButton", {
        Parent = Library.PopupHolder,
        Visible = false,
        BackgroundTransparency = 0,
        Size = UDim2.fromOffset(194, 192),
    })
    Themed(function() Popup.BackgroundColor3 = Theme.Window end)
    Outline(Popup, "Border")

    local Palette = New("TextButton", {
        Parent = Popup,
        BackgroundTransparency = 0,
        Position = UDim2.fromOffset(6, 7),
        Size = UDim2.new(1, -32, 1, -43),
    })
    Outline(Palette)

    local SaturationOverlay = New("Frame", {
        Parent = Palette,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(1, 1, 1),
    })
    New("UIGradient", { Parent = SaturationOverlay, Transparency = NumberSequence.new(0, 1) })

    local ValueOverlay = New("Frame", {
        Parent = Palette,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.new(0, 0, 0),
        ZIndex = 2,
    })
    New("UIGradient", { Parent = ValueOverlay, Rotation = 90, Transparency = NumberSequence.new(1, 0) })

    local PaletteDragger = New("Frame", {
        Parent = Palette,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromOffset(3, 3),
        BackgroundColor3 = Color3.new(1, 1, 1),
        ZIndex = 3,
    })
    New("UIStroke", { Parent = PaletteDragger, Color = Color3.new(0, 0, 0) })

    local HueBar = New("TextButton", {
        Parent = Popup,
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.new(1, 1, 1),
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -6, 0, 7),
        Size = UDim2.new(0, 14, 1, -43),
    })
    Outline(HueBar)
    New("UIGradient", {
        Parent = HueBar,
        Rotation = 90,
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
        }
    })

    local HueDragger = New("Frame", {
        Parent = HueBar,
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Color3.new(1, 1, 1),
        ZIndex = 2,
    })
    New("UIStroke", { Parent = HueDragger, Color = Color3.new(0, 0, 0) })


    local HexInput = New("TextBox", {
        Parent = Popup,
        Position = UDim2.new(0, 6, 1, -24),
        Size = UDim2.new(1, -42, 0, 17),
        BackgroundTransparency = 0,
        BackgroundColor3 = Theme.Background,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        TextStrokeTransparency = 1,
        Text = "#FFFFFF",
    })
    Outline(HexInput)
    New("UIPadding", { Parent = HexInput, PaddingLeft = UDim.new(0, 5) })
    local Preview = New("Frame", {
        Parent = Popup,
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -6, 1, -7),
        Size = UDim2.fromOffset(24, 12),
        BackgroundTransparency = 0,
    })
    Outline(Preview)

    Colorpicker.Items = {
        ColorpickerButton = Wrap(Swatch),
        ColorpickerWindow = Wrap(Popup),
        Palette = Wrap(Palette),
        Hue = Wrap(HueBar),
        Hex = Wrap(HexInput),
    }
    Colorpicker.Holder = Colorpicker.Items.ColorpickerWindow

    function Colorpicker:Update()
        Colorpicker.Color = Color3.fromHSV(Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value)
        Colorpicker.HexValue = Colorpicker.Color:ToHex()

        Swatch.BackgroundColor3 = Colorpicker.Color
        Palette.BackgroundColor3 = Color3.fromHSV(Colorpicker.Hue, 1, 1)
        Preview.BackgroundColor3 = Colorpicker.Color
        Preview.BackgroundTransparency = 0
        HexInput.Text = "#" .. Colorpicker.HexValue

        PaletteDragger.Position = UDim2.fromScale(Colorpicker.Saturation, 1 - Colorpicker.Value)
        HueDragger.Position = UDim2.fromScale(0, Colorpicker.Hue)

        Flags[Colorpicker.Flag] = {
            Alpha = 0,
            Color = Colorpicker.Color,
            HexValue = Colorpicker.HexValue,
            Transparency = 0,
        }

        SafeCall(Data.Callback, Colorpicker.Color, 0)
    end

    function Colorpicker:Set(Color, Alpha)
        if type(Color) == "table" then
            Color = Color3.fromRGB(Color[1], Color[2], Color[3])
        elseif type(Color) == "string" then
            Color = Color3.fromHex(Color)
        end

        if typeof(Color) ~= "Color3" then
            return
        end

        Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
        Colorpicker.Alpha = 0
        Colorpicker:Update()
    end

    function Colorpicker:SetVisibility(Bool)
        Swatch.Visible = Bool
    end

    function Colorpicker:Reposition()
        PlaceBelow(Popup, Swatch, 6, true)
    end

    Popup.ClipsDescendants = true
    local PickerFullSize = UDim2.fromOffset(194, 192)
    local PickerClosedSize = UDim2.fromOffset(194, 0)

    function Colorpicker:SetOpen(Bool)
        Bool = Bool and true or false
        if Colorpicker.IsOpen == Bool then return end
        Colorpicker.IsOpen = Bool
        Colorpicker.Generation = (Colorpicker.Generation or 0) + 1
        local Generation = Colorpicker.Generation
        if Bool then
            Library:CloseAll(Colorpicker)
            if not Popup.Visible then
                Popup.Size = PickerClosedSize
            end
            Popup.Visible = true
            Colorpicker:Reposition()
            Library.OpenFrames[Colorpicker] = Colorpicker
            Smooth(Popup, "PickerHeight", { Size = PickerFullSize }, 0.34)
        else
            Library.OpenFrames[Colorpicker] = nil
            local Motion = Smooth(Popup, "PickerHeight", { Size = PickerClosedSize }, 0.25)
            Motion.Completed:Connect(function(State)
                if Generation == Colorpicker.Generation and not Colorpicker.IsOpen
                    and State == Enum.PlaybackState.Completed then
                    Popup.Visible = false
                end
            end)
        end
    end

    local Sliding = nil

    local function Slide()
        local Mouse = MouseAbs()

        if Sliding == "Palette" then
            local Position, Size = Palette.AbsolutePosition, Palette.AbsoluteSize
            Colorpicker.Saturation = math.clamp((Mouse.X - Position.X) / Size.X, 0, 1)
            Colorpicker.Value = 1 - math.clamp((Mouse.Y - Position.Y) / Size.Y, 0, 1)
        elseif Sliding == "Hue" then
            local Position, Size = HueBar.AbsolutePosition, HueBar.AbsoluteSize
            Colorpicker.Hue = math.clamp((Mouse.Y - Position.Y) / Size.Y, 0, 0.999)

        else
            return
        end

        Colorpicker:Update()
    end

    for Name, Object in { Palette = Palette, Hue = HueBar } do
        Connect(Object.InputBegan, function(Input)
            if IsClick(Input) then
                Sliding = Name
                Slide()
            end
        end)
    end

    Connect(UserInputService.InputChanged, function(Input)
        if Sliding and IsMove(Input) then
            Slide()
        end
    end)

    Connect(UserInputService.InputEnded, function(Input)
        if IsClick(Input) then
            Sliding = nil
        end
    end)

    Connect(Swatch.MouseButton1Click, function()
        Colorpicker:SetOpen(not Colorpicker.IsOpen)
    end)

    Connect(UserInputService.InputBegan, function(Input)
        if IsClick(Input) and Colorpicker.IsOpen and not IsMouseOver(Popup) and not IsMouseOver(Swatch) then
            Colorpicker:SetOpen(false)
        end
    end)

    Connect(HexInput.FocusLost, function()
        local Raw = tostring(HexInput.Text):gsub("#", ""):gsub("%s", "")
        if #Raw == 6 and Raw:match("^[%x]+$") then
            local Ok, Parsed = pcall(Color3.fromHex, "#" .. Raw)
            if Ok and Parsed then
                Colorpicker:Set(Parsed)
                return
            end
        end
        HexInput.Text = "#" .. Colorpicker.HexValue
    end)

    Colorpicker:Set(Data.Default or Color3.new(1, 1, 1), 0)

    SetFlags[Colorpicker.Flag] = function(Value, Alpha)
        Colorpicker:Set(Value, Alpha)
    end

    return Colorpicker, Colorpicker.Items
end


Library.CreateKeybind = function(Self, Data)
    local Keybind = {
        Flag = Data.Flag,
        IsOpen = false,

        Key = "None",
        Mode = Data.Mode or "Toggle",
        Value = "None",

        Toggled = false,
        Picking = false,

        Items = { },
    }

    local KeyButton = New("TextButton", {
        Parent = Data.Parent,
        Size = UDim2.new(0, 0, 0, 12),
        AutomaticSize = Enum.AutomaticSize.X,
        TextXAlignment = Enum.TextXAlignment.Right,
        Text = "[None]",
        LayoutOrder = NextOrder(),
    })

    local function Paint()
        KeyButton.TextColor3 = Keybind.Picking and Theme.Text or Theme["Dim Text"]
    end
    Themed(Paint)

    local ModePopupHeight = 3 * 16 + 2 * 3 + 10
    local ModePopupWidth = 82
    local ModePopup = New("Frame", {
        Parent = Library.PopupHolder,
        Visible = false,
        BackgroundTransparency = 0,
        Size = UDim2.fromOffset(ModePopupWidth, 0),
        ClipsDescendants = true,
    })
    Themed(function() ModePopup.BackgroundColor3 = Theme.Window end)
    Outline(ModePopup)
    New("UIPadding", { Parent = ModePopup, PaddingTop = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5) })
    New("UIListLayout", { Parent = ModePopup, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })

    local ModeButtons = { }

    local function PaintModes()
        for Mode, Button in ModeButtons do
            Button.TextColor3 = (Keybind.Mode == Mode) and Theme.Text or Theme["Option Text"]
        end
    end

    Keybind.Items = {
        KeyButton = Wrap(KeyButton),
        KeybindWindow = Wrap(ModePopup),
    }
    Keybind.Holder = Keybind.Items.KeybindWindow

    local Entry
    if Library.KeyList and Data.ShowInList ~= false then
        Entry = Library.KeyList:Add(Data.Name or Keybind.Flag, Keybind.Mode)
    end

    local function Update()
        PaintModes()

        if not Entry then
            return
        end

        Entry:Set(Data.Name or Keybind.Flag, Keybind.Mode)

        if Keybind.Mode == "Hold" then
            Entry:SetMode(Keybind.Toggled and "holding" or "off")
        elseif Keybind.Mode == "Always" then
            Entry:SetMode("always on")
        else
            Entry:SetMode(Keybind.Toggled and "toggled" or "off")
        end

        Entry:SetStatus(Keybind.Toggled)
    end

    local function WriteFlag()
        Flags[Keybind.Flag] = {
            Mode = Keybind.Mode,
            Key = Keybind.Key,
            Toggled = Keybind.Toggled,
        }
    end

    function Keybind:SetMode()
        WriteFlag()
        SafeCall(Data.Callback, Keybind.Toggled)
        Update()
    end

    function Keybind:Press(Bool)
        if Keybind.Mode == "Toggle" then
            Keybind.Toggled = not Keybind.Toggled
        elseif Keybind.Mode == "Hold" then
            Keybind.Toggled = Bool
        elseif Keybind.Mode == "Always" then
            Keybind.Toggled = true
        end

        WriteFlag()
        SafeCall(Data.Callback, Keybind.Toggled)
        Update()
    end

    local function ApplyKey(Key)
        local Display = KeyName(Key)

        if Display == "None" then
            Keybind.Key = "None"
        else
            Keybind.Key = tostring(Key)
        end

        Keybind.Value = Display
        KeyButton.Text = "[" .. Display .. "]"
    end

    function Keybind:Set(Key)
        if typeof(Key) == "EnumItem" then
            ApplyKey(Key)
            Keybind:SetMode()
        elseif type(Key) == "table" then
            ApplyKey(Key.Key or "None")
            Keybind.Mode = Key.Mode or "Toggle"
            Keybind:SetMode()

            if Keybind.Mode == "Always" then
                Keybind:Press(true)
            end
        elseif type(Key) == "string" and table.find({ "Toggle", "Hold", "Always" }, Key) then
            Keybind.Mode = Key
            Keybind:SetMode()
        elseif type(Key) == "string" then
            ApplyKey(Key)
            Keybind:SetMode()
        end

        Keybind.Picking = false
        Paint()
    end

    function Keybind:Reposition()
        PlaceBelow(ModePopup, KeyButton, 4, true)
    end

    function Keybind:SetOpen(Bool)
        Bool = Bool and true or false
        if Bool == Keybind.IsOpen then return end
        Keybind.IsOpen = Bool
        Keybind.PopupVersion = (Keybind.PopupVersion or 0) + 1
        local Version = Keybind.PopupVersion

        if Bool then
            Library:CloseAll(Keybind)
            if not ModePopup.Visible then
                ModePopup.Size = UDim2.fromOffset(ModePopupWidth, 0)
            end
            ModePopup.Visible = true
            Keybind:Reposition()
            Library.OpenFrames[Keybind] = Keybind
            Smooth(ModePopup, "ModePopupHeight", {
                Size = UDim2.fromOffset(ModePopupWidth, ModePopupHeight)
            }, 0.30, Enum.EasingStyle.Quint)
        else
            Library.OpenFrames[Keybind] = nil
            local Motion = Smooth(ModePopup, "ModePopupHeight", {
                Size = UDim2.fromOffset(ModePopupWidth, 0)
            }, 0.26, Enum.EasingStyle.Quint)
            Motion.Completed:Connect(function(State)
                if Version == Keybind.PopupVersion and not Keybind.IsOpen
                    and State == Enum.PlaybackState.Completed then
                    ModePopup.Visible = false
                end
            end)
        end
    end

    for Index, Mode in { "Toggle", "Hold", "Always" } do
        local Button = New("TextButton", {
            Parent = ModePopup,
            Size = UDim2.new(1, 0, 0, 16),
            Text = Mode:lower(),
            LayoutOrder = Index,
        })

        ModeButtons[Mode] = Button

        Connect(Button.MouseButton1Click, function()
            Keybind.Mode = Mode
            Keybind:SetMode()

            if Mode == "Always" then
                Keybind:Press(true)
            end

            Keybind:SetOpen(false)
        end)
    end

    Connect(KeyButton.MouseButton1Click, function()
        if Keybind.Picking then
            return
        end

        Keybind.Picking = true
        KeyButton.Text = "[...]"
        Paint()

        local Picker
        Picker = UserInputService.InputBegan:Connect(function(Input)
            local Key

            if Input.UserInputType == Enum.UserInputType.Keyboard then
                Key = Input.KeyCode
            elseif Input.UserInputType == Enum.UserInputType.MouseButton1
                or Input.UserInputType == Enum.UserInputType.MouseButton2
                or Input.UserInputType == Enum.UserInputType.MouseButton3 then
                Key = Input.UserInputType
            else
                return
            end

            Picker:Disconnect()

            ApplyKey(Key)
            WriteFlag()
            SafeCall(Data.Callback, Keybind.Toggled)
            Update()

            task.defer(function()
                Keybind.Picking = false
                Paint()
            end)
        end)
    end)

    Connect(KeyButton.MouseButton2Click, function()
        Keybind:SetOpen(not Keybind.IsOpen)
    end)

    local function Matches(Input)
        return tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key
    end

    Connect(UserInputService.InputBegan, function(Input, GameProcessed)
        if IsClick(Input) and Keybind.IsOpen and not IsMouseOver(ModePopup) and not IsMouseOver(KeyButton) then
            Keybind:SetOpen(false)
        end

        if Keybind.Picking or Keybind.Value == "None" or GameProcessed then
            return
        end

        if Data.Toggle and not Data.Toggle.Value then
            return
        end

        if Matches(Input) then
            if Keybind.Mode == "Toggle" then
                Keybind:Press()
            else
                Keybind:Press(true)
            end
        end
    end)

    Connect(UserInputService.InputEnded, function(Input, GameProcessed)
        if GameProcessed or Keybind.Value == "None" then
            return
        end

        if Matches(Input) and Keybind.Mode == "Hold" then
            Keybind:Press(false)
        end
    end)

    if Data.Default then
        Keybind:Set({ Key = Data.Default, Mode = Data.Mode or "Toggle" })
    else
        WriteFlag()
        Update()
    end

    SetFlags[Keybind.Flag] = function(Value)
        Keybind:Set(Value)
    end

    return Keybind, Keybind.Items
end


Library.Watermark = function(Self, Params)
    Params = Params or {}

    local Watermark = {
        Name = tostring(Params.Name or Params.name or "UI v4"),
        SubName = Params.SubName or Params.subname,
        Items = {},
    }

    local OUTER_MARGIN = 2
    local HEIGHT = 26
    local TEXT_SIZE = 14
    local HORIZONTAL_PADDING = 9
    local MIN_WIDTH = 64
    local MAX_WIDTH = 460
    local FRAME_COLOR = Color3.fromRGB(18, 18, 19)
    local BORDER_COLOR = Color3.fromRGB(63, 63, 65)
    local WHITE = Color3.fromRGB(255, 255, 255)

    local function ViewportSize()
        local camera = workspace.CurrentCamera
        return (camera and camera.ViewportSize) or Vector2.new(1280, 720)
    end

    local function Caption()
        local Name = tostring(Watermark.Name or "")
        local SubName = Watermark.SubName
        if SubName and tostring(SubName) ~= "" then
            return Name .. "  /  " .. tostring(SubName)
        end
        return Name
    end


    local function WidthForText(Message)
        local Ok, Bounds = pcall(function()
            return TextService:GetTextSize(Message, TEXT_SIZE, Enum.Font.Code, Vector2.new(4096, 40))
        end)
        local TextWidth
        if Ok and Bounds then
            TextWidth = Bounds.X
        else
            local Good, Count = pcall(function() return utf8.len(Message) end)
            TextWidth = (Good and Count or #Message) * 8.5
        end
        return math.floor(math.clamp(math.ceil(TextWidth + HORIZONTAL_PADDING * 2), MIN_WIDTH, MAX_WIDTH) + 0.5)
    end

    local DesiredWidth = WidthForText(Caption())

    local Frame = New("Frame", {
        Parent = Library.Holder,
        Name = "UIv4Watermark",
        Active = true,
        Position = UDim2.fromOffset(12, 12),
        Size = UDim2.fromOffset(DesiredWidth, HEIGHT),
        BackgroundTransparency = 0.03,
        BackgroundColor3 = FRAME_COLOR,
        ClipsDescendants = true,
        ZIndex = 20,
    })

    New("UIStroke", {
        Parent = Frame,
        Color = BORDER_COLOR,
        Thickness = 1,
        Transparency = 0.04,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        LineJoinMode = Enum.LineJoinMode.Miter,
    })

    local Label = New("TextLabel", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(HORIZONTAL_PADDING, 0),
        Size = UDim2.new(1, -HORIZONTAL_PADDING * 2, 1, -1),
        Font = Enum.Font.Code,
        TextSize = TEXT_SIZE,
        TextColor3 = WHITE,
        TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.42,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextTruncate = Enum.TextTruncate.AtEnd,
        RichText = false,
        Active = false,
        ZIndex = 22,
        Text = "",
    })

    local function RenderText()
        Label.Text = Caption()
        DesiredWidth = WidthForText(Label.Text)
    end
    RenderText()

    local function ClampPosition(X, Y)
        local View = ViewportSize()
        local Width = Frame.Size.X.Offset
        local H = Frame.Size.Y.Offset
        if Width < 1 then Width = math.min(DesiredWidth, math.max(1, View.X - 2 * OUTER_MARGIN)) end
        if H < 1 then H = HEIGHT end
        local MaxX = math.max(OUTER_MARGIN, View.X - Width - OUTER_MARGIN)
        local MaxY = math.max(OUTER_MARGIN, View.Y - H - OUTER_MARGIN)
        Frame.Position = UDim2.fromOffset(
            math.floor(math.clamp(X, OUTER_MARGIN, MaxX) + 0.5),
            math.floor(math.clamp(Y, OUTER_MARGIN, MaxY) + 0.5)
        )
    end

    local function FitToScreen()
        local View = ViewportSize()
        local Width = math.max(1, math.min(DesiredWidth, View.X - OUTER_MARGIN * 2))
        local ScreenHeight = math.max(1, math.min(HEIGHT, View.Y - OUTER_MARGIN * 2))
        Frame.Size = UDim2.fromOffset(math.floor(Width), math.floor(ScreenHeight))
        ClampPosition(Frame.Position.X.Offset, Frame.Position.Y.Offset)
    end


    local Dragging = false
    local ActiveTouch = nil
    local DragX, DragY, StartX, StartY = 0, 0, 0, 0
    Connect(Frame.InputBegan, function(Input)
        local Kind = Input.UserInputType
        if Kind ~= Enum.UserInputType.MouseButton1 and Kind ~= Enum.UserInputType.Touch then return end
        Dragging = true
        ActiveTouch = (Kind == Enum.UserInputType.Touch) and Input or nil
        DragX, DragY = Input.Position.X, Input.Position.Y
        StartX, StartY = Frame.Position.X.Offset, Frame.Position.Y.Offset
    end)

    Connect(UserInputService.InputChanged, function(Input)
        if not Dragging then return end
        if ActiveTouch then
            if Input ~= ActiveTouch then return end
        elseif Input.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end
        ClampPosition(StartX + Input.Position.X - DragX, StartY + Input.Position.Y - DragY)
    end)

    Connect(UserInputService.InputEnded, function(Input)
        if not Dragging then return end
        if ActiveTouch then
            if Input ~= ActiveTouch then return end
        elseif Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end
        Dragging = false
        ActiveTouch = nil
    end)


    local function MakeBeam(Length, Alpha, StartFraction, InitialVelocity)
        local Beam = {
            Length = Length,
            Phase = nil,
            StartFraction = StartFraction,
            Velocity = InitialVelocity,
            Parts = {},
            GlowParts = {},
        }
        for Side = 1, 4 do
            local Rotation = (Side == 1 or Side == 3) and 0 or 90

            local Glow = New("Frame", {
                Parent = Frame,
                Size = UDim2.fromOffset(1, 2),
                Position = UDim2.fromOffset(0, 0),
                BackgroundColor3 = Color3.fromRGB(235, 240, 255),
                BackgroundTransparency = 0.68,
                Visible = false,
                ZIndex = 23,
            })
            New("UIGradient", {
                Parent = Glow,
                Rotation = Rotation,
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.18, 0.72),
                    NumberSequenceKeypoint.new(0.50, 0.10),
                    NumberSequenceKeypoint.new(0.82, 0.72),
                    NumberSequenceKeypoint.new(1, 1),
                }),
            })
            local Part = New("Frame", {
                Parent = Frame,
                Size = UDim2.fromOffset(1, 1),
                Position = UDim2.fromOffset(0, 0),
                BackgroundColor3 = WHITE,
                BackgroundTransparency = Alpha,
                Visible = false,
                ZIndex = 24,
            })
            New("UIGradient", {
                Parent = Part,
                Rotation = Rotation,
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.14, 0.78),
                    NumberSequenceKeypoint.new(0.30, 0.32),
                    NumberSequenceKeypoint.new(0.50, 0),
                    NumberSequenceKeypoint.new(0.70, 0.32),
                    NumberSequenceKeypoint.new(0.86, 0.78),
                    NumberSequenceKeypoint.new(1, 1),
                }),
            })
            Beam.Parts[Side] = Part
            Beam.GlowParts[Side] = Glow
        end
        return Beam
    end


    local Beam = MakeBeam(17, 0.11, 0.04, 110)
    local LastWidth, LastHeight = 0, 0
    local function PlaceBeam(Beam, W, H)
        local P = 2 * (W + H)
        if P <= 0 then return end
        local Phase = Beam.Phase % P
        local EdgeStart = { 0, W, W + H, W + H + W }
        local EdgeEnd = { W, W + H, W + H + W, P }

        for Side = 1, 4 do
            local Part = Beam.Parts[Side]
            local Glow = Beam.GlowParts[Side]
            local Lo, Hi = nil, nil
            for Cycle = 0, 1 do
                local A = EdgeStart[Side] + Cycle * P
                local B = EdgeEnd[Side] + Cycle * P
                local OverlapStart = math.max(A, Phase)
                local OverlapEnd = math.min(B, Phase + Beam.Length)
                if OverlapEnd - OverlapStart > 0.7 then
                    Lo, Hi = OverlapStart - Cycle * P, OverlapEnd - Cycle * P
                    break
                end
            end
            if not Lo then
                Part.Visible = false
                Glow.Visible = false
            else
                local A = EdgeStart[Side]
                local Len = math.max(1, math.floor(Hi - Lo + 0.5))
                local X, Y, Width, Height
                if Side == 1 then
                    X, Y, Width, Height = Lo - A, 0, Len, 1
                elseif Side == 2 then
                    X, Y, Width, Height = W - 1, Lo - A, 1, Len
                elseif Side == 3 then
                    X, Y, Width, Height = W - (Hi - A), H - 1, Len, 1
                else
                    X, Y, Width, Height = 0, H - (Hi - A), 1, Len
                end
                local RoundedX = math.floor(X + 0.5)
                local RoundedY = math.floor(Y + 0.5)
                Part.Position = UDim2.fromOffset(RoundedX, RoundedY)
                Part.Size = UDim2.fromOffset(Width, Height)
                Part.Visible = true

                if Side == 1 then
                    Glow.Position = UDim2.fromOffset(RoundedX, 0)
                    Glow.Size = UDim2.fromOffset(Width, 2)
                elseif Side == 2 then
                    Glow.Position = UDim2.fromOffset(W - 2, RoundedY)
                    Glow.Size = UDim2.fromOffset(2, Height)
                elseif Side == 3 then
                    Glow.Position = UDim2.fromOffset(RoundedX, H - 2)
                    Glow.Size = UDim2.fromOffset(Width, 2)
                else
                    Glow.Position = UDim2.fromOffset(0, RoundedY)
                    Glow.Size = UDim2.fromOffset(2, Height)
                end
                Glow.Visible = true
            end
        end
    end

    Connect(RunService.RenderStepped, function(Delta)
        if Library.Unloaded or not Frame.Parent then return end
        local View = ViewportSize()
        if View.X ~= LastWidth or View.Y ~= LastHeight then
            LastWidth, LastHeight = View.X, View.Y
            FitToScreen()
        end
        if not Frame.Visible then return end
        local W, H = Frame.AbsoluteSize.X, Frame.AbsoluteSize.Y
        if W < 3 or H < 3 then return end
        local Perimeter = (W + H) * 2


        if Beam.Phase == nil then
            Beam.Phase = ((Beam.StartFraction or 0) % 1) * Perimeter
        end


        Delta = math.max(0, Delta)
        Beam.Phase = (Beam.Phase + Beam.Velocity * Delta) % Perimeter
        PlaceBeam(Beam, W, H)
    end)

    local WatermarkFader = Fader(Frame, false, "Window")
    Watermark.Items = { Watermark = Wrap(Frame), Text = Wrap(Label) }

    function Watermark:SetText(Text)
        Watermark.Name = tostring(Text)
        RenderText()
        FitToScreen()
    end

    function Watermark:SetSubText(Text)
        Watermark.SubName = Text and tostring(Text) or nil
        RenderText()
        FitToScreen()
    end

    function Watermark:SetVisibility(Shown)
        WatermarkFader:Set(Shown)
    end

    function Watermark:Center()
        local View = ViewportSize()
        FitToScreen()
        ClampPosition((View.X - Frame.AbsoluteSize.X) / 2, OUTER_MARGIN)
    end

    FitToScreen()
    task.defer(FitToScreen)
    Library.WatermarkObject = Watermark
    return setmetatable(Watermark, Library)
end


Library.KeybindList = function(Self, Params)
    Params = Params or { }

    local KeybindList = {
        Name = Params.Name or Params.name or "keybinds",
        Items = { },
    }

    local Frame = New("Frame", {
        Parent = Library.Holder,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 12, 0.45, 0),
        Size = UDim2.new(0, 180, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 0,
    })
    Themed(function() Frame.BackgroundColor3 = Theme.Window end)
    Outline(Frame, "Border")
    Shade(Frame, -90)
    New("UIPadding", {
        Parent = Frame,
        PaddingLeft = UDim.new(0, 5),
        PaddingRight = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 5),
    })
    Highlight(Frame, "Window", UDim2.new(0, -5, 0, 0), UDim2.new(1, 10, 0, 1))

    local Title = New("TextLabel", {
        Parent = Frame,
        RichText = true,
        Size = UDim2.new(1, 0, 0, 20),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = KeybindList.Name,
    })
    TitleGradient(Title)
    Draggable(Title, Frame)

    local Content = New("Frame", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 20),
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    })
    New("UIListLayout", { Parent = Content, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder })

    KeybindList.Items = { KeybindList = Wrap(Frame), Text = Wrap(Title), Content = Wrap(Content) }
    local ListFader = Fader(Frame, false, "Window")

    function KeybindList:SetText(Text)
        Title.Text = tostring(Text)
    end

    function KeybindList:SetVisibility(Bool)
        ListFader:Set(Bool)
    end

    function KeybindList:Center() end

    function KeybindList:Add(Name, Mode)
        local Entry = { }
        local CanBeVisible = true

        local Row = New("Frame", {
            Parent = Content,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 15),
            Visible = false,
            LayoutOrder = NextOrder(),
        })

        local NameLabel = New("TextLabel", {
            Parent = Row,
            Size = UDim2.new(1, -60, 1, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Text = tostring(Name),
        })

        local ModeLabel = New("TextLabel", {
            Parent = Row,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, 0, 0, 0),
            Size = UDim2.new(0, 60, 1, 0),
            TextXAlignment = Enum.TextXAlignment.Right,
            Text = tostring(Mode),
        })
        Themed(function() ModeLabel.TextColor3 = Theme["Element Accent"] end)

        Entry.NewKey = Wrap(Row)
        Entry.Text = Wrap(NameLabel)
        Entry.Mode = Wrap(ModeLabel)

        function Entry:SetVis(Bool)
            CanBeVisible = Bool
            if not Bool then
                Row.Visible = false
            end
        end

        function Entry:SetStatus(Bool)
            Row.Visible = CanBeVisible and Bool and true or false
        end

        function Entry:Set(NewName)
            NameLabel.Text = tostring(NewName)
        end

        function Entry:SetMode(NewMode)
            ModeLabel.Text = "[" .. tostring(NewMode) .. "]"
        end

        return Entry
    end

    Library.KeyList = KeybindList
    return setmetatable(KeybindList, Library)
end


Library.TargetHUD = function(Self, Params)
    Params = Params or { }

    local HUD = {
        Enabled = true,
        Target = nil,
        Player = nil,
        Model = nil,
        Items = { },
    }

    local Outer = New("Frame", {
        Parent = Library.Holder,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -140),
        Size = UDim2.fromOffset(295, 135),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(28, 28, 28),
        Visible = false,
    })
    Outline(Outer, "Border")
    Draggable(Outer, Outer)

    local Inner = New("Frame", {
        Parent = Outer,
        Position = UDim2.fromOffset(5, 6),
        Size = UDim2.new(1, -10, 1, -12),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
    })
    Outline(Inner)
    Shade(Inner, -90)
    Highlight(Inner, "Window")

    local Title = New("TextLabel", {
        Parent = Outer,
        Position = UDim2.fromOffset(13, 7),
        Size = UDim2.new(1, -26, 0, 20),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = Params.Name or "Target HUD",
    })
    TitleGradient(Title)

    local Avatar = New("ImageLabel", {
        Parent = Inner,
        Position = UDim2.fromOffset(8, 24),
        Size = UDim2.fromOffset(85, 85),
        BackgroundTransparency = 1,
        Image = "",
    })
    Outline(Avatar)

    local Info = New("Frame", {
        Parent = Inner,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(103, 23),
        Size = UDim2.fromOffset(170, 85),
    })
    New("UIPadding", { Parent = Info, PaddingTop = UDim.new(0, 8), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2) })
    New("UIListLayout", { Parent = Info, Padding = UDim.new(0, 1), SortOrder = Enum.SortOrder.LayoutOrder })

    local function InfoLabel(Order)
        return New("TextLabel", {
            Parent = Info,
            Size = UDim2.new(1, 0, 0, 15),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextStrokeTransparency = 1,
            LayoutOrder = Order,
        })
    end

    local UserLabel = InfoLabel(1)
    local HealthLabel = InfoLabel(2)
    local DistanceLabel = InfoLabel(3)
    local TeamLabel = InfoLabel(4)

    HUD.Items = {
        TargetHUD = Wrap(Outer),
        Avatar = Wrap(Avatar),
        User = Wrap(UserLabel),
        Health = Wrap(HealthLabel),
        Distance = Wrap(DistanceLabel),
        Team = Wrap(TeamLabel),
    }

    local Thumbnails = { }

    local function Resolve(Target)
        if type(Target) == "table" and Target.FinalPart then
            Target = Target.FinalPart
        end

        if typeof(Target) ~= "Instance" then
            return nil, nil
        end

        if Target:IsA("Player") then
            return Target, Target.Character
        end

        local Model = Target:IsA("Model") and Target or Target:FindFirstAncestorOfClass("Model")
        if not Model then
            return nil, nil
        end

        local Player = Players:GetPlayerFromCharacter(Model)
        if not Player then
            local Found = Players:FindFirstChild(Model.Name)
            Player = (Found and Found:IsA("Player")) and Found or nil
        end

        return Player, Model
    end

    local function SetAvatar(Player)
        if not Player then
            Avatar.Image = ""
            return
        end

        local UserId = Player.UserId

        if Thumbnails[UserId] then
            Avatar.Image = Thumbnails[UserId]
            return
        end

        task.spawn(function()
            local Ok, Image = pcall(function()
                return Players:GetUserThumbnailAsync(UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
            end)

            if Ok and Image then
                Thumbnails[UserId] = Image
                if HUD.ShownPlayer == Player then
                    Avatar.Image = Image
                end
            end
        end)
    end

    function HUD:SetTarget(Target)
        local Player, Model = Resolve(Target)

        HUD.Target = Target
        HUD.Player = Player
        HUD.Model = Model
    end

    function HUD:SetVisibility(Bool)
        HUD.Enabled = Bool
    end

    local Elapsed = 0

    Connect(RunService.Heartbeat, function(Delta)
        Elapsed += Delta
        if Elapsed < 0.1 then
            return
        end
        Elapsed = 0

        local Player, Model = HUD.Player, HUD.Model

        if (not Model or not Model.Parent) and Library.MenuOpen then
            Player, Model = LocalPlayer, LocalPlayer.Character
        end

        if Player ~= HUD.ShownPlayer then
            HUD.ShownPlayer = Player
            SetAvatar(Player)
        end

        Outer.Visible = HUD.Enabled and Model ~= nil and Model.Parent ~= nil

        if not Outer.Visible then
            return
        end

        local Humanoid = Model:FindFirstChildOfClass("Humanoid")
        local Health, MaxHealth = 100, 100

        if Humanoid then
            Health, MaxHealth = Humanoid.Health, math.max(Humanoid.MaxHealth, 1)
        elseif Model:GetAttribute("Health") then
            Health = Model:GetAttribute("Health")
            MaxHealth = Model:GetAttribute("MaxHealth") or 100
        end

        local Team = (Player and Player.Team and Player.Team.Name)
            or Model:GetAttribute("Team")
            or (Player and Player:GetAttribute("Team"))

        local Distance = 0
        local Character = LocalPlayer.Character
        if Character and Model.Parent then
            Distance = (Character:GetPivot().Position - Model:GetPivot().Position).Magnitude * 0.28
        end

        UserLabel.Text = "Username - " .. (Player and Player.Name or Model.Name)
        HealthLabel.Text = string.format("Health - %d%%", math.floor(Health / MaxHealth * 100 + 0.5))
        DistanceLabel.Text = string.format("Distance - %dm", math.floor(Distance + 0.5))
        TeamLabel.Text = "Team - " .. (Team and tostring(Team) or "N/A")
    end)

    return setmetatable(HUD, Library)
end


Library.InventoryViewer = function(Self, Params)
    Params = Params or { }

    local Columns, Rows = 5, 2
    local SlotSize, Gap, Pad = 85, 2, 2
    local TopOffset = 24
    local MaxSlots = Columns * Rows

    local Viewer = {
        Slots = { },
        Items = { },
    }

    local InnerWidth = Pad * 2 + Columns * SlotSize + (Columns - 1) * Gap
    local InnerHeight = TopOffset + Rows * SlotSize + (Rows - 1) * Gap + Pad * 2

    local Outer = New("Frame", {
        Parent = Library.Holder,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = Params.Position or UDim2.new(0.5, 0, 1, -140),
        Size = UDim2.fromOffset(InnerWidth + 10, InnerHeight + 12),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(28, 28, 28),
        Visible = false,
    })
    Outline(Outer, "Border")
    Draggable(Outer, Outer)

    local Inner = New("Frame", {
        Parent = Outer,
        Position = UDim2.fromOffset(5, 6),
        Size = UDim2.new(1, -10, 1, -12),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
    })
    Outline(Inner)
    Shade(Inner, -90)
    Highlight(Inner, "Window")

    local Title = New("TextLabel", {
        Parent = Outer,
        Position = UDim2.fromOffset(13, 7),
        Size = UDim2.new(1, -26, 0, 20),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = Params.Name or "Inventory",
    })
    MainGradient(Title)

    for Index = 1, MaxSlots do
        local Column = (Index - 1) % Columns
        local Row = (Index - 1) // Columns

        local Frame = New("Frame", {
            Parent = Inner,
            Position = UDim2.fromOffset(
                Pad + Column * (SlotSize + Gap),
                TopOffset + Row * (SlotSize + Gap)
            ),
            Size = UDim2.fromOffset(SlotSize, SlotSize),
            BackgroundTransparency = 0,
        })
        Themed(function() Frame.BackgroundColor3 = Theme.Background end)
        Outline(Frame)

        local Image = New("ImageLabel", {
            Parent = Frame,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 6),
            Size = UDim2.fromOffset(55, 55),
            BackgroundTransparency = 1,
            ScaleType = Enum.ScaleType.Fit,
            Image = "",
        })

        local Name = New("TextLabel", {
            Parent = Frame,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 3, 1, -3),
            Size = UDim2.new(1, -6, 0, 12),
            TextTruncate = Enum.TextTruncate.AtEnd,
            Text = "",
        })
        Themed(function() Name.TextColor3 = Theme["Dim Text"] end)

        local Number = New("TextLabel", {
            Parent = Frame,
            Position = UDim2.fromOffset(3, 2),
            Size = UDim2.fromOffset(14, 12),
            TextXAlignment = Enum.TextXAlignment.Left,
            Text = tostring(Index % 10),
        })
        Themed(function() Number.TextColor3 = Theme["Option Text"] end)

        Viewer.Slots[Index] = { Frame = Frame, Image = Image, Name = Name, Number = Number }
    end

    Viewer.Items = {
        InventoryViewer = Wrap(Outer),
        Inner = Wrap(Inner),
        Title = Wrap(Title),
        Slots = { },
    }

    for Index, Slot in Viewer.Slots do
        Viewer.Items.Slots[Index] = {
            Frame = Wrap(Slot.Frame),
            Image = Wrap(Slot.Image),
            Name = Wrap(Slot.Name),
        }
    end


    function Viewer:SetImage(Index, Image)
        local Slot = Viewer.Slots[Index]
        if not Slot then
            return
        end

        if type(Image) == "number" then
            Image = "rbxassetid://" .. Image
        end

        Slot.Image.Image = Image and tostring(Image) or ""
    end


    function Viewer:SetName(Index, Text)
        local Slot = Viewer.Slots[Index]
        if not Slot then
            return
        end

        Slot.Name.Text = Text and tostring(Text) or ""
    end


    function Viewer:SetText(Text)
        Title.Text = tostring(Text)
    end


    function Viewer:SetVisibility(Bool)
        Outer.Visible = Bool and true or false
    end


    function Viewer:Clear(Index)
        if Index then
            Viewer:SetImage(Index, nil)
            Viewer:SetName(Index, nil)
            return
        end

        for Slot = 1, MaxSlots do
            Viewer:SetImage(Slot, nil)
            Viewer:SetName(Slot, nil)
        end
    end

    return setmetatable(Viewer, Library)
end


Library.AudioPlayer = function(Self, Params)
    Params = Params or { }

    local audioPlayback = {
        title = "",
        artist = "",
        album = "",
        source = "",
        position = 0,
        duration = 0,
        isPlaying = true,
        available = true,
        Items = { },
    }

    local outer = New("Frame", {
        Parent = Library.Holder,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -140),
        Size = UDim2.fromOffset(345, 135),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(28, 28, 28),
        Visible = false,
    })
    Outline(outer, "Border")
    Draggable(outer, outer)

    local inner = New("Frame", {
        Parent = outer,
        Position = UDim2.fromOffset(5, 6),
        Size = UDim2.new(1, -10, 1, -12),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
    })
    Outline(inner)
    Shade(inner, -90)
    Highlight(inner, "Window")

    local title = New("TextLabel", {
        Parent = outer,
        Position = UDim2.fromOffset(13, 7),
        Size = UDim2.new(1, -26, 0, 20),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = Params.Name or "Audio Player",
    })
    TitleGradient(title)

    local tag = New("TextLabel", {
        Parent = outer,
        Position = UDim2.fromOffset(13, 7),
        Size = UDim2.new(1, -26, 0, 20),
        TextXAlignment = Enum.TextXAlignment.Right,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Text = "",
    })
    Themed(function() tag.TextColor3 = Theme["Dim Text"] end)

    local cover = New("ImageLabel", {
        Parent = inner,
        Position = UDim2.fromOffset(8, 24),
        Size = UDim2.fromOffset(85, 85),
        BackgroundTransparency = 1,
        Image = "",
    })
    Outline(cover)

    local info = New("Frame", {
        Parent = inner,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(103, 23),
        Size = UDim2.new(1, -111, 0, 85),
    })
    New("UIPadding", { Parent = info, PaddingTop = UDim.new(0, 8), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2) })
    New("UIListLayout", { Parent = info, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })

    local function infoLabel(order)
        return New("TextLabel", {
            Parent = info,
            Size = UDim2.new(1, 0, 0, 15),
            RichText = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextStrokeTransparency = 1,
            LayoutOrder = order,
        })
    end

    local function escape(text)
        return (tostring(text):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
    end

    local function colored(key, text)
        return string.format('<font color="%s">%s</font>', ToRichColor(Theme[key]), text)
    end

    local function formatTime(ms)
        local totalSeconds = math.max(0, math.floor((tonumber(ms) or 0) / 1000))
        local hours = math.floor(totalSeconds / 3600)
        local minutes = math.floor((totalSeconds % 3600) / 60)
        local seconds = totalSeconds % 60

        if hours > 0 then
            return string.format("%d:%02d:%02d", hours, minutes, seconds)
        end

        return string.format("%d:%02d", minutes, seconds)
    end

    local songTitle = infoLabel(1)
    local songArtist = infoLabel(2)
    local songAlbum = infoLabel(3)

    local bar = New("Frame", {
        Parent = info,
        Size = UDim2.new(1, 0, 0, 13),
        BackgroundTransparency = 0,
        LayoutOrder = 4,
    })
    Themed(function() bar.BackgroundColor3 = Theme.Hover end)
    Outline(bar)

    local fill = New("Frame", {
        Parent = bar,
        Size = UDim2.fromScale(0, 1),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.new(1, 1, 1),
        ClipsDescendants = true,
    })

    local fillGradient = New("UIGradient", { Parent = fill })
    Themed(function()
        fillGradient.Color = ColorSequence.new(Theme["Element Accent"], Theme.Accent)
    end)

    local sheen = New("Frame", {
        Parent = fill,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.new(1, 1, 1),
        ZIndex = 2,
    })
    New("UIGradient", {
        Parent = sheen,
        Rotation = 90,
        Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0.7),
            NumberSequenceKeypoint.new(1, 1),
        },
    })

    New("UIShadow", { Parent = fill })

    local elapsedLabel = New("TextLabel", {
        Parent = bar,
        Position = UDim2.fromOffset(4, 0),
        Size = UDim2.new(0.5, -4, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 3,
        Text = "0:00",
    })

    local totalLabel = New("TextLabel", {
        Parent = bar,
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.new(0.5, -4, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 3,
        Text = "0:00",
    })

    audioPlayback.Items = {
        AudioPlayer = Wrap(outer),
        Cover = Wrap(cover),
        Title = Wrap(songTitle),
        Artist = Wrap(songArtist),
        Album = Wrap(songAlbum),
        Source = Wrap(tag),
        Bar = Wrap(bar),
        Fill = Wrap(fill),
        Elapsed = Wrap(elapsedLabel),
        Total = Wrap(totalLabel),
    }

    local function renderText()
        local available = audioPlayback.available
        local titleText = (available and audioPlayback.title ~= "") and audioPlayback.title or "Nothing playing"
        local artistText = (available and audioPlayback.artist ~= "") and audioPlayback.artist or "N/A"
        local albumText = (available and audioPlayback.album ~= "") and audioPlayback.album or "N/A"

        songTitle.Text = colored("Text", escape(titleText))
        songArtist.Text = colored("Option Text", "Artist - ") .. colored("Dim Text", escape(artistText))
        songAlbum.Text = colored("Option Text", "Album - ") .. colored("Dim Text", escape(albumText))

        local source = audioPlayback.source
        if audioPlayback.isPlaying == false then
            source = source ~= "" and (source .. " [paused]") or "[paused]"
        end
        tag.Text = source
    end

    local function updateBar(instant)
        local percent = (audioPlayback.duration > 0) and math.clamp(audioPlayback.position / audioPlayback.duration, 0, 1) or 0

        if instant then
            fill.Size = UDim2.fromScale(percent, 1)
        else
            Tween(fill, { Size = UDim2.fromScale(percent, 1) }, 0.12)
        end

        elapsedLabel.Text = formatTime(audioPlayback.position)
        totalLabel.Text = formatTime(audioPlayback.duration)
    end


    Themed(renderText)

    function audioPlayback:SetText(layer, text)
        text = tostring(text or "")

        if layer == 1 then
            audioPlayback.title = text
        elseif layer == 2 then
            audioPlayback.artist = text
        elseif layer == 4 then
            audioPlayback.album = text
        end

        renderText()
    end

    function audioPlayback:SetImage(id)
        cover.Image = tostring(id or "")
    end

    function audioPlayback:SetVisibility(bool)
        outer.Visible = bool
    end


    function audioPlayback:SetTime(current, total)
        if total ~= nil then
            audioPlayback.duration = tonumber(total) or 0
        end

        audioPlayback.position = math.clamp(tonumber(current) or 0, 0, math.max(audioPlayback.duration, 0))
        updateBar()
    end

    function audioPlayback:SetDuration(total)
        audioPlayback.duration = tonumber(total) or 0
        updateBar(true)
    end


    function audioPlayback:Update(data)
        local playback = data and (data.playback or data)

        if type(playback) ~= "table" then
            return
        end

        local previousTitle = audioPlayback.title
        local previousDuration = audioPlayback.duration

        audioPlayback.available = playback.available ~= false
        audioPlayback.isPlaying = playback.is_playing ~= false
        audioPlayback.title = tostring(playback.title or "")
        audioPlayback.artist = tostring(playback.artist or "")
        audioPlayback.album = tostring(playback.album or "")
        audioPlayback.source = tostring(playback.source or "")
        audioPlayback.duration = tonumber(playback.duration_ms) or 0
        audioPlayback.position = math.clamp(tonumber(playback.position_ms) or 0, 0, math.max(audioPlayback.duration, 0))

        renderText()


        local trackChanged = audioPlayback.title ~= previousTitle or audioPlayback.duration ~= previousDuration
        updateBar(trackChanged)
    end

    renderText()
    updateBar(true)

    return setmetatable(audioPlayback, Library)
end


Library.EspPreview = function(Self, Params)
    Params = Params or { }

    local WindowSize = (Self.Size and Self.Size.X.Offset > 0) and Self.Size or UDim2.fromOffset(498, 598)

    local Preview = {
        Enabled = true,
        Items = { },
    }

    local Frame = New("Frame", {
        Parent = Library.Holder,
        Size = UDim2.fromOffset(275, 325),
        Position = UDim2.new(0.5, -WindowSize.X.Offset / 2 - 14 - 275, 0.5, -WindowSize.Y.Offset / 2),
        BackgroundTransparency = 0,
    })
    Themed(function() Frame.BackgroundColor3 = Theme.Window end)
    Outline(Frame)
    New("UIPadding", { Parent = Frame, PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5) })
    Highlight(Frame, "Window", UDim2.new(0, -5, 0, 0), UDim2.new(1, 10, 0, 1))

    local Title = New("TextLabel", {
        Parent = Frame,
        Size = UDim2.new(1, 0, 0, 20),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = Params.Name or "Esp Preview",
    })
    TitleGradient(Title)
    Draggable(Title, Frame)

    local Inner = New("Frame", {
        Parent = Frame,
        Position = UDim2.fromOffset(0, 24),
        Size = UDim2.new(1, 0, 1, -29),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        ClipsDescendants = true,
    })
    Outline(Inner, "Border")

    local Image = New("ImageLabel", {
        Parent = Inner,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Fit,
        Image = Params.Image or "rbxassetid://89494888821949",
    })

    Preview.Items = { Window = Wrap(Frame), Image = Wrap(Image) }

    Frame.Visible = Library.MenuOpen
    local Entry = { Frame = Frame, Enabled = true, Fader = Fader(Frame, true, "Window") }
    table.insert(Library.Floating, Entry)

    function Preview:SetImage(Id)
        Image.Image = tostring(Id)
    end

    function Preview:SetVisibility(Bool)
        Entry.Enabled = Bool
        Entry.Fader:Set(Bool and Library.MenuOpen)
    end

    return setmetatable(Preview, Library)
end


Library.Window = function(Self, Params)
    Params = Params or { }

    local Window = {
        Name = Params.Name or Params.name or UI_TITLE,
        Rank = Params.Rank or Params.rank,
        Size = Params.Size or Params.size or UDim2.fromOffset(566, 760),

        IsOpen = true,
        Pages = { },
        Current = nil,
        Items = { },
    }
    Window.Window = Window


    local Camera = workspace.CurrentCamera
    local Viewport = Camera and Camera.ViewportSize
    if Viewport and Viewport.X > 320 and Viewport.Y > 420 then
        local RequestedWidth = Window.Size.X.Offset
        local RequestedHeight = Window.Size.Y.Offset
        if Window.Size.X.Scale == 0 and Window.Size.Y.Scale == 0 then
            Window.Size = UDim2.fromOffset(
                math.min(RequestedWidth, math.max(320, Viewport.X - 24)),
                math.min(RequestedHeight, math.max(400, Viewport.Y - 30))
            )
        end
    end

    local Plain = (Window.Name:gsub("<[^>]->", ""))
    Library.Name = Plain:match("^%s*(.-)%s*|") or Plain


    local Shell = New("Frame", {
        Parent = Library.Holder,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = Window.Size,
        BackgroundTransparency = 1,
        ClipsDescendants = true,
    })
    local Main = New("Frame", {
        Parent = Shell,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = Window.Size,
        BackgroundTransparency = 0,
    })
    Themed(function() Main.BackgroundColor3 = Theme.Background end)
    New("UIPadding", {
        Parent = Main,
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
    })
    New("UIShadow", { Parent = Main })
    Outline(Main, "Border")


    local SparkWidth = 84
    local TopTrack = New("Frame", {
        Parent = Shell,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(1, 0, 0, 2),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 15,
    })
    local TopSpark = New("Frame", {
        Parent = TopTrack,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.fromOffset(SparkWidth, 2),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = 16,
    })
    New("UIGradient", {
        Parent = TopSpark,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.16, 0.92),
            NumberSequenceKeypoint.new(0.34, 0.43),
            NumberSequenceKeypoint.new(0.50, 0.05),
            NumberSequenceKeypoint.new(0.66, 0.43),
            NumberSequenceKeypoint.new(0.84, 0.92),
            NumberSequenceKeypoint.new(1, 1),
        }),
    })
    local SparkMotion = TweenService:Create(TopSpark,
        TweenInfo.new(1.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        { Position = UDim2.new(1, -SparkWidth, 0, 0) })
    SparkMotion:Play()
    Library.WindowAccentMotion = SparkMotion

    local Title = New("TextLabel", {
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 30),
        RichText = false,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextStrokeTransparency = 1,
        Text = Window.Name,
    })
    Draggable(Title, Shell)

    local Content = New("Frame", {
        Parent = Main,
        Position = UDim2.fromOffset(0, 30),
        Size = UDim2.new(1, 0, 1, -30),
        BackgroundTransparency = 0,
    })
    Themed(function() Content.BackgroundColor3 = Theme.Background end)
    Outline(Content)

    local TabBar = New("Frame", {
        Parent = Content,
        Position = UDim2.fromOffset(1, 1),
        Size = UDim2.new(1, -2, 0, 24),
        BackgroundTransparency = 0,
        ZIndex = 2,
    })
    Themed(function() TabBar.BackgroundColor3 = Theme.Background end)
    New("UIListLayout", {
        Parent = TabBar,
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 1),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    local TabStroke = New("UIStroke", {
        Parent = TabBar,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        LineJoinMode = Enum.LineJoinMode.Miter,
        BorderStrokePosition = StrokeInner,
    })
    Themed(function() TabStroke.Color = Theme.Outline end)
    Shade(TabBar, 90)

    local PagesHolder = New("Frame", {
        Parent = Content,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(10, 35),
        Size = UDim2.new(1, -20, 1, -47),
    })


    Window.Items = {
        MainFrame = Wrap(Main),
        WindowShell = Wrap(Shell),
        Title = Wrap(Title),
        Content = Wrap(PagesHolder),
        Pages = Wrap(TabBar),
    }


    Window.Fader = Fader(Main, false, "Window")
    local RestPosition = Shell.Position
    local FadeGeneration = 0

    local function AnimateEdge(Show, Instant)
        if Instant then
            TopSpark.BackgroundTransparency = Show and 0 or 1
        else
            Smooth(TopSpark, "EdgeFade", {
                BackgroundTransparency = Show and 0 or 1,
            }, 0.20, Enum.EasingStyle.Sine)
        end
    end

    function Window:SetOpen(Bool)
        Bool = Bool and true or false
        if Bool == Window.IsOpen then return end
        if Drag then EndDrag() end
        SettleLanding()

        FadeGeneration += 1
        local Generation = FadeGeneration
        Window.IsOpen = Bool
        Library.MenuOpen = Bool
        Library:CloseAll()
        if Library.HoverHelp then Library.HoverHelp:Hide() end
        for _, Page in Window.Pages do Page.Fader:Finish() end

        if Bool then
            Shell.Visible = true
            Main.Visible = true
        end


        Window.Fader:Set(Bool)
        AnimateEdge(Bool, false)

        if not Bool then
            local ActiveFade = Window.Fader.Tween
            if ActiveFade then
                ActiveFade.Completed:Connect(function(State)
                    if Generation == FadeGeneration and not Window.IsOpen
                        and State == Enum.PlaybackState.Completed then
                        Shell.Visible = false
                    end
                end)
            end
        end

        for _, Entry in Library.Floating do
            Entry.Fader:Set(Bool and Entry.Enabled)
        end
        Library:UpdateEffects()
    end

    function Window:PlayIntro()
        FadeGeneration += 1
        Shell.Size = Window.Size
        Shell.Visible = true
        Main.Visible = true
        Window.IsOpen = true
        Library.MenuOpen = true


        Window.Fader.Open = false
        AnimateEdge(false, true)
        Window.Fader:Set(true)
        AnimateEdge(true, false)
        Library:UpdateEffects()
    end

    function Window:Center()
        Shell.AnchorPoint = Vector2.new(0.5, 0.5)
        RestPosition = UDim2.fromScale(0.5, 0.5)
        Shell.Position = RestPosition
    end

    function Window:SetText(Text)
        Title.Text = tostring(Text)
    end

    Connect(UserInputService.InputBegan, function(Input)
        if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
            if UserInputService:GetFocusedTextBox() then
                return
            end

            Window:SetOpen(not Window.IsOpen)
        end
    end)

    Library.WindowObject = Window
    Library:UpdateEffects()
    return setmetatable(Window, Library)
end


Library.CreateWindow = Library.Window


Library.Page = function(Self, Params)
    Params = Params or { }

    local Window = Self.Window or Self

    local Page = {
        Name = Params.Name or Params.name or "Page",
        Window = Window,
        Columns = { },
        ColumnsData = { },
        Items = { },
    }
    Page.Page = Page

    local Tab = New("TextButton", {
        Parent = Window.Items.Pages.Instance,
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        Text = Page.Name,
        LayoutOrder = #Window.Pages + 1,
        BackgroundTransparency = 1,
    })
    local TabLine = New("Frame", {
        Parent = Tab,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, 0),
        Size = UDim2.new(0, 0, 0, 2),
        BackgroundTransparency = 0,
    })
    Themed(function() TabLine.BackgroundColor3 = Theme["Element Accent"] end)
    New("UIPadding", { Parent = Tab, PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) })
    New("UIStroke", {
        Parent = Tab,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Color3.new(0, 0, 0),
        BorderOffset = UDim.new(0, -2),
    })

    local Holder = New("Frame", {
        Parent = Window.Items.Content.Instance,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Visible = false,
    })

    local function Column(Index)
        local Scroll = New("ScrollingFrame", {
            Parent = Holder,
            BackgroundTransparency = 1,
            Position = Index == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0.5, 5, 0, 0),
            Size = UDim2.new(0.5, -5, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollBarThickness = 0,
            Active = true,
        })

        Connect(Scroll:GetPropertyChangedSignal("CanvasPosition"), function()
            Library:CloseAll()
        end)

        local Data = {
            Scroll = Scroll,
            Holder = Holder,
            Page = Page,
            Items = { },
        }

        function Data:Layout(Instant, Snap)
            local Y = 2

            for _, Item in Data.Items do
                Item.Y = Y

                if not Item.Hidden then
                    if Item.State ~= "Landing" then
                        Glide(Item, "Position", { Position = UDim2.fromOffset(2, Y) }, Instant or Item == Snap)
                    end

                    Y += Item.Height + 8
                end
            end

            Scroll.CanvasSize = UDim2.fromOffset(0, math.max(Y - 6, 0))
        end

        return Data
    end

    local Left, Right = Column(1), Column(2)
    Page.Columns[1] = Left
    Page.Columns[2] = Right
    Page.ColumnsData[1] = Left.Scroll
    Page.ColumnsData[2] = Right.Scroll
    Page.Fader = Fader(Holder)

    Page.Items = {
        Inactive = Wrap(Tab),
        Text = Wrap(Tab),
        Page = Wrap(Holder),
        LeftColumn = Wrap(Left.Scroll),
        RightColumn = Wrap(Right.Scroll),
    }

    local function Paint(Snap)
        local Active = Window.Current == Page
        local TargetText = Active and Theme["Element Accent"] or Theme["Inactive Text"]
        local TargetLine = Active and UDim2.new(1, -10, 0, 2) or UDim2.new(0, 0, 0, 2)
        if Snap then
            Tab.TextColor3 = TargetText
            Tab.BackgroundTransparency = Active and 0.84 or 1
            TabLine.Size = TargetLine
        else
            Smooth(Tab, "ActiveColor", {
                TextColor3 = TargetText,
                BackgroundTransparency = Active and 0.84 or 1,
            }, 0.34)
            Smooth(TabLine, "ActiveLine", { Size = TargetLine }, 0.36)
        end
    end
    Page.Paint = Paint
    Themed(function() Paint(true) end)

    Connect(Tab.MouseEnter, function()
        if Window.Current ~= Page then
            Tween(Tab, { TextColor3 = Theme["Dim Text"] })
        end
    end)

    Connect(Tab.MouseLeave, function()
        Tween(Tab, { TextColor3 = Window.Current == Page and Theme["Element Accent"] or Theme["Inactive Text"] })
    end)

    function Page:Turn()
        local Old = Window.Current

        if Old == Page or Window.Fader.Tween or Drag then
            return
        end

        SettleLanding()
        Library:CloseAll()
        if Library.HoverHelp then Library.HoverHelp:Hide() end
        Window.Current = Page

        if Old then
            Old.Fader:Set(false)
            Old.Paint()
        end


        Holder.Position = UDim2.fromOffset(0, 0)
        Page.Fader:Set(true)
        Paint()
    end

    Connect(Tab.MouseButton1Down, function()
        Page:Turn()
    end)

    table.insert(Window.Pages, Page)

    if #Window.Pages == 1 then
        Page:Turn()
    end

    return setmetatable(Page, Library)
end


Library.Section = function(Self, Params)
    Params = Params or { }

    local Side = Params.Side or Params.side or 1
    if type(Side) == "string" then
        Side = Side:lower() == "right" and 2 or 1
    end
    Side = math.clamp(Side, 1, 2)

    local Home = Self.Columns[Side]

    local Section = {
        Name = Params.Name or Params.name or "Section",
        Side = Side,

        Window = Self.Window,
        Page = Self,
        Column = Home,

        State = "Docked",
        Height = 42,
        Y = 0,
        Hidden = false,
        FloatSize = nil,
        Born = os.clock(),
        Tweens = { },
        Items = { },
    }
    Section.Section = Section

    local Frame = New("Frame", {
        Parent = Home.Scroll,
        Size = UDim2.new(1, -4, 0, Section.Height),
        BackgroundTransparency = 0,
    })
    Themed(function() Frame.BackgroundColor3 = Theme.Background end)
    Outline(Frame, "Outline", true)
    Shade(Frame, 90)

    local Accent = Highlight(Frame, "Background")
    Accent.Visible = false

    local Shadow = New("UIShadow", { })

    local Handle = New("Frame", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 28),
    })

    local Title = New("TextLabel", {
        Parent = Handle,
        Position = UDim2.fromOffset(12, 10),
        Size = UDim2.new(1, -24, 0, 12),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = Section.Name,
    })
    TitleGradient(Title)

    local Body = New("ScrollingFrame", {
        Parent = Frame,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(10, 28),
        Size = UDim2.new(1, -20, 1, -38),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollingEnabled = false,
        ScrollBarThickness = 0,
    })

    FixedScrollbar(Body, Frame, 9, 28, 10)
    New("UIPadding", {
        Parent = Body,
        PaddingTop = UDim.new(0, 2),
        PaddingBottom = UDim.new(0, 2),
        PaddingLeft = UDim.new(0, 2),
        PaddingRight = UDim.new(0, 2),
    })
    local List = New("UIListLayout", { Parent = Body, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder })

    local Grip = New("TextButton", {
        Parent = Frame,
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -3, 1, -3),
        Size = UDim2.fromOffset(8, 8),
        BackgroundTransparency = 0,
        ZIndex = 5,
        Visible = false,
    })
    Themed(function() Grip.BackgroundColor3 = Theme["Element Accent"] end)
    New("UIGradient", {
        Parent = Grip,
        Rotation = 45,
        Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.5, 1),
            NumberSequenceKeypoint.new(0.51, 0),
            NumberSequenceKeypoint.new(1, 0),
        }
    })

    Section.Frame = Frame
    Section.Container = Body
    Section.Fader = Fader(Frame, false, "Window")
    Section.Items = {
        Section = Wrap(Frame),
        Content = Wrap(Body),
        Text = Wrap(Title),
        Handle = Wrap(Handle),
        Grip = Wrap(Grip),
    }

    local Entry = { Frame = Frame, Enabled = true, Fader = Section.Fader }

    local function SetState(State)
        local Loose = State ~= "Docked"
        local Floating = State == "Floating"
        local Index = table.find(Library.Floating, Entry)

        Section.State = State
        Accent.Visible = Loose
        Grip.Visible = Floating
        Body.ScrollingEnabled = Floating
        Library.ShadowWanted[Shadow] = Loose
        Shadow.Parent = Loose and Frame or nil

        if Floating and not Index then
            table.insert(Library.Floating, Entry)
        elseif Index and not Floating then
            table.remove(Library.Floating, Index)
        end
    end

    local function Measure()
        local Content = List.AbsoluteContentSize.Y

        Section.Height = Content + 42
        Body.CanvasSize = UDim2.fromOffset(0, Content + 4)

        if Section.State ~= "Docked" then
            return
        end

        local Instant = os.clock() - Section.Born < 1 or not Section.Column.Holder.Visible

        local FollowMotion = Section.NestedMotionActive == true
        Glide(Section, "Size", { Size = UDim2.new(1, -4, 0, Section.Height) }, Instant or FollowMotion)
        Section.Column:Layout(Instant or FollowMotion)
    end

    function Section:SetText(Text)
        Title.Text = tostring(Text)
    end

    function Section:SetVisibility(Bool)
        Section.Hidden = not Bool
        Entry.Enabled = Bool

        if Section.State == "Floating" then
            Section.Fader:Set(Bool and Library.MenuOpen)
        else
            Frame.Visible = Bool
        end

        if Section.Column then
            Section.Column:Layout()
        end
    end

    function Section:Lift()
        local Position = Frame.AbsolutePosition - Library.DragHolder.AbsolutePosition
        local Size = Frame.AbsoluteSize

        SetState("Dragging")
        Section.Column = nil
        Frame.Parent = Library.DragHolder

        Glide(Section, "Position", { Position = UDim2.fromOffset(Position.X, Position.Y) }, true)
        Glide(Section, "Size", { Size = UDim2.fromOffset(Size.X, Size.Y) }, true)
    end

    function Section:Settle()
        if Section.State ~= "Landing" then
            return
        end

        Library.Landing[Section] = nil
        SetState("Docked")

        Frame.Parent = Section.Column.Scroll
        Frame.ZIndex = 1

        Glide(Section, "Position", { Position = UDim2.fromOffset(2, Section.Y) }, true)
        Glide(Section, "Size", { Size = UDim2.new(1, -4, 0, Section.Height) }, true)
    end

    function Section:Dock(Target, Index)
        local Scroll = Target.Scroll
        local Origin = Library.DragHolder.AbsolutePosition

        Index = math.clamp(Index or #Target.Items + 1, 1, #Target.Items + 1)
        table.insert(Target.Items, Index, Section)

        Section.Column = Target
        Section.Page = Target.Page
        Section.Side = table.find(Target.Page.Columns, Target)
        Library.Landing[Section] = true

        SetState("Landing")
        Body.CanvasPosition = Vector2.zero
        Target:Layout()

        local Goal = Scroll.AbsolutePosition - Scroll.CanvasPosition - Origin + Vector2.new(2, Section.Y)

        Glide(Section, "Size", { Size = UDim2.fromOffset(Scroll.AbsoluteSize.X - 4, Section.Height) })
        Glide(Section, "Position", { Position = UDim2.fromOffset(Goal.X, Goal.Y) }).Completed:Connect(function(State)
            if State == Enum.PlaybackState.Completed then
                Section:Settle()
            end
        end)
    end

    function Section:Float()
        local Position = Frame.AbsolutePosition - Library.Holder.AbsolutePosition
        local Size = Frame.AbsoluteSize
        local Screen = Library.Holder.AbsoluteSize

        Section.FloatSize = Section.FloatSize or Vector2.new(Size.X, math.min(Size.Y, 420))

        local Width, Height = Section.FloatSize.X, Section.FloatSize.Y
        local Goal = Vector2.new(
            math.clamp(Position.X, 0, math.max(Screen.X - Width, 0)),
            math.clamp(Position.Y, 0, math.max(Screen.Y - Height, 0))
        )

        SetState("Floating")
        Section.Column = nil
        Frame.Parent = Library.Holder
        Frame.ZIndex = NextOrder() + 1

        Glide(Section, "Position", { Position = UDim2.fromOffset(Position.X, Position.Y) }, true)
        Glide(Section, "Position", { Position = UDim2.fromOffset(Goal.X, Goal.Y) })
        Glide(Section, "Size", { Size = UDim2.fromOffset(Width, Height) })
    end

    local Pending = nil
    local Resizing = nil

    Connect(Handle.InputBegan, function(Input)
        if not IsClick(Input) or not CanDrag() then
            return
        end

        if Section.State == "Floating" then
            Frame.ZIndex = NextOrder() + 1
        end

        if Section.State == "Floating" or Section.State == "Docked" then
            Pending = MouseAbs()
        end
    end)

    Connect(Grip.InputBegan, function(Input)
        if IsClick(Input) and Section.State == "Floating" then
            Resizing = { Mouse = MouseAbs(), Size = Frame.AbsoluteSize }
            Frame.ZIndex = NextOrder() + 1
        end
    end)

    Connect(UserInputService.InputChanged, function(Input)
        if not IsMove(Input) then
            return
        end

        local Mouse = MouseAbs()

        if Pending and (Mouse - Pending).Magnitude > 4 then
            Pending = nil
            BeginDrag(Section)
        elseif Resizing then
            local Screen = Library.Holder.AbsoluteSize
            local Delta = Mouse - Resizing.Mouse
            local Width = math.clamp(Resizing.Size.X + Delta.X, 150, math.max(Screen.X, 150))
            local Height = math.clamp(Resizing.Size.Y + Delta.Y, 60, math.max(Screen.Y, 60))

            Section.FloatSize = Vector2.new(Width, Height)
            Glide(Section, "Size", { Size = UDim2.fromOffset(Width, Height) }, true)
        end
    end)

    Connect(UserInputService.InputEnded, function(Input)
        if IsClick(Input) then
            Pending = nil
            Resizing = nil
        end
    end)

    Connect(Body:GetPropertyChangedSignal("CanvasPosition"), function()
        Library:CloseAll()
    end)

    Connect(List:GetPropertyChangedSignal("AbsoluteContentSize"), Measure)

    table.insert(Home.Items, Section)
    Home:Layout(true)
    Measure()

    return setmetatable(Section, Library)
end


Library.Toggle = function(Self, Params)
    Params = Params or { }

    local Toggle = {
        Name = Params.Name or Params.name or "Toggle",
        Flag = Params.Flag or Params.flag or Params.Name or Params.name or ("toggle_" .. NextOrder()),
        Default = Params.Default or Params.default or false,
        Callback = Params.Callback or Params.callback or function() end,
        Description = Params.Description or Params.description or Params.Comment or Params.comment,

        Window = Self.Window,
        Page = Self.Page,
        Section = Self.Section or Self,

        Value = false,
        Items = { },
        SettingsItem = nil,
    }

    local Root = New("Frame", {
        Parent = Self.Container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = NextOrder(),
    })
    New("UIListLayout", { Parent = Root, Padding = UDim.new(0, 0), SortOrder = Enum.SortOrder.LayoutOrder })

    local Row = New("TextButton", {
        Parent = Root,
        Size = UDim2.new(1, 0, 0, 16),
        LayoutOrder = 1,
    })


    local Box = New("Frame", {
        Parent = Row,
        Name = "ToggleCircle",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.fromOffset(12, 12),
        BackgroundTransparency = 0,
        BackgroundColor3 = Theme.Background,
    })
    Corner(Box, 100)
    local CircleOutline = New("UIStroke", {
        Parent = Box,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        LineJoinMode = Enum.LineJoinMode.Round,
        Thickness = 0.65,
        Color = Color3.fromRGB(170, 170, 170),
    })


    local Label = New("TextLabel", {
        Parent = Row,
        Position = UDim2.fromOffset(16, 0),
        Size = UDim2.new(1, -16, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = Toggle.Name,
    })

    local Sub = New("Frame", {
        Parent = Row,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
    })
    New("UIListLayout", {
        Parent = Sub,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    AttachHoverHelp(Row, Toggle.Description, Toggle.Page)

    Toggle.Items = {
        Toggle = Wrap(Root),
        Button = Wrap(Row),
        Indicator = Wrap(Box),
        Text = Wrap(Label),
        SubElements = Wrap(Sub),
    }

    local Hovered = false

    local function Colors()
        local Accent = Theme["Element Accent"]
        local OutlineColor = Toggle.Value and Accent
            or (Hovered and Color3.fromRGB(215, 215, 215) or Color3.fromRGB(158, 158, 158))
        local FillColor = Toggle.Value and Accent or Theme.Background
        local TextColor = Toggle.Value and Theme.Text or Theme["Dim Text"]
        return OutlineColor, FillColor, TextColor
    end

    Themed(function()
        local OutlineColor, FillColor, TextColor = Colors()
        CircleOutline.Color = OutlineColor
        Box.BackgroundColor3 = FillColor
        Label.TextColor3 = TextColor
    end)

    local function Animate()
        local OutlineColor, FillColor, TextColor = Colors()
        Smooth(CircleOutline, "ToggleRing", { Color = OutlineColor }, 0.12, Enum.EasingStyle.Sine)
        Smooth(Box, "ToggleFill", { BackgroundColor3 = FillColor }, 0.12, Enum.EasingStyle.Sine)
        Smooth(Label, "ToggleText", { TextColor3 = TextColor }, 0.10, Enum.EasingStyle.Sine)
    end

    Connect(Row.MouseEnter, function() Hovered = true Animate() end)
    Connect(Row.MouseLeave, function() Hovered = false Animate() end)

    function Toggle:Set(Bool)
        Toggle.Value = Bool and true or false

        if Toggle.Initialized then
            Animate()
        else

            local OutlineColor, FillColor, TextColor = Colors()
            CircleOutline.Color = OutlineColor
            Box.BackgroundColor3 = FillColor
            Label.TextColor3 = TextColor
            Toggle.Initialized = true
        end

        if Toggle.SettingsItem then
            Toggle.SettingsItem:SetOpen(Toggle.Value)
        end

        Flags[Toggle.Flag] = Toggle.Value
        SafeCall(Toggle.Callback, Toggle.Value)
    end

    function Toggle:SetVisibility(Bool)
        Root.Visible = Bool
    end

    function Toggle:SetText(Text)
        Label.Text = tostring(Text)
    end

    function Toggle:Colorpicker(Data)
        Data = Data or { }

        return (Library:CreateColorpicker({
            Parent = Sub,
            Section = Toggle.Section,
            Flag = Data.Flag or Data.flag or Data.Name or Data.name or (Toggle.Flag .. "_color"),
            Default = Data.Default or Data.default or Color3.new(1, 1, 1),
            Alpha = Data.Alpha or Data.alpha or 0,
            Callback = Data.Callback or Data.callback or function() end,
        }))
    end

    function Toggle:Keybind(Data)
        Data = Data or { }

        return (Library:CreateKeybind({
            Parent = Sub,
            Name = Data.Name or Data.name or Toggle.Name,
            Section = Toggle.Section,
            Toggle = Toggle,
            Flag = Data.Flag or Data.flag or Data.Name or Data.name or (Toggle.Flag .. "_bind"),
            Default = Data.Default or Data.default,
            Mode = Data.Mode or Data.mode or "Toggle",
            ShowInList = Data.ShowInList,
            Callback = Data.Callback or Data.callback or function() end,
        }))
    end

    function Toggle:Settings()


        local Clip = New("Frame", {
            Parent = Root,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            ClipsDescendants = true,
            Visible = Toggle.Value,
            LayoutOrder = 2,
        })
        local SETTINGS_TOP_GAP = 6
        local Content = New("Frame", {
            Parent = Clip,
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, SETTINGS_TOP_GAP),
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = Toggle.Value,
        })
        New("UIPadding", { Parent = Content, PaddingLeft = UDim.new(0, 17) })
        local Layout = New("UIListLayout", {
            Parent = Content,
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })
        local Reveal = Fader(Content, false, "Window")

        local Settings = {
            IsOpen = Toggle.Value,
            Container = Content,
            Window = Toggle.Window,
            Page = Toggle.Page,
            Items = { Content = Wrap(Content), Clip = Wrap(Clip) },
            Motion = 0,
        }
        Settings.Section = Settings

        local function Height()


            return math.max(0, math.ceil(Layout.AbsoluteContentSize.Y) + 3 + SETTINGS_TOP_GAP)
        end

        local function MarkSectionMoving()
            local ParentSection = Toggle.Section
            if ParentSection and ParentSection.Frame then
                ParentSection.NestedMotionActive = true
                local This = Settings.Motion
                task.delay(0.56, function()
                    if Settings.Motion == This then
                        ParentSection.NestedMotionActive = false
                    end
                end)
            end
        end

        function Settings:SetOpen(Bool)
            Bool = Bool and true or false
            if Bool == Settings.IsOpen then return end
            Settings.IsOpen = Bool
            Settings.Motion += 1
            local Generation = Settings.Motion
            MarkSectionMoving()

            if Bool then
                Clip.Visible = true
                Content.Visible = true
                Reveal:Set(true)
                task.defer(function()
                    if Settings.Motion ~= Generation or not Settings.IsOpen then return end
                    local Target = Height()
                    if Target <= 3 then

                        task.wait()
                        if Settings.Motion ~= Generation then return end
                        Target = Height()
                    end
                    Smooth(Clip, "SettingsHeight", {
                        Size = UDim2.new(1, 0, 0, Target)
                    }, 0.38)
                end)
            else

                Library:CloseAll()
                Reveal:Set(false)
                local Motion = Smooth(Clip, "SettingsHeight", {
                    Size = UDim2.new(1, 0, 0, 0)
                }, 0.34)
                Motion.Completed:Connect(function(Status)
                    if Status == Enum.PlaybackState.Completed
                        and Settings.Motion == Generation and not Settings.IsOpen then
                        Clip.Visible = false
                    end
                end)
            end
        end

        Connect(Layout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
            if Settings.IsOpen and Settings.Motion > 0 then

                Smooth(Clip, "SettingsHeight", {
                    Size = UDim2.new(1, 0, 0, Height())
                }, 0.28)
            end
        end)

        if Toggle.Value then
            task.defer(function()
                if Settings.IsOpen then
                    Clip.Size = UDim2.new(1, 0, 0, Height())
                end
            end)
        end

        Toggle.SettingsItem = Settings
        return setmetatable(Settings, Library)
    end

    Connect(Row.MouseButton1Click, function()
        Toggle:Set(not Toggle.Value)
    end)

    Toggle:Set(Toggle.Default)

    SetFlags[Toggle.Flag] = function(Value)
        Toggle:Set(Value)
    end

    return setmetatable(Toggle, Library)
end


Library.Button = function(Self, Params)
    Params = Params or { }

    local Button = {
        Name = Params.Name or Params.name or "Button",
        Callback = Params.Callback or Params.callback or function() end,

        Window = Self.Window,
        Page = Self.Page,
        Section = Self.Section or Self,
        Items = { },
    }

    local Description = Params.Description or Params.description or Params.Comment or Params.comment
    local Frame = New("TextButton", {
        Parent = Self.Container,
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = Button.Name,
        LayoutOrder = NextOrder(),
    })
    Themed(function()
        Frame.BackgroundColor3 = Theme.Hover
        Frame.TextColor3 = Theme.Accent
    end)
    Outline(Frame, "Button Outline")

    AttachHoverHelp(Frame, Description, Button.Page)
    Button.Items = { Button = Wrap(Frame), Text = Wrap(Frame) }

    Connect(Frame.MouseEnter, function()
        Tween(Frame, { BackgroundTransparency = 0, TextColor3 = Theme.Text })
    end)

    Connect(Frame.MouseLeave, function()
        Tween(Frame, { BackgroundTransparency = 1, TextColor3 = Theme.Accent })
    end)

    function Button:Press()
        Frame.TextColor3 = Theme["Element Accent"]
        Tween(Frame, { TextColor3 = Theme.Text })
        SafeCall(Button.Callback)
    end

    function Button:SetVisibility(Bool)
        Frame.Visible = Bool
    end

    function Button:SetText(Text)
        Frame.Text = tostring(Text)
    end

    Connect(Frame.MouseButton1Click, function()
        Button:Press()
    end)

    return setmetatable(Button, Library)
end


local MovingSliders = {}
Connect(RunService.RenderStepped, function(Delta)
    local Dt = math.clamp(Delta, 0, 0.1)
    for Slider in MovingSliders do
        local Target = Slider.TargetPercent
        local Current = Slider.DrawnPercent
        if Target == nil or Current == nil or not Slider.Fill or not Slider.Fill.Parent then
            MovingSliders[Slider] = nil
        else


            local Rate = Slider.Sliding and 25 or 19
            local Fraction = 1 - math.exp(-Rate * Dt)
            local Next = Current + (Target - Current) * Fraction
            if math.abs(Target - Next) < 0.0007 then
                Next = Target
                MovingSliders[Slider] = nil
            end
            Slider.DrawnPercent = Next
            Slider.Fill.Size = UDim2.fromScale(Next, 1)
        end
    end
end)

Library.Slider = function(Self, Params)
    Params = Params or { }

    local Slider = {
        Name = Params.Name or Params.name or "Slider",
        Flag = Params.Flag or Params.flag or Params.Name or Params.name or ("slider_" .. NextOrder()),
        Default = Params.Default or Params.default or 0,
        Min = Params.Min or Params.min or 0,
        Max = Params.Max or Params.max or 100,
        Decimals = Params.Decimals or Params.decimals or 1,
        Suffix = Params.Suffix or Params.suffix or "",
        Callback = Params.Callback or Params.callback or function() end,
        Description = Params.Description or Params.description or Params.Comment or Params.comment,

        Window = Self.Window,
        Page = Self.Page,
        Section = Self.Section or Self,

        Value = nil,
        Sliding = false,
        TargetPercent = nil,
        DrawnPercent = nil,
        Items = { },
    }

    local Root = New("Frame", {
        Parent = Self.Container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = NextOrder(),
    })
    New("UIListLayout", { Parent = Root, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })

    local Title = New("TextLabel", {
        Parent = Root,
        Size = UDim2.new(1, 0, 0, 15),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.52,
        Text = Slider.Name,
        LayoutOrder = 1,
    })


    local ValueLabel = New("TextLabel", {
        Parent = Title,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 94, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Right,
        TextYAlignment = Enum.TextYAlignment.Center,
        BackgroundTransparency = 1,
        TextColor3 = Theme.Text,
        TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0.24,
        ZIndex = 2,
    })
    Themed(function() ValueLabel.TextColor3 = Theme.Text end)

    AttachHoverHelp(Root, Slider.Description, Slider.Page)

    local Bar = New("TextButton", {
        Parent = Root,
        Size = UDim2.new(1, 0, 0, 8),
        BackgroundTransparency = 1,
        LayoutOrder = 2,
    })
    Themed(function() Bar.BackgroundColor3 = Theme.Hover end)
    Outline(Bar)
    Corner(Bar, 2)
    Bar.ClipsDescendants = true

    local Fill = New("Frame", {
        Parent = Bar,
        Size = UDim2.fromScale(0, 1),
        BackgroundTransparency = 0,
    })
    Themed(function() Fill.BackgroundColor3 = Theme["Element Accent"] end)
    Corner(Fill, 2)
    Slider.Fill = Fill


    Slider.Items = {
        Slider = Wrap(Root),
        Text = Wrap(Title),
        RealSlider = Wrap(Bar),
        Accent = Wrap(Fill),
        Value = Wrap(ValueLabel),
    }

    Connect(Bar.MouseEnter, function()
        Smooth(Bar, "SliderHover", { BackgroundTransparency = 0.08 }, 0.2)
    end)
    Connect(Bar.MouseLeave, function()
        Smooth(Bar, "SliderHover", { BackgroundTransparency = 0.38 }, 0.26)
    end)
    Bar.BackgroundTransparency = 0.38

    function Slider:Set(Value)
        Value = tonumber(Value) or Slider.Min

        local NewValue = Round(math.clamp(Value, Slider.Min, Slider.Max), Slider.Decimals)
        local Changed = NewValue ~= Slider.Value
        Slider.Value = NewValue

        local Percent = (Slider.Max == Slider.Min) and 0 or (NewValue - Slider.Min) / (Slider.Max - Slider.Min)
        Percent = math.clamp(Percent, 0, 1)
        if not Changed and Slider.Initialized then return end
        Slider.TargetPercent = Percent
        if Slider.Initialized then
            MovingSliders[Slider] = true
        else

            Slider.DrawnPercent = Percent
            Fill.Size = UDim2.fromScale(Percent, 1)
            Slider.Initialized = true
        end
        ValueLabel.Text = tostring(NewValue) .. Slider.Suffix

        Flags[Slider.Flag] = NewValue

        if Changed then
            SafeCall(Slider.Callback, NewValue)
        end
    end

    function Slider:SetVisibility(Bool)
        Root.Visible = Bool
    end

    function Slider:SetText(Text)
        Title.Text = tostring(Text)
    end

    function Slider:GetSize(Input)
        local Percent = math.clamp((Input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        return Slider.Min + (Slider.Max - Slider.Min) * Percent
    end

    Connect(Bar.InputBegan, function(Input)
        if IsClick(Input) then
            Slider.Sliding = true
            Slider:Set(Slider:GetSize(Input))
        end
    end)

    Connect(UserInputService.InputChanged, function(Input)
        if Slider.Sliding and IsMove(Input) then
            Slider:Set(Slider:GetSize(Input))
        end
    end)

    Connect(UserInputService.InputEnded, function(Input)
        if IsClick(Input) then
            Slider.Sliding = false
        end
    end)

    Slider:Set(Slider.Default)

    SetFlags[Slider.Flag] = function(Value)
        Slider:Set(Value)
    end

    return setmetatable(Slider, Library)
end


Library.Dropdown = function(Self, Params)
    Params = Params or { }

    local Dropdown = {
        Name = Params.Name or Params.name or "Dropdown",
        OptionItems = Params.Items or Params.items or { },
        Flag = Params.Flag or Params.flag or Params.Name or Params.name or ("dropdown_" .. NextOrder()),
        Default = Params.Default or Params.default or "",
        Callback = Params.Callback or Params.callback or function() end,
        Description = Params.Description or Params.description or Params.Comment or Params.comment,
        Multi = Params.Multi or Params.multi or false,

        Window = Self.Window,
        Page = Self.Page,
        Section = Self.Section or Self,

        Value = nil,
        Options = { },
        IsOpen = false,
        Items = { },
    }

    if Dropdown.Multi then
        Dropdown.Value = { }
    end

    local Root = New("Frame", {
        Parent = Self.Container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = NextOrder(),
    })
    New("UIListLayout", { Parent = Root, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder })

    local Title = New("TextLabel", {
        Parent = Root,
        Size = UDim2.new(1, 0, 0, 12),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = Dropdown.Name,
        LayoutOrder = 1,
    })

    AttachHoverHelp(Root, Dropdown.Description, Dropdown.Page)

    local Box = New("TextButton", {
        Parent = Root,
        Size = UDim2.new(1, 0, 0, 16),
        BackgroundTransparency = 1,
        LayoutOrder = 2,
    })
    Themed(function() Box.BackgroundColor3 = Theme.Hover end)
    Outline(Box)

    local ValueLabel = New("TextLabel", {
        Parent = Box,
        Position = UDim2.fromOffset(5, 0),
        Size = UDim2.new(1, -25, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Text = "...",
    })

    local Sign = New("TextLabel", {
        Parent = Box,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 20, 1, 0),
        Text = "+",
    })

    local Popup = New("Frame", {
        Parent = Library.PopupHolder,
        Visible = false,
        BackgroundTransparency = 0,
        Size = UDim2.fromOffset(100, 26),
    })
    Themed(function() Popup.BackgroundColor3 = Theme.Window end)
    Outline(Popup)
    Popup.ClipsDescendants = true

    local Scroll = New("ScrollingFrame", {
        Parent = Popup,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollBarThickness = 0,
        Active = true,
    })
    FixedScrollbar(Scroll, Popup, 7, 4, 4)
    New("UIPadding", { Parent = Scroll, PaddingTop = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5) })
    New("UIListLayout", { Parent = Scroll, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })

    Dropdown.Items = {
        Dropdown = Wrap(Root),
        Text = Wrap(Title),
        RealDropdown = Wrap(Box),
        Value = Wrap(ValueLabel),
        OptionHolder = Wrap(Popup),
        OptionScroll = Wrap(Scroll),
    }
    Dropdown.Holder = Dropdown.Items.OptionHolder

    Connect(Box.MouseEnter, function() Tween(Box, { BackgroundTransparency = 0 }) end)
    Connect(Box.MouseLeave, function() Tween(Box, { BackgroundTransparency = 1 }) end)

    local function OptionCount()
        local Count = 0
        for _ in Dropdown.Options do
            Count += 1
        end
        return Count
    end

    local function PopupHeight()
        return math.clamp(OptionCount() * 21 + 5, 26, 200)
    end

    local function ValueText()
        if Dropdown.Multi then
            return #Dropdown.Value > 0 and table.concat(Dropdown.Value, ", ") or "..."
        end

        return Dropdown.Value or "..."
    end

    function Dropdown:Set(Value)
        if Dropdown.Multi then
            if type(Value) ~= "table" then
                return
            end

            Dropdown.Value = { }

            for _, Name in Value do
                if Dropdown.Options[Name] then
                    table.insert(Dropdown.Value, Name)
                end
            end

            for Name, OptionData in Dropdown.Options do
                OptionData.IsSelected = table.find(Dropdown.Value, Name) ~= nil
                OptionData:ToggleState(OptionData.IsSelected and "Active" or "Inactive")
            end
        else
            local Selected = Dropdown.Options[Value]
            if not Selected then
                return
            end

            Dropdown.Value = Value

            for _, OptionData in Dropdown.Options do
                OptionData.IsSelected = OptionData == Selected
                OptionData:ToggleState(OptionData.IsSelected and "Active" or "Inactive")
            end
        end

        Flags[Dropdown.Flag] = Dropdown.Value
        ValueLabel.Text = ValueText()
        SafeCall(Dropdown.Callback, Dropdown.Value)
    end

    function Dropdown:Add(Value)
        Value = tostring(Value)

        local OptionButton = New("TextButton", {
            Parent = Scroll,
            Size = UDim2.new(1, 0, 0, 16),
            Text = Value,
            LayoutOrder = NextOrder(),
        })

        local OptionData = {
            Button = Wrap(OptionButton),
            Text = Wrap(OptionButton),
            Name = Value,
            IsSelected = false,
        }

        function OptionData:ToggleState(State)
            Tween(OptionButton, { TextColor3 = State == "Active" and Theme.Text or Theme["Option Text"] })
        end

        Themed(function()
            OptionButton.TextColor3 = OptionData.IsSelected and Theme.Text or Theme["Option Text"]
        end)

        Connect(OptionButton.MouseEnter, function()
            if not OptionData.IsSelected then
                Tween(OptionButton, { TextColor3 = Theme["Dim Text"] })
            end
        end)

        Connect(OptionButton.MouseLeave, function()
            if not OptionData.IsSelected then
                Tween(OptionButton, { TextColor3 = Theme["Option Text"] })
            end
        end)

        function OptionData:Set()
            OptionData.IsSelected = not OptionData.IsSelected

            if Dropdown.Multi then
                local Index = table.find(Dropdown.Value, OptionData.Name)

                if Index then
                    table.remove(Dropdown.Value, Index)
                else
                    table.insert(Dropdown.Value, OptionData.Name)
                end

                OptionData.IsSelected = not Index
                OptionData:ToggleState(OptionData.IsSelected and "Active" or "Inactive")
            else
                if OptionData.IsSelected then
                    Dropdown.Value = OptionData.Name

                    for _, Other in Dropdown.Options do
                        if Other ~= OptionData then
                            Other.IsSelected = false
                            Other:ToggleState("Inactive")
                        end
                    end

                    OptionData:ToggleState("Active")
                else
                    Dropdown.Value = nil
                    OptionData:ToggleState("Inactive")
                end
            end

            Flags[Dropdown.Flag] = Dropdown.Value
            ValueLabel.Text = ValueText()
            SafeCall(Dropdown.Callback, Dropdown.Value)

            if not Dropdown.Multi then
                Dropdown:SetOpen(false)
            end
        end

        Connect(OptionButton.MouseButton1Click, function()
            OptionData:Set()
        end)

        Dropdown.Options[Value] = OptionData

        if Dropdown.IsOpen then
            Dropdown:Reposition()
        end

        return OptionData
    end

    function Dropdown:Remove(Option)
        local OptionData = Dropdown.Options[Option]

        if OptionData then
            OptionData.Button.Instance:Destroy()
            Dropdown.Options[Option] = nil
        end
    end

    function Dropdown:Refresh(List)
        for Name in Dropdown.Options do
            Dropdown:Remove(Name)
        end

        for _, Value in List do
            Dropdown:Add(Value)
        end

        if Dropdown.IsOpen then
            Dropdown:Reposition()
        end
    end

    function Dropdown:SetText(Text)
        Title.Text = tostring(Text)
    end

    function Dropdown:SetVisibility(Bool)
        Root.Visible = Bool
    end

    function Dropdown:Reposition()
        if not Dropdown.Animating then
            Popup.Size = UDim2.fromOffset(Box.AbsoluteSize.X, PopupHeight())
        end
        PlaceBelow(Popup, Box, 4)
    end

    function Dropdown:SetOpen(Bool)
        Bool = Bool and true or false
        if Bool == Dropdown.IsOpen then return end
        Dropdown.IsOpen = Bool
        Dropdown.Generation = (Dropdown.Generation or 0) + 1
        local Generation = Dropdown.Generation
        Sign.Text = Bool and "-" or "+"
        Smooth(Sign, "DropdownSign", {
            TextColor3 = Bool and Theme.Text or Theme["Dim Text"]
        }, 0.28)
        Dropdown.Animating = true

        if Bool then
            Library:CloseAll(Dropdown)
            Popup.Visible = true
            Popup.Size = UDim2.fromOffset(Box.AbsoluteSize.X, 0)
            PlaceBelow(Popup, Box, 4)
            Library.OpenFrames[Dropdown] = Dropdown
            local Motion = Smooth(Popup, "DropdownHeight", {
                Size = UDim2.fromOffset(Box.AbsoluteSize.X, PopupHeight())
            }, 0.34)
            Motion.Completed:Connect(function(State)
                if Generation == Dropdown.Generation and State == Enum.PlaybackState.Completed then
                    Dropdown.Animating = false
                end
            end)
        else
            Library.OpenFrames[Dropdown] = nil
            local Motion = Smooth(Popup, "DropdownHeight", {
                Size = UDim2.fromOffset(Box.AbsoluteSize.X, 0)
            }, 0.25)
            Motion.Completed:Connect(function(State)
                if Generation == Dropdown.Generation and State == Enum.PlaybackState.Completed then
                    Popup.Visible = false
                    Dropdown.Animating = false
                end
            end)
        end
    end

    Connect(Box.MouseButton1Click, function()
        Dropdown:SetOpen(not Dropdown.IsOpen)
    end)

    Connect(UserInputService.InputBegan, function(Input)
        if IsClick(Input) and Dropdown.IsOpen and not IsMouseOver(Popup) and not IsMouseOver(Box) then
            Dropdown:SetOpen(false)
        end
    end)

    for _, Value in Dropdown.OptionItems do
        Dropdown:Add(Value)
    end

    if type(Dropdown.Default) == "number" and Dropdown.OptionItems[Dropdown.Default] then
        Dropdown.Default = Dropdown.OptionItems[Dropdown.Default]
    end

    Dropdown:Set(Dropdown.Default)

    SetFlags[Dropdown.Flag] = function(Value)
        Dropdown:Set(Value)
    end

    return setmetatable(Dropdown, Library)
end


Library.Label = function(Self, Params)
    Params = Params or { }

    local Label = {
        Name = Params.Name or Params.name or "Label",

        Window = Self.Window,
        Page = Self.Page,
        Section = Self.Section or Self,
        Items = { },
    }

    local Row = New("Frame", {
        Parent = Self.Container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 14),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = NextOrder(),
    })

    local Text = New("TextLabel", {
        Parent = Row,
        Size = UDim2.new(1, 0, 0, 14),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        RichText = true,
        Text = Label.Name,
    })
    Themed(function() Text.TextColor3 = Theme["Dim Text"] end)

    local Sub = New("Frame", {
        Parent = Row,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 0, 0, 14),
        AutomaticSize = Enum.AutomaticSize.X,
    })
    New("UIListLayout", {
        Parent = Sub,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    Label.Items = { Label = Wrap(Row), Text = Wrap(Text), SubElements = Wrap(Sub) }

    function Label:SetVisibility(Bool)
        Row.Visible = Bool
    end

    function Label:SetText(NewText)
        Text.Text = tostring(NewText)
    end

    function Label:Colorpicker(Data)
        Data = Data or { }

        return (Library:CreateColorpicker({
            Parent = Sub,
            Section = Label.Section,
            Flag = Data.Flag or Data.flag or Data.Name or Data.name or Label.Name,
            Default = Data.Default or Data.default or Color3.new(1, 1, 1),
            Alpha = Data.Alpha or Data.alpha or 0,
            Callback = Data.Callback or Data.callback or function() end,
        }))
    end

    function Label:Keybind(Data)
        Data = Data or { }

        return (Library:CreateKeybind({
            Parent = Sub,
            Name = Data.Name or Data.name or Label.Name,
            Section = Label.Section,
            Flag = Data.Flag or Data.flag or Data.Name or Data.name or Label.Name,
            Default = Data.Default or Data.default,
            Mode = Data.Mode or Data.mode or "Toggle",
            ShowInList = Data.ShowInList,
            Callback = Data.Callback or Data.callback or function() end,
        }))
    end

    return setmetatable(Label, Library)
end


Library.Textbox = function(Self, Params)
    Params = Params or { }

    local Textbox = {
        Name = Params.Name or Params.name,
        Flag = Params.Flag or Params.flag or Params.Name or Params.name or ("textbox_" .. NextOrder()),
        Default = Params.Default or Params.default or "",
        Callback = Params.Callback or Params.callback or function() end,
        Finished = Params.Finished or Params.finished or false,
        Placeholder = Params.Placeholder or Params.placeholder or "",
        Numeric = Params.Numeric or Params.numeric or false,

        Window = Self.Window,
        Page = Self.Page,
        Section = Self.Section or Self,

        Value = "",
        Items = { },
    }

    local Root = New("Frame", {
        Parent = Self.Container,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = NextOrder(),
    })
    New("UIListLayout", { Parent = Root, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder })

    local Title
    if Textbox.Name then
        Title = New("TextLabel", {
            Parent = Root,
            Size = UDim2.new(1, 0, 0, 12),
            TextXAlignment = Enum.TextXAlignment.Left,
            Text = Textbox.Name,
            LayoutOrder = 1,
        })
    end

    local Frame = New("Frame", {
        Parent = Root,
        Size = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1,
        LayoutOrder = 2,
    })
    Outline(Frame)

    local Input = New("TextBox", {
        Parent = Frame,
        Position = UDim2.fromOffset(5, 0),
        Size = UDim2.new(1, -10, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        ClipsDescendants = true,
        PlaceholderText = Textbox.Placeholder,
        Text = "",
    })
    Themed(function() Input.PlaceholderColor3 = Theme["Option Text"] end)

    Textbox.Items = { Textbox = Wrap(Root), Text = Title and Wrap(Title) or nil, Input = Wrap(Input) }

    function Textbox:Set(Value)
        Value = tostring(Value or "")

        if Textbox.Numeric then
            Value = Value:gsub("[^%d%.%-]", "")
        end

        Textbox.Value = Value
        if Input.Text ~= Value then
            Input.Text = Value
        end

        Flags[Textbox.Flag] = Value
        SafeCall(Textbox.Callback, Value)
    end

    function Textbox:SetVisibility(Bool)
        Root.Visible = Bool
    end

    function Textbox:SetText(Text)
        if Title then
            Title.Text = tostring(Text)
        end
    end

    if Textbox.Finished then
        Connect(Input.FocusLost, function()
            Textbox:Set(Input.Text)
        end)
    else
        Connect(Input:GetPropertyChangedSignal("Text"), function()
            if Input.Text ~= Textbox.Value then
                Textbox:Set(Input.Text)
            end
        end)
    end

    Textbox:Set(Textbox.Default)

    SetFlags[Textbox.Flag] = function(Value)
        Textbox:Set(Value)
    end

    return setmetatable(Textbox, Library)
end



Env.VergilLibrary = Library
return Library
end, function(err)
    local stack = (debug and type(debug.traceback) == "function") and debug.traceback() or ""
    return tostring(err) .. "\n" .. tostring(stack)
end)
if not loaded then
    ShowVergilError(problem)
    error(problem, 0)
end
return problem
