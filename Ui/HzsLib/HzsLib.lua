local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerMouse = Player:GetMouse()

local CoreGui = (gethui and gethui()) or game:GetService("CoreGui");

local SAVE_FOLDER = "HzsLib"
local SETTINGS_FOLDER = SAVE_FOLDER .. "/SettingsSave"
local PROFILE_FILE = SETTINGS_FOLDER .. "/profile.json"

local function EnsureFolder(path)
	if makefolder and not isfolder(path) then
		makefolder(path)
	end
end
pcall(EnsureFolder, SAVE_FOLDER)
pcall(EnsureFolder, SETTINGS_FOLDER)

local function ReadJson(path)
	if readfile and isfile and isfile(path) then
		local ok, data = pcall(readfile, path)
		if ok then
			local ok2, t = pcall(function() return HttpService:JSONDecode(data) end)
			if ok2 and type(t) == "table" then return t end
		end
	end
	return {}
end

local function WriteJson(path, t)
	if writefile then
		local ok, json = pcall(function() return HttpService:JSONEncode(t) end)
		if ok then pcall(writefile, path, json) end
	end
end

local ProfileData = ReadJson(PROFILE_FILE)
if type(ProfileData) ~= "table" then ProfileData = {} end
ProfileData.DisplayName = ProfileData.DisplayName or Player.DisplayName
ProfileData.Username = ProfileData.Username or ("@" .. Player.Name)
ProfileData.Password = ProfileData.Password or ""
ProfileData.LoggedIn = ProfileData.LoggedIn ~= false

local function SaveProfile()
	WriteJson(PROFILE_FILE, ProfileData)
end
SaveProfile()

local function GetSeasonalTheme()
	local d = os.date("*t")
	local m, day = d.month, d.day
	if (m == 10 and day >= 15) or (m == 11 and day <= 2) then
		return "Halloween"
	elseif (m == 12) or (m == 1 and day <= 6) then
		return "Natal"
	elseif (m == 2 and day >= 10 and day <= 16) or (m == 6 and day >= 8 and day <= 14) then
		return "Valentine"
	end
	return nil
end

local HzsLib = {
	Themes = {
		White = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(240, 240, 248)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(220, 220, 235)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(240, 240, 248))
			}),
			["Color Hub 2"] = Color3.fromRGB(248, 248, 255),
			["Color Stroke"] = Color3.fromRGB(180, 160, 200),
			["Color Theme"] = Color3.fromRGB(150, 80, 220),
			["Color Text"] = Color3.fromRGB(30, 20, 40),
			["Color Dark Text"] = Color3.fromRGB(100, 90, 120)
		},
		Dark = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 0)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(16, 12, 15)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
			}),
			["Color Hub 2"] = Color3.fromRGB(12, 10, 12),
			["Color Stroke"] = Color3.fromRGB(90, 45, 70),
			["Color Theme"] = Color3.fromRGB(255, 105, 180),
			["Color Text"] = Color3.fromRGB(255, 255, 255),
			["Color Dark Text"] = Color3.fromRGB(190, 170, 182)
		},
		Natal = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(35, 12, 18)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(12, 28, 18)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(35, 12, 18))
			}),
			["Color Hub 2"] = Color3.fromRGB(18, 24, 20),
			["Color Stroke"] = Color3.fromRGB(190, 45, 55),
			["Color Theme"] = Color3.fromRGB(235, 55, 65),
			["Color Text"] = Color3.fromRGB(255, 255, 255),
			["Color Dark Text"] = Color3.fromRGB(190, 220, 200)
		},
		Halloween = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(22, 10, 30)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(12, 8, 16)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(22, 10, 30))
			}),
			["Color Hub 2"] = Color3.fromRGB(16, 12, 20),
			["Color Stroke"] = Color3.fromRGB(145, 65, 170),
			["Color Theme"] = Color3.fromRGB(255, 120, 20),
			["Color Text"] = Color3.fromRGB(255, 245, 235),
			["Color Dark Text"] = Color3.fromRGB(195, 165, 205)
		},
		Valentine = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(35, 12, 24)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(22, 10, 18)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(35, 12, 24))
			}),
			["Color Hub 2"] = Color3.fromRGB(24, 14, 20),
			["Color Stroke"] = Color3.fromRGB(190, 60, 115),
			["Color Theme"] = Color3.fromRGB(255, 85, 145),
			["Color Text"] = Color3.fromRGB(255, 240, 245),
			["Color Dark Text"] = Color3.fromRGB(220, 175, 195)
		}
	},
	Info = {
		Version = "1.1.0"
	},
	Background = {
		Url = "https://cdn.discordapp.com/attachments/1552055729450520656/1571244099737100318/f7d253ec8f25453ac387322c3061e848.jpg?ex=6afc00d9&is=6afaaf59&hm=fdf771354caea0fd29440c4de49eab24d49fa9da79c14ec308916d54a8900e9d&",
		Dim = 0.45
	},
	Save = {
		UISize = {550, 400},
		TabSize = 150,
		Theme = "White",
		ScalePercent = 100
	},
	Settings = {},
	Connection = {},
	Instances = {},
	Elements = {},
	Options = {},
	Flags = {},
	Tabs = {},
	Icons = (function()
		return {
			["accessibility"] = "rbxassetid://10709751939",
			["activity"] = "rbxassetid://10709752035",
			["airvent"] = "rbxassetid://10709752131",
			["airplay"] = "rbxassetid://10709752254",
			["alarmcheck"] = "rbxassetid://10709752405",
			["alarmclock"] = "rbxassetid://10709752630",
			["alarmclockoff"] = "rbxassetid://10709752508",
			["alarmminus"] = "rbxassetid://10709752732",
			["alarmplus"] = "rbxassetid://10709752825",
			["album"] = "rbxassetid://10709752906",
			["alertcircle"] = "rbxassetid://10709752996",
			["alertoctagon"] = "rbxassetid://10709753064",
			["alerttriangle"] = "rbxassetid://10709753149",
			["aligncenter"] = "rbxassetid://10709753570",
			["aligncenterhorizontal"] = "rbxassetid://10709753272",
			["aligncentervertical"] = "rbxassetid://10709753421",
			["alignendhorizontal"] = "rbxassetid://10709753692",
			["alignendvertical"] = "rbxassetid://10709753808",
			["anchor"] = "rbxassetid://10709761530",
			["angry"] = "rbxassetid://10709761629",
			["annoyed"] = "rbxassetid://10709761722",
			["aperture"] = "rbxassetid://10709761813",
			["apple"] = "rbxassetid://10709761889",
			["archive"] = "rbxassetid://10709762233",
			["archiverestore"] = "rbxassetid://10709762058",
			["armchair"] = "rbxassetid://10709762327",
			["arrowdown"] = "rbxassetid://10709767827",
			["arrowdowncircle"] = "rbxassetid://10709763034",
			["arrowleft"] = "rbxassetid://10709768114",
			["arrowright"] = "rbxassetid://10709768347",
			["arrowup"] = "rbxassetid://10709768939",
			["asterisk"] = "rbxassetid://10709769095",
			["atsign"] = "rbxassetid://10709769286",
			["award"] = "rbxassetid://10709769406",
			["axe"] = "rbxassetid://10709769508",
			["baby"] = "rbxassetid://10709769732",
			["backpack"] = "rbxassetid://10709769841",
			["bell"] = "rbxassetid://10709775704",
			["bellminus"] = "rbxassetid://10709775241",
			["belloff"] = "rbxassetid://10709775320",
			["bellplus"] = "rbxassetid://10709775448",
			["bike"] = "rbxassetid://10709775894",
			["book"] = "rbxassetid://10709781824",
			["bot"] = "rbxassetid://10709782230",
			["box"] = "rbxassetid://10709782497",
			["briefcase"] = "rbxassetid://10709782662",
			["brush"] = "rbxassetid://10709782758",
			["bug"] = "rbxassetid://10709782845",
			["building"] = "rbxassetid://10709783051",
			["bus"] = "rbxassetid://10709783137",
			["cake"] = "rbxassetid://10709783217",
			["calculator"] = "rbxassetid://10709783311",
			["calendar"] = "rbxassetid://10709789505",
			["camera"] = "rbxassetid://10709789686",
			["car"] = "rbxassetid://10709789810",
			["check"] = "rbxassetid://10709790644",
			["checkcircle"] = "rbxassetid://10709790387",
			["chevrondown"] = "rbxassetid://10709790948",
			["chevronleft"] = "rbxassetid://10709791281",
			["chevronright"] = "rbxassetid://10709791437",
			["chevronup"] = "rbxassetid://10709791523",
			["circle"] = "rbxassetid://10709798174",
			["clipboard"] = "rbxassetid://10709799288",
			["clock"] = "rbxassetid://10709805144",
			["cloud"] = "rbxassetid://10709806740",
			["code"] = "rbxassetid://10709810463",
			["code2"] = "rbxassetid://10709807111",
			["coffee"] = "rbxassetid://10709810814",
			["cog"] = "rbxassetid://10709810948",
			["coins"] = "rbxassetid://10709811110",
			["command"] = "rbxassetid://10709811365",
			["compass"] = "rbxassetid://10709811445",
			["contact"] = "rbxassetid://10709811834",
			["copy"] = "rbxassetid://10709812159",
			["cpu"] = "rbxassetid://10709813383",
			["crown"] = "rbxassetid://10709818626",
			["database"] = "rbxassetid://10709818996",
			["diamond"] = "rbxassetid://10709819149",
			["download"] = "rbxassetid://10723344270",
			["edit"] = "rbxassetid://10734883598",
			["edit2"] = "rbxassetid://10723344885",
			["eye"] = "rbxassetid://10723346959",
			["eyeoff"] = "rbxassetid://10723346871",
			["file"] = "rbxassetid://10723374641",
			["flag"] = "rbxassetid://10723375890",
			["flame"] = "rbxassetid://10723376114",
			["folder"] = "rbxassetid://10723387563",
			["gem"] = "rbxassetid://10723396000",
			["ghost"] = "rbxassetid://10723396107",
			["gift"] = "rbxassetid://10723396402",
			["globe"] = "rbxassetid://10723404337",
			["heart"] = "rbxassetid://10723406885",
			["home"] = "rbxassetid://10723407389",
			["image"] = "rbxassetid://10723415040",
			["info"] = "rbxassetid://10723415903",
			["key"] = "rbxassetid://10723416652",
			["keyboard"] = "rbxassetid://10723416765",
			["laptop"] = "rbxassetid://10723423881",
			["layers"] = "rbxassetid://10723424505",
			["layout"] = "rbxassetid://10723425376",
			["leaf"] = "rbxassetid://10723425539",
			["library"] = "rbxassetid://10723425615",
			["link"] = "rbxassetid://10723426722",
			["list"] = "rbxassetid://10723433811",
			["lock"] = "rbxassetid://10723434711",
			["login"] = "rbxassetid://10723434830",
			["logout"] = "rbxassetid://10723434906",
			["mail"] = "rbxassetid://10734885430",
			["map"] = "rbxassetid://10734886202",
			["maximize"] = "rbxassetid://10734886735",
			["menu"] = "rbxassetid://10734887784",
			["messagecircle"] = "rbxassetid://10734888000",
			["messagesquare"] = "rbxassetid://10734888228",
			["mic"] = "rbxassetid://10734888864",
			["minus"] = "rbxassetid://10734896206",
			["monitor"] = "rbxassetid://10734896881",
			["moon"] = "rbxassetid://10734897102",
			["move"] = "rbxassetid://10734900011",
			["music"] = "rbxassetid://10734905958",
			["package"] = "rbxassetid://10734909540",
			["palette"] = "rbxassetid://10734910430",
			["pencil"] = "rbxassetid://10734919691",
			["percent"] = "rbxassetid://10734919919",
			["phone"] = "rbxassetid://10734921524",
			["pin"] = "rbxassetid://10734922324",
			["play"] = "rbxassetid://10734923549",
			["plus"] = "rbxassetid://10734924532",
			["pluscircle"] = "rbxassetid://10734923868",
			["power"] = "rbxassetid://10734930466",
			["printer"] = "rbxassetid://10734930632",
			["radio"] = "rbxassetid://10734931596",
			["redo"] = "rbxassetid://10734932822",
			["refreshccw"] = "rbxassetid://10734933056",
			["refreshcw"] = "rbxassetid://10734933222",
			["reply"] = "rbxassetid://10734934252",
			["rocket"] = "rbxassetid://10734934585",
			["rotatecw"] = "rbxassetid://10734940654",
			["rss"] = "rbxassetid://10734940825",
			["ruler"] = "rbxassetid://10734941018",
			["save"] = "rbxassetid://10734941499",
			["scan"] = "rbxassetid://10734942565",
			["search"] = "rbxassetid://10734943674",
			["send"] = "rbxassetid://10734943902",
			["settings"] = "rbxassetid://10734950309",
			["settings2"] = "rbxassetid://10734950020",
			["share"] = "rbxassetid://10734950813",
			["shield"] = "rbxassetid://10734951847",
			["shieldcheck"] = "rbxassetid://10734951367",
			["shuffle"] = "rbxassetid://10734953451",
			["sigma"] = "rbxassetid://10734954538",
			["sliders"] = "rbxassetid://10734963400",
			["smartphone"] = "rbxassetid://10734963940",
			["smile"] = "rbxassetid://10734964441",
			["star"] = "rbxassetid://10734966248",
			["starhalf"] = "rbxassetid://10734965897",
			["staroff"] = "rbxassetid://10734966097",
			["sun"] = "rbxassetid://10734974297",
			["tag"] = "rbxassetid://10734976528",
			["tags"] = "rbxassetid://10734976739",
			["target"] = "rbxassetid://10734977012",
			["terminal"] = "rbxassetid://10734982144",
			["thumbsup"] = "rbxassetid://10734983629",
			["thumbsdown"] = "rbxassetid://10734983359",
			["trash"] = "rbxassetid://10747362393",
			["trash2"] = "rbxassetid://10747362241",
			["trendingup"] = "rbxassetid://10747363465",
			["trophy"] = "rbxassetid://10747363809",
			["tv"] = "rbxassetid://10747364593",
			["umbrella"] = "rbxassetid://10747364971",
			["unlock"] = "rbxassetid://10747366027",
			["upload"] = "rbxassetid://10747366434",
			["user"] = "rbxassetid://10747373176",
			["usercheck"] = "rbxassetid://10747371901",
			["usercog"] = "rbxassetid://10747372167",
			["userminus"] = "rbxassetid://10747372346",
			["userplus"] = "rbxassetid://10747372702",
			["users"] = "rbxassetid://10747373426",
			["verified"] = "rbxassetid://10747374131",
			["video"] = "rbxassetid://10747374938",
			["volume"] = "rbxassetid://10747376008",
			["wallet"] = "rbxassetid://10747376205",
			["wifi"] = "rbxassetid://10747382504",
			["wifioff"] = "rbxassetid://10747382268",
			["wrench"] = "rbxassetid://10747383470",
			["x"] = "rbxassetid://10747384394",
			["xcircle"] = "rbxassetid://10747383819",
			["xsquare"] = "rbxassetid://10747384217",
			["zoomin"] = "rbxassetid://10747384552",
			["zoomout"] = "rbxassetid://10747384679",
			["sparkles"] = "rbxassetid://10734965251",
			["sparkle"] = "rbxassetid://10734965004",
			["brain"] = "rbxassetid://10709782230",
			["flame2"] = "rbxassetid://10723376114",
			["sword"] = "rbxassetid://10734975486",
			["swords"] = "rbxassetid://10734975692",
			["crosshair"] = "rbxassetid://10709818534",
			["gun"] = "rbxassetid://10734975486",
			["radar"] = "rbxassetid://10709818534",
			["compass2"] = "rbxassetid://10709811445",
			["locate"] = "rbxassetid://10723434557",
			["mappin"] = "rbxassetid://10734886004",
			["navigation"] = "rbxassetid://10734906744",
			["circleuserround"] = "rbxassetid://10747373176",
			["circleuser"] = "rbxassetid://10747373176",
			["userround"] = "rbxassetid://10747373176",
			["idcard"] = "rbxassetid://10709811834",
			["loadercircle"] = "rbxassetid://10734933056",
			["github"] = "rbxassetid://10709807111",
			["snowflake"] = "rbxassetid://10734964852",
			["treepine"] = "rbxassetid://10734983210",
			["skull"] = "rbxassetid://10734963177",
			["wand"] = "rbxassetid://10734984180",
			["flask"] = "rbxassetid://10723374805",
			["spider"] = "rbxassetid://10709782845",
		}
	end)()
}

local ViewportSize = workspace.CurrentCamera.ViewportSize
local UIScale = ViewportSize.Y / 450

local Settings = HzsLib.Settings
local Flags = HzsLib.Flags

local SetProps, SetChildren, InsertTheme, Create do
	InsertTheme = function(Instance, Type)
		table.insert(HzsLib.Instances, {
			Instance = Instance,
			Type = Type
		})
		return Instance
	end
	
	SetChildren = function(Instance, Children)
		if Children then
			table.foreach(Children, function(_,Child)
				Child.Parent = Instance
			end)
		end
		return Instance
	end
	
	SetProps = function(Instance, Props)
		if Props then
			table.foreach(Props, function(prop, value)
				Instance[prop] = value
			end)
		end
		return Instance
	end
	
	Create = function(...)
		local args = {...}
		if type(args) ~= "table" then return end
		local new = Instance.new(args[1])
		local Children = {}
		
		if type(args[2]) == "table" then
			SetProps(new, args[2])
			SetChildren(new, args[3])
			Children = args[3] or {}
		elseif typeof(args[2]) == "Instance" then
			new.Parent = args[2]
			SetProps(new, args[3])
			SetChildren(new, args[4])
			Children = args[4] or {}
		end
		return new
	end
	
	local function Save(file)
		if readfile and isfile and isfile(file) then
			local decode = HttpService:JSONDecode(readfile(file))
			if type(decode) == "table" then end
		end
	end
	
	pcall(Save, "redz library V5.json")
end

local Funcs = {} do
	function Funcs:InsertCallback(tab, func)
		if type(func) == "function" then
			table.insert(tab, func)
		end
		return func
	end
	
	function Funcs:FireCallback(tab, ...)
		for _,v in ipairs(tab) do
			if type(v) == "function" then
				task.spawn(v, ...)
			end
		end
	end
	
	function Funcs:ToggleVisible(Obj, Bool)
		Obj.Visible = Bool ~= nil and Bool or Obj.Visible
	end
	
	function Funcs:ToggleParent(Obj, Parent)
		if Bool ~= nil then
			Obj.Parent = Bool
		else
			Obj.Parent = not Obj.Parent and Parent
		end
	end
	
	function Funcs:GetConnectionFunctions(ConnectedFuncs, func)
		local Connected = { Function = func, Connected = true }
		
		function Connected:Disconnect()
			if self.Connected then
				table.remove(ConnectedFuncs, table.find(ConnectedFuncs, self.Function))
				self.Connected = false
			end
		end
		
		function Connected:Fire(...)
			if self.Connected then
				task.spawn(self.Function, ...)
			end
		end
		
		return Connected
	end
	
	function Funcs:GetCallback(Configs, index)
		local func = Configs[index] or Configs.Callback or function()end
		
		if type(func) == "table" then
			return ({function(Value) func[1][func[2]] = Value end})
		end
		return {func}
	end
end

local Connections, Connection = {}, HzsLib.Connection do
	local function NewConnectionList(List)
		if type(List) ~= "table" then return end
		
		for _,CoName in ipairs(List) do
			local ConnectedFuncs, Connect = {}, {}
			Connection[CoName] = Connect
			Connections[CoName] = ConnectedFuncs
			Connect.Name = CoName
			
			function Connect:Connect(func)
				if type(func) == "function" then
					table.insert(ConnectedFuncs, func)
					return Funcs:GetConnectionFunctions(ConnectedFuncs, func)
				end
			end
			
			function Connect:Once(func)
				if type(func) == "function" then
					local Connected;
					local _NFunc;_NFunc = function(...)
						task.spawn(func, ...)
						Connected:Disconnect()
					end
					Connected = Funcs:GetConnectionFunctions(ConnectedFuncs, _NFunc)
					return Connected
				end
			end
		end
	end
	
	function Connection:FireConnection(CoName, ...)
		local Connection = type(CoName) == "string" and Connections[CoName] or Connections[CoName.Name]
		for _,Func in pairs(Connection) do
			task.spawn(Func, ...)
		end
	end
	
	NewConnectionList({"FlagsChanged", "ThemeChanged", "FileSaved", "ThemeChanging", "OptionAdded"})
end

local GetFlag, SetFlag, CheckFlag do
	CheckFlag = function(Name)
		return type(Name) == "string" and Flags[Name] ~= nil
	end
	
	GetFlag = function(Name)
		return type(Name) == "string" and Flags[Name]
	end
	
	SetFlag = function(Flag, Value)
		if Flag and (Value ~= Flags[Flag] or type(Value) == "table") then
			Flags[Flag] = Value
			Connection:FireConnection("FlagsChanged", Flag, Value)
		end
	end
	
	local db
	Connection.FlagsChanged:Connect(function(Flag, Value)
		local ScriptFile = Settings.ScriptFile
		if not db and ScriptFile and writefile then
			db=true;task.wait(0.1);db=false
			local Success, Encoded = pcall(function()
				return HttpService:JSONEncode(Flags)
			end)
			if Success then
				local Success = pcall(writefile, ScriptFile, Encoded)
				if Success then
					Connection:FireConnection("FileSaved", "Script-Flags", ScriptFile, Encoded)
				end
			end
		end
	end)
end

local ScreenGui = Create("ScreenGui", CoreGui, {
	Name = "HzsLib-v110",
}, {
	Create("UIScale", {
		Scale = UIScale,
		Name = "Scale"
	})
})

local ScreenFind = CoreGui:FindFirstChild(ScreenGui.Name)
if ScreenFind and ScreenFind ~= ScreenGui then
	ScreenFind:Destroy()
end

local function GetStr(val)
	if type(val) == "function" then
		return val()
	end
	return val
end

local function ConnectSave(Instance, func)
	Instance.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do task.wait()
			end
		end
		func()
	end)
end

local DefaultSounds = {
	Click = "rbxassetid://6895079853",
	Hover = "rbxassetid://6895079853",
	ToggleOn = "rbxassetid://6027878341",
	ToggleOff = "rbxassetid://6027878418",
	Tab = "rbxassetid://9114223170",
	DropdownOpen = "rbxassetid://9114223170",
	DropdownClose = "rbxassetid://9114223170",
	DropdownSelect = "rbxassetid://6895079853",
	Slider = "rbxassetid://6895079853",
	Dialog = "rbxassetid://9114223170",
	Close = "rbxassetid://7244593699",
	Copy = "rbxassetid://6895079853",
	Error = "rbxassetid://9069609268",
	Success = "rbxassetid://6895079853"
}
local SoundCache = {}
local function PlayClick(Name, Pitch, Vol)
	if HzsLib.SoundEnabled == false then return end
	Name = Name or "Click"
	local Id = (HzsLib.Sounds and HzsLib.Sounds[Name]) or (Name == "Click" and HzsLib.ClickSoundId) or DefaultSounds[Name] or DefaultSounds.Click
	local Snd = SoundCache[Name]
	if not Snd or not Snd.Parent then
		Snd = Instance.new("Sound")
		Snd.Name = "Hub" .. Name
		Snd.Parent = game:GetService("SoundService")
		SoundCache[Name] = Snd
	end
	if Snd.SoundId ~= Id then Snd.SoundId = Id end
	if Name == "Hover" then
		Pitch = Pitch or 1.35
		Vol = Vol or 0.2
	elseif Name == "ToggleOn" then
		Pitch = Pitch or 1.15
	elseif Name == "ToggleOff" then
		Pitch = Pitch or 0.85
	elseif Name == "Slider" then
		Pitch = Pitch or 1.4
		Vol = Vol or 0.25
	elseif Name == "Copy" or Name == "Success" then
		Pitch = Pitch or 1.25
	end
	Snd.Volume = (Vol or 1) * (HzsLib.SoundVolume or 0.6)
	Snd.PlaybackSpeed = Pitch or 1
	Snd.TimePosition = 0
	Snd:Play()
end

local ActiveTweens = setmetatable({}, {__mode = "k"})
local function CreateTween(Configs)
	local Instance = Configs[1] or Configs.Instance
	local Prop = Configs[2] or Configs.Prop
	local NewVal = Configs[3] or Configs.NewVal
	local Time = Configs[4] or Configs.Time or 0.5
	local TweenWait = Configs[5] or Configs.wait or false
	local Info = TweenInfo.new(Time, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	
	local Cache = ActiveTweens[Instance]
	if not Cache then
		Cache = {}
		ActiveTweens[Instance] = Cache
	end
	local Old = Cache[Prop]
	if Old then Old:Cancel() end
	
	local Tween = TweenService:Create(Instance, Info, {[Prop] = NewVal})
	Cache[Prop] = Tween
	Tween.Completed:Connect(function()
		if Cache[Prop] == Tween then Cache[Prop] = nil end
	end)
	Tween:Play()
	if TweenWait then
		Tween.Completed:Wait()
	end
	return Tween
end

local function MakeDrag(Instance)
	task.spawn(function()
		SetProps(Instance, {
			Active = true,
			AutoButtonColor = false
		})
		
		local DragStart, StartPos, InputOn
		
		local function Update(Input)
			local delta = Input.Position - DragStart
			local Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X / UIScale, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y / UIScale)
			Instance.Position = Position
		end
		
		Instance.MouseButton1Down:Connect(function()
			InputOn = true
		end)
		
		Instance.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				StartPos = Instance.Position
				DragStart = Input.Position
				
				while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do RunService.Heartbeat:Wait()
					if InputOn then
						Update(Input)
					end
				end
				InputOn = false
			end
		end)
	end)
	return Instance
end

local function VerifyTheme(Theme)
	for name,_ in pairs(HzsLib.Themes) do
		if name == Theme then
			return true
		end
	end
end

local function SaveJson(FileName, save)
	if writefile then
		local json = HttpService:JSONEncode(save)
		writefile(FileName, json)
	end
end

local Theme = HzsLib.Themes[HzsLib.Save.Theme]

local function AddEle(Name, Func)
	HzsLib.Elements[Name] = Func
end

local function Make(Ele, Instance, props, ...)
	local Element = HzsLib.Elements[Ele](Instance, props, ...)
	return Element
end

AddEle("Corner", function(parent, CornerRadius)
	local New = SetProps(Create("UICorner", parent, {
		CornerRadius = CornerRadius or UDim.new(0, 20)
	}), props)
	return New
end)

AddEle("Stroke", function(parent, props, ...)
	local args = {...}
	local New = InsertTheme(SetProps(Create("UIStroke", parent, {
		Color = args[1] or Color3.fromRGB(255, 255, 255),
		Thickness = args[2] or 1,
		ApplyStrokeMode = "Border"
	}), props), "Stroke")
	return New
end)

AddEle("Button", function(parent, props, ...)
	local args = {...}
	local New = InsertTheme(SetProps(Create("TextButton", parent, {
		Text = "",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme["Color Hub 2"],
		BackgroundTransparency = 0.25,
		AutoButtonColor = false
	}), props), "Frame")
	
	Create("UIStroke", New, {
		Color = Color3.fromRGB(200, 200, 220),
		Thickness = 1,
		Transparency = 0.4,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Name = "WhiteBorder"
	})
	
	New.MouseEnter:Connect(function()
		New.BackgroundTransparency = 0.5
	end)
	New.MouseLeave:Connect(function()
		New.BackgroundTransparency = 0.25
	end)
	if args[1] then
		New.Activated:Connect(args[1])
	end
	return New
end)

AddEle("Gradient", function(parent, props, ...)
	local args = {...}
	local New = InsertTheme(SetProps(Create("UIGradient", parent, {
		Color = Theme["Color Hub 1"]
	}), props), "Gradient")
	return New
end)

local function ButtonFrame(Instance, Title, Description, HolderSize)
	local TitleL = InsertTheme(Create("TextLabel", {
		Font = Enum.Font.GothamMedium,
		TextColor3 = Theme["Color Text"],
		Size = UDim2.new(1, -20),
		AutomaticSize = "Y",
		Position = UDim2.new(0, 0, 0.5),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		TextTruncate = "AtEnd",
		TextSize = 10,
		TextXAlignment = "Left",
		Text = "",
		RichText = true
	}), "Text")
	
	local DescL = InsertTheme(Create("TextLabel", {
		Font = Enum.Font.Gotham,
		TextColor3 = Theme["Color Dark Text"],
		Size = UDim2.new(1, -20),
		AutomaticSize = "Y",
		Position = UDim2.new(0, 12, 0, 15),
		BackgroundTransparency = 1,
		TextWrapped = true,
		TextSize = 8,
		TextXAlignment = "Left",
		Text = "",
		RichText = true
	}), "DarkText")

	local Frame = Make("Button", Instance, {
		Size = UDim2.new(1, 0, 0, 25),
		AutomaticSize = "Y",
		Name = "Option"
	})Make("Corner", Frame, UDim.new(0, 20))
	
	LabelHolder = Create("Frame", Frame, {
		AutomaticSize = "Y",
		BackgroundTransparency = 1,
		Size = HolderSize,
		Position = UDim2.new(0, 10, 0),
		AnchorPoint = Vector2.new(0, 0)
	}, {
		Create("UIListLayout", {
			SortOrder = "LayoutOrder",
			VerticalAlignment = "Center",
			Padding = UDim.new(0, 2)
		}),
		Create("UIPadding", {
			PaddingBottom = UDim.new(0, 5),
			PaddingTop = UDim.new(0, 5)
		}),
		TitleL,
		DescL,
	})
	
	local Label = {}
	function Label:SetTitle(NewTitle)
		if type(NewTitle) == "string" and NewTitle:gsub(" ", ""):len() > 0 then
			TitleL.Text = NewTitle
		end
	end
	function Label:SetDesc(NewDesc)
		if type(NewDesc) == "string" and NewDesc:gsub(" ", ""):len() > 0 then
			DescL.Visible = true
			DescL.Text = NewDesc
			LabelHolder.Position = UDim2.new(0, 10, 0)
			LabelHolder.AnchorPoint = Vector2.new(0, 0)
		else
			DescL.Visible = false
			DescL.Text = ""
			LabelHolder.Position = UDim2.new(0, 10, 0.5)
			LabelHolder.AnchorPoint = Vector2.new(0, 0.5)
		end
	end
	
	Label:SetTitle(Title)
	Label:SetDesc(Description)
	return Frame, Label
end

local function GetColor(Instance)
	if Instance:IsA("Frame") then
		return "BackgroundColor3"
	elseif Instance:IsA("ImageLabel") then
		return "ImageColor3"
	elseif Instance:IsA("TextLabel") then
		return "TextColor3"
	elseif Instance:IsA("ScrollingFrame") then
		return "ScrollBarImageColor3"
	elseif Instance:IsA("UIStroke") then
		return "Color"
	end
	return ""
end

-- ///////////
function HzsLib:GetIcon(index)
	if type(index) ~= "string" or index:find("rbxassetid://") or #index == 0 then
		return index
	end
	
	local firstMatch = nil
	index = string.lower(index):gsub("lucide", ""):gsub("-", "")
	
	if self.Icons[index] then
	  return self.Icons[index]
	end
	
	for Name, Icon in self.Icons do
		if Name == index then
			return Icon
		elseif not firstMatch and Name:find(index, 1, true) then
			firstMatch = Icon
		end
	end
	
	return firstMatch or index
end

function HzsLib:SetSounds(Enabled, Volume)
	self.SoundEnabled = Enabled ~= false
	if type(Volume) == "number" then
		self.SoundVolume = math.clamp(Volume, 0, 2)
	end
end

function HzsLib:SetSoundId(Name, Id)
	self.Sounds = self.Sounds or {}
	if type(Id) == "number" then Id = "rbxassetid://" .. Id end
	self.Sounds[Name] = Id
end

function HzsLib:SetTheme(NewTheme)
	if not VerifyTheme(NewTheme) then return end
	
	HzsLib.Save.Theme = NewTheme
	SaveJson("redz library V5.json", HzsLib.Save)
	Theme = HzsLib.Themes[NewTheme]
	
	Connection:FireConnection("ThemeChanged", NewTheme)
	table.foreach(HzsLib.Instances, function(_,Val)
		if Val.Type == "Gradient" then
			Val.Instance.Color = Theme["Color Hub 1"]
		elseif Val.Type == "Frame" then
			Val.Instance.BackgroundColor3 = Theme["Color Hub 2"]
		elseif Val.Type == "Stroke" then
			Val.Instance[GetColor(Val.Instance)] = Theme["Color Stroke"]
		elseif Val.Type == "Theme" then
			Val.Instance[GetColor(Val.Instance)] = Theme["Color Theme"]
		elseif Val.Type == "Text" then
			Val.Instance[GetColor(Val.Instance)] = Theme["Color Text"]
		elseif Val.Type == "DarkText" then
			Val.Instance[GetColor(Val.Instance)] = Theme["Color Dark Text"]
		elseif Val.Type == "ScrollBar" then
			Val.Instance[GetColor(Val.Instance)] = Theme["Color Theme"]
		end
	end)
end

function HzsLib:SetScale(NewScale)
	NewScale = ViewportSize.Y / math.clamp(NewScale, 300, 2000)
	UIScale, ScreenGui.Scale.Scale = NewScale, NewScale
end

-- =====================================================================
-- =====================  MAKE WINDOW  =================================
-- =====================================================================
function HzsLib:MakeWindow(Configs)
	local WTitle = Configs[1] or Configs.Name or Configs.Title or "HzsLib"
	local WMiniText = Configs[2] or Configs.SubTitle or "v1.1.0"
	
	Settings.ScriptFile = Configs[3] or Configs.SaveFolder or false
	
	local function LoadFile()
		local File = Settings.ScriptFile
		if type(File) ~= "string" then return end
		if not readfile or not isfile then return end
		local s, r = pcall(isfile, File)
		
		if s and r then
			local s, _Flags = pcall(readfile, File)
			if s and type(_Flags) == "string" then
				local s,r = pcall(function() return HttpService:JSONDecode(_Flags) end)
				Flags = s and r or {}
			end
		end
	end;LoadFile()
	
	local UISizeX, UISizeY = unpack(HzsLib.Save.UISize)
	local MainFrame = InsertTheme(Create("ImageButton", ScreenGui, {
		Size = UDim2.fromOffset(UISizeX, UISizeY),
		Position = UDim2.new(0.5, -UISizeX/2, 0.5, -UISizeY/2),
		BackgroundTransparency = 0.03,
		ClipsDescendants = true,
		Name = "Hub"
	}), "Main")
	Make("Gradient", MainFrame, {
		Rotation = 45
	})MakeDrag(MainFrame)
	
	local MainCorner = Make("Corner", MainFrame, UDim.new(0, 30))
	
	-- contorno da janela
	Create("UIStroke", MainFrame, {
		Color = Color3.fromRGB(180, 160, 220),
		Thickness = 1.5,
		Transparency = 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Name = "WindowStroke"
	})
	
	-- Background
	local BgConfig = HzsLib.Background
	local BgUrl = Configs.Background or Configs.BackgroundUrl or BgConfig.Url
	
	local BackgroundImage = Create("ImageLabel", MainFrame, {
		Name = "Background",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ScaleType = Enum.ScaleType.Crop,
		Image = "",
		ZIndex = 0,
		Visible = false
	})Make("Corner", BackgroundImage, UDim.new(0, 30))
	
	local BackgroundDim = Create("Frame", MainFrame, {
		Name = "BackgroundDim",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = BgConfig.Dim or 0.45,
		BorderSizePixel = 0,
		ZIndex = 0,
		Visible = false
	})Make("Corner", BackgroundDim, UDim.new(0, 30))
	
	local function BgWarn(...) warn("[HzsLib bg]", ...) end
	
	local function IsImage(Body)
		if type(Body) ~= "string" or #Body < 200 then return false end
		local b1, b2, b3, b4 = Body:byte(1, 4)
		return (b1 == 0xFF and b2 == 0xD8)
			or (b1 == 0x89 and b2 == 0x50 and b3 == 0x4E and b4 == 0x47)
			or (b1 == 0x47 and b2 == 0x49 and b3 == 0x46)
			or (b1 == 0x52 and b2 == 0x49 and b3 == 0x46 and b4 == 0x57)
	end
	
	local function Download(Url)
		local Req = (syn and syn.request) or (http and http.request) or http_request or request
		if Req then
			local Ok, Res = pcall(Req, {
				Url = Url,
				Method = "GET",
				Headers = {["User-Agent"] = "Mozilla/5.0"}
			})
			if Ok and type(Res) == "table" then
				if Res.StatusCode == 200 and IsImage(Res.Body) then return Res.Body end
			end
		end
		local Ok, Res = pcall(function() return game:HttpGet(Url) end)
		if Ok and IsImage(Res) then return Res end
		return nil
	end
	
	local function GetBackgroundAsset(Url)
		local GetAsset = getcustomasset or getsynasset
		if type(Url) ~= "string" or #Url == 0 then return end
		if not (writefile and GetAsset) then return end
		
		local Name = Url:match("/([%w_%-]+)%.%w+%?") or Url:match("/([%w_%-]+)%.%w+$") or "bg"
		local File = "redz_bg_" .. Name .. ".jpg"
		
		if isfile and isfile(File) then
			local Ok, Data = pcall(readfile, File)
			if not (Ok and IsImage(Data)) then
				pcall(delfile or function() end, File)
			end
		end
		
		if not (isfile and isfile(File)) then
			local Body = Download(Url)
			if not Body then return end
			writefile(File, Body)
			task.wait(0.15)
		end
		
		local Ok, Asset = pcall(GetAsset, File)
		if not Ok then return end
		return Asset
	end
	
	task.spawn(function()
		local Asset = GetBackgroundAsset(BgUrl)
		if Asset then
			BackgroundImage.Image = Asset
			BackgroundImage.Visible = true
			BackgroundDim.Visible = true
			MainFrame.BackgroundTransparency = 1
		end
	end)
	
	local Components = Create("Folder", MainFrame, {
		Name = "Components"
	})
	
	local DropdownHolder = Create("Folder", ScreenGui, {
		Name = "Dropdown"
	})
	
	local TopBar = Create("Frame", Components, {
		Size = UDim2.new(1, 0, 0, 28),
		BackgroundTransparency = 1,
		Name = "Top Bar"
	})
	
	local Title = InsertTheme(Create("TextLabel", TopBar, {
		Position = UDim2.new(0, 15, 0.5),
		AnchorPoint = Vector2.new(0, 0.5),
		AutomaticSize = "XY",
		Text = WTitle,
		TextXAlignment = "Left",
		TextSize = 12,
		TextColor3 = Theme["Color Text"],
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		Name = "Title"
	}, {
		InsertTheme(Create("TextLabel", {
			Size = UDim2.fromScale(0, 1),
			AutomaticSize = "X",
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(1, 5, 0.9),
			Text = WMiniText,
			TextColor3 = Theme["Color Dark Text"],
			BackgroundTransparency = 1,
			TextXAlignment = "Left",
			TextYAlignment = "Bottom",
			TextSize = 8,
			Font = Enum.Font.Gotham,
			Name = "SubTitle"
		}), "DarkText")
	}), "Text")
	
	local SearchH = 30
	local MainScroll = InsertTheme(Create("ScrollingFrame", Components, {
		Size = UDim2.new(0, HzsLib.Save.TabSize, 1, -TopBar.Size.Y.Offset - 14 - SearchH),
		ScrollBarImageColor3 = Theme["Color Theme"],
		Position = UDim2.new(0, 0, 1, -14),
		AnchorPoint = Vector2.new(0, 1),
		ScrollBarThickness = 1.5,
		BackgroundTransparency = 1,
		ScrollBarImageTransparency = 0.2,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = "Y",
		ScrollingDirection = "Y",
		BorderSizePixel = 0,
		Name = "Tab Scroll"
	}, {
		Create("UIPadding", {
			PaddingLeft = UDim.new(0, 16),
			PaddingRight = UDim.new(0, 10),
			PaddingTop = UDim.new(0, 10),
			PaddingBottom = UDim.new(0, 8)
		}), Create("UIListLayout", {
			Padding = UDim.new(0, 3)
		})
	}), "ScrollBar")
	
	local Containers = Create("Frame", Components, {
		Size = UDim2.new(1, -MainScroll.Size.X.Offset, 1, -TopBar.Size.Y.Offset - 14),
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, 0, 1, -14),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Name = "Containers"
	})
	
	local ControlSize1, ControlSize2 = MakeDrag(Create("ImageButton", MainFrame, {
		Size = UDim2.new(0, 35, 0, 35),
		Position = MainFrame.Size,
		Active = true,
		AnchorPoint = Vector2.new(0.8, 0.8),
		BackgroundTransparency = 1,
		Name = "Control Hub Size"
	})), MakeDrag(Create("ImageButton", MainFrame, {
		Size = UDim2.new(0, 20, 1, -30),
		Position = UDim2.new(0, MainScroll.Size.X.Offset, 1, 0),
		AnchorPoint = Vector2.new(0.5, 1),
		Active = true,
		BackgroundTransparency = 1,
		Name = "Control Tab Size"
	}))
	
	local function ControlSize()
		local Pos1, Pos2 = ControlSize1.Position, ControlSize2.Position
		ControlSize1.Position = UDim2.fromOffset(math.clamp(Pos1.X.Offset, 430, 1000), math.clamp(Pos1.Y.Offset, 200, 500))
		ControlSize2.Position = UDim2.new(0, math.clamp(Pos2.X.Offset, 135, 250), 1, 0)
		
		MainScroll.Size = UDim2.new(0, ControlSize2.Position.X.Offset, 1, -TopBar.Size.Y.Offset - 14 - SearchH)
		Containers.Size = UDim2.new(1, -MainScroll.Size.X.Offset, 1, -TopBar.Size.Y.Offset - 14)
		MainFrame.Size = ControlSize1.Position
	end
	
	ControlSize1:GetPropertyChangedSignal("Position"):Connect(ControlSize)
	ControlSize2:GetPropertyChangedSignal("Position"):Connect(ControlSize)
	
	ConnectSave(ControlSize1, function()
		if not Minimized then
			HzsLib.Save.UISize = {MainFrame.Size.X.Offset, MainFrame.Size.Y.Offset}
			SaveJson("redz library V5.json", HzsLib.Save)
		end
	end)
	
	ConnectSave(ControlSize2, function()
		HzsLib.Save.TabSize = MainScroll.Size.X.Offset
		SaveJson("redz library V5.json", HzsLib.Save)
	end)
	
	-- abertura animada
	do
		local OpenScale = Create("UIScale", MainFrame, {Scale = 0.9})
		local OpenAlpha = Instance.new("NumberValue")
		local AppliedX, AppliedY = 0, 0
		OpenAlpha.Changed:Connect(function(v)
			local sc = 0.9 + 0.1 * v
			OpenScale.Scale = sc
			local ox = (1 - sc) * MainFrame.Size.X.Offset / 2
			local oy = (1 - sc) * MainFrame.Size.Y.Offset / 2
			local P = MainFrame.Position
			MainFrame.Position = UDim2.new(P.X.Scale, P.X.Offset + (ox - AppliedX), P.Y.Scale, P.Y.Offset + (oy - AppliedY))
			AppliedX, AppliedY = ox, oy
		end)
		local OpenTween = TweenService:Create(OpenAlpha, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Value = 1})
		OpenTween.Completed:Connect(function()
			OpenScale:Destroy()
			OpenAlpha:Destroy()
		end)
		OpenTween:Play()
	end
	
	-- sons de clique
	local function HookClick(Obj)
		if not Obj:IsA("GuiButton") then return end
		if Obj.Name == "Hub" or Obj.Name == "AntiClick" or Obj.Name:find("Control") then return end
		if Obj.Parent and Obj.Parent.Name == "ResizeEdges" then return end
		Obj.Activated:Connect(function()
			local Snd = Obj:GetAttribute("Snd")
			if Snd == "None" then return end
			if not Snd and Obj.Parent and Obj.Parent.Name == "Tab Scroll" then Snd = "Tab" end
			PlayClick(Snd or "Click")
		end)
	end
	for _,Obj in ipairs(ScreenGui:GetDescendants()) do HookClick(Obj) end
	ScreenGui.DescendantAdded:Connect(HookClick)
	
	-- resize edges
	local EdgeHolder = Create("Frame", MainFrame, {
		Name = "ResizeEdges",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Active = false,
		ZIndex = 100
	})
	
	local function MakeEdge(Name, Size, Pos, Anchor, DirX, DirY)
		local Handle = Create("TextButton", EdgeHolder, {
			Name = Name,
			Size = Size,
			Position = Pos,
			AnchorPoint = Anchor,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Text = "",
			AutoButtonColor = false,
			Active = true,
			ZIndex = 100
		})
		Make("Corner", Handle, UDim.new(0, 6))
		
		local Resizing = false
		Handle.MouseEnter:Connect(function()
			if not Resizing then CreateTween({Handle, "BackgroundTransparency", 0.85, 0.15}) end
		end)
		Handle.MouseLeave:Connect(function()
			if not Resizing then CreateTween({Handle, "BackgroundTransparency", 1, 0.15}) end
		end)
		
		Handle.InputBegan:Connect(function(Input)
			local T = Input.UserInputType
			if T ~= Enum.UserInputType.MouseButton1 and T ~= Enum.UserInputType.Touch then return end
			
			local function Pointer()
				if T == Enum.UserInputType.Touch then
					return Vector2.new(Input.Position.X, Input.Position.Y)
				end
				return UserInputService:GetMouseLocation()
			end
			
			Resizing = true
			CreateTween({Handle, "BackgroundTransparency", 0.7, 0.1})
			
			local P0 = Pointer()
			local W0, H0 = MainFrame.Size.X.Offset, MainFrame.Size.Y.Offset
			local Pos0 = MainFrame.Position
			
			while Input.UserInputState ~= Enum.UserInputState.End and EdgeHolder.Visible do
				RunService.RenderStepped:Wait()
				local d = (Pointer() - P0) / UIScale
				local nW = DirX ~= 0 and math.clamp(W0 + DirX * d.X, 430, 1000) or W0
				local nH = DirY ~= 0 and math.clamp(H0 + DirY * d.Y, 200, 500) or H0
				
				if DirX < 0 or DirY < 0 then
					MainFrame.Position = UDim2.new(
						Pos0.X.Scale, Pos0.X.Offset + (DirX < 0 and (W0 - nW) or 0),
						Pos0.Y.Scale, Pos0.Y.Offset + (DirY < 0 and (H0 - nH) or 0)
					)
				end
				ControlSize1.Position = UDim2.fromOffset(nW, nH)
			end
			
			Resizing = false
			CreateTween({Handle, "BackgroundTransparency", 1, 0.2})
			HzsLib.Save.UISize = {MainFrame.Size.X.Offset, MainFrame.Size.Y.Offset}
			SaveJson("redz library V5.json", HzsLib.Save)
		end)
	end
	
	MakeEdge("Right",  UDim2.new(0, 8, 1, -68), UDim2.new(1, 0, 0, 34), Vector2.new(1, 0), 1, 0)
	MakeEdge("Left",   UDim2.new(0, 8, 1, -68), UDim2.new(0, 0, 0, 34), Vector2.new(0, 0), -1, 0)
	MakeEdge("Bottom", UDim2.new(1, -68, 0, 8), UDim2.new(0, 34, 1, 0), Vector2.new(0, 1), 0, 1)
	MakeEdge("Top",    UDim2.new(1, -68, 0, 5), UDim2.new(0, 34, 0, 0), Vector2.new(0, 0), 0, -1)
	MakeEdge("BottomLeft", UDim2.new(0, 22, 0, 22), UDim2.new(0, 0, 1, 0), Vector2.new(0, 1), -1, 1)
	MakeEdge("TopRight",   UDim2.new(0, 8, 0, 6), UDim2.new(1, 0, 0, 0), Vector2.new(1, 0), 1, -1)
	MakeEdge("TopLeft",    UDim2.new(0, 8, 0, 6), UDim2.new(0, 0, 0, 0), Vector2.new(0, 0), -1, -1)
	
	local ButtonsFolder = Create("Folder", TopBar, {
		Name = "Buttons"
	})
	
	local CloseButton = Create("ImageButton", {
		Size = UDim2.new(0, 14, 0, 14),
		Position = UDim2.new(1, -10, 0.5),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://10747384394",
		AutoButtonColor = false,
		Name = "Close"
	})
	
	local MinimizeButton = SetProps(CloseButton:Clone(), {
		Position = UDim2.new(1, -35, 0.5),
		Image = "rbxassetid://10734896206",
		Name = "Minimize"
	})

	-- ========== PROFILE BUTTON (top bar) ==========
	local ProfileButton = Create("ImageButton", TopBar, {
		Size = UDim2.new(0, 20, 0, 20),
		Position = UDim2.new(1, -58, 0.5),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://10747373176", -- user icon
		ImageColor3 = Theme["Color Theme"],
		AutoButtonColor = false,
		Name = "ProfileBtn"
	})
	
	SetChildren(ButtonsFolder, {
		CloseButton,
		MinimizeButton
	})
	
	ProfileButton.Parent = TopBar

	CloseButton:SetAttribute("Snd", "Close")
	
	CloseButton.MouseEnter:Connect(function() CreateTween({CloseButton, "ImageColor3", Color3.fromRGB(255, 90, 90), 0.15}) end)
	CloseButton.MouseLeave:Connect(function() CreateTween({CloseButton, "ImageColor3", Theme["Color Text"], 0.15}) end)
	MinimizeButton.MouseEnter:Connect(function() CreateTween({MinimizeButton, "ImageColor3", Color3.fromRGB(200, 200, 200), 0.15}) end)
	MinimizeButton.MouseLeave:Connect(function() CreateTween({MinimizeButton, "ImageColor3", Theme["Color Text"], 0.15}) end)
	ProfileButton.MouseEnter:Connect(function() CreateTween({ProfileButton, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.15}) end)
	ProfileButton.MouseLeave:Connect(function() CreateTween({ProfileButton, "ImageColor3", Theme["Color Theme"], 0.15}) end)
	
	local Minimized, SaveSize, WaitClick
	local Window, FirstTab = {}, false

	-- =====================================================
	-- ============ ACCOUNT / PROFILE PANEL ===============
	-- =====================================================
	local AccountPanelOpen = false
	local AccountOverlay

	local function CloseAccountPanel()
		if AccountOverlay then
			CreateTween({AccountOverlay, "BackgroundTransparency", 1, 0.2, true})
			AccountOverlay:Destroy()
			AccountOverlay = nil
			AccountPanelOpen = false
		end
	end

	local function OpenAccountPanel()
		if AccountPanelOpen then CloseAccountPanel() return end
		AccountPanelOpen = true

		-- overlay que cobre toda a GUI principal
		AccountOverlay = Create("Frame", MainFrame, {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 0.3,
			ZIndex = 50,
			Name = "AccountOverlay",
			Active = true
		})
		Make("Corner", AccountOverlay, UDim.new(0, 30))
		Make("Gradient", AccountOverlay, {Rotation = 135})

		-- Painel central
		local Panel = Create("Frame", AccountOverlay, {
			Size = UDim2.fromOffset(300, 360),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Theme["Color Hub 2"],
			BackgroundTransparency = 0.05,
			ZIndex = 51,
			Name = "AccountPanel"
		})
		Make("Corner", Panel, UDim.new(0, 20))
		Create("UIStroke", Panel, {
			Color = Theme["Color Theme"],
			Thickness = 1.5,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		})
		Make("Gradient", Panel, {Rotation = 45})

		-- Botão fechar (X)
		local PanelClose = Create("ImageButton", Panel, {
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, -10, 0, 10),
			AnchorPoint = Vector2.new(1, 0),
			BackgroundTransparency = 1,
			Image = HzsLib:GetIcon("x"),
			ImageColor3 = Theme["Color Text"],
			ZIndex = 52,
			AutoButtonColor = false
		})
		PanelClose.MouseEnter:Connect(function() CreateTween({PanelClose, "ImageColor3", Color3.fromRGB(255, 80, 80), 0.15}) end)
		PanelClose.MouseLeave:Connect(function() CreateTween({PanelClose, "ImageColor3", Theme["Color Text"], 0.15}) end)
		PanelClose.Activated:Connect(CloseAccountPanel)

		-- Foto de perfil (thumbnail do player)
		local AvatarFrame = Create("Frame", Panel, {
			Size = UDim2.fromOffset(70, 70),
			Position = UDim2.new(0.5, 0, 0, 20),
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundColor3 = Theme["Color Stroke"],
			ZIndex = 52
		})
		Make("Corner", AvatarFrame, UDim.new(0.5, 0))
		Create("UIStroke", AvatarFrame, {
			Color = Theme["Color Theme"],
			Thickness = 2,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		})

		local AvatarImg = Create("ImageLabel", AvatarFrame, {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Image = "rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=100&h=100",
			ZIndex = 53
		})
		Make("Corner", AvatarImg, UDim.new(0.5, 0))

		-- Clique na foto → mostra info do player
		local InfoShown = false
		local InfoFrame
		AvatarFrame.InputBegan:Connect(function(inp)
			if inp.UserInputType ~= Enum.UserInputType.MouseButton1 and inp.UserInputType ~= Enum.UserInputType.Touch then return end
			InfoShown = not InfoShown
			if InfoFrame then
				InfoFrame.Visible = InfoShown
			end
		end)

		-- Nome de exibição (editável)
		local NameHidden = false
		local function MaskedName(name, hidden)
			if hidden then
				local vis = math.min(3, #name)
				return name:sub(1, vis) .. string.rep("•", math.max(0, #name - vis))
			end
			return name
		end

		-- Label + eye toggle para DisplayName
		local DisplayRow = Create("Frame", Panel, {
			Size = UDim2.new(1, -20, 0, 28),
			Position = UDim2.new(0, 10, 0, 100),
			BackgroundTransparency = 1,
			ZIndex = 52
		})
		local DisplayLabel = Create("TextLabel", DisplayRow, {
			Size = UDim2.new(1, -32, 1),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			TextColor3 = Theme["Color Text"],
			TextXAlignment = "Left",
			Text = MaskedName(ProfileData.DisplayName, false),
			ZIndex = 52
		})
		local EyeBtn = Create("ImageButton", DisplayRow, {
			Size = UDim2.fromOffset(18, 18),
			Position = UDim2.new(1, 0, 0.5),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Image = HzsLib:GetIcon("eye"),
			ImageColor3 = Theme["Color Dark Text"],
			ZIndex = 52,
			AutoButtonColor = false
		})
		EyeBtn.Activated:Connect(function()
			NameHidden = not NameHidden
			EyeBtn.Image = NameHidden and HzsLib:GetIcon("eyeoff") or HzsLib:GetIcon("eye")
			DisplayLabel.Text = MaskedName(ProfileData.DisplayName, NameHidden)
		end)

		-- @ username row
		local UsernameHidden = false
		local UsernameRow = Create("Frame", Panel, {
			Size = UDim2.new(1, -20, 0, 22),
			Position = UDim2.new(0, 10, 0, 130),
			BackgroundTransparency = 1,
			ZIndex = 52
		})
		local UsernameLabel = Create("TextLabel", UsernameRow, {
			Size = UDim2.new(1, -32, 1),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextSize = 10,
			TextColor3 = Theme["Color Dark Text"],
			TextXAlignment = "Left",
			Text = MaskedName(ProfileData.Username, false),
			ZIndex = 52
		})
		local EyeBtn2 = Create("ImageButton", UsernameRow, {
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, 0, 0.5),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Image = HzsLib:GetIcon("eye"),
			ImageColor3 = Theme["Color Dark Text"],
			ZIndex = 52,
			AutoButtonColor = false
		})
		EyeBtn2.Activated:Connect(function()
			UsernameHidden = not UsernameHidden
			EyeBtn2.Image = UsernameHidden and HzsLib:GetIcon("eyeoff") or HzsLib:GetIcon("eye")
			UsernameLabel.Text = MaskedName(ProfileData.Username, UsernameHidden)
		end)

		-- Separador
		Create("Frame", Panel, {
			Size = UDim2.new(1, -20, 0, 1),
			Position = UDim2.new(0, 10, 0, 160),
			BackgroundColor3 = Theme["Color Stroke"],
			BackgroundTransparency = 0.5,
			BorderSizePixel = 0,
			ZIndex = 52
		})

		-- Editar DisplayName
		local function MakeEditField(label, yPos, field)
			local row = Create("Frame", Panel, {
				Size = UDim2.new(1, -20, 0, 26),
				Position = UDim2.new(0, 10, 0, yPos),
				BackgroundColor3 = Theme["Color Stroke"],
				BackgroundTransparency = 0.6,
				ZIndex = 52
			})
			Make("Corner", row, UDim.new(0, 10))
			Create("TextLabel", row, {
				Size = UDim2.new(0, 60, 1),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextSize = 9,
				TextColor3 = Theme["Color Dark Text"],
				Text = label,
				TextXAlignment = "Left",
				Position = UDim2.new(0, 8),
				ZIndex = 53
			})
			local tb = Create("TextBox", row, {
				Size = UDim2.new(1, -70, 1),
				Position = UDim2.new(0, 65),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamMedium,
				TextSize = 10,
				TextColor3 = Theme["Color Text"],
				Text = ProfileData[field] or "",
				PlaceholderText = "...",
				PlaceholderColor3 = Theme["Color Dark Text"],
				TextXAlignment = "Left",
				ClearTextOnFocus = false,
				ZIndex = 53
			})
			tb.FocusLost:Connect(function()
				if tb.Text ~= "" then
					ProfileData[field] = tb.Text
					SaveProfile()
					if field == "DisplayName" then
						DisplayLabel.Text = MaskedName(ProfileData.DisplayName, NameHidden)
					elseif field == "Username" then
						UsernameLabel.Text = MaskedName(ProfileData.Username, UsernameHidden)
					end
				end
			end)
			return row
		end

		MakeEditField("Nome:", 170, "DisplayName")
		MakeEditField("@:", 202, "Username")

		-- Password field
		local PwRow = Create("Frame", Panel, {
			Size = UDim2.new(1, -20, 0, 26),
			Position = UDim2.new(0, 10, 0, 234),
			BackgroundColor3 = Theme["Color Stroke"],
			BackgroundTransparency = 0.6,
			ZIndex = 52
		})
		Make("Corner", PwRow, UDim.new(0, 10))
		Create("TextLabel", PwRow, {
			Size = UDim2.new(0, 60, 1),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 9,
			TextColor3 = Theme["Color Dark Text"],
			Text = "Senha:",
			TextXAlignment = "Left",
			Position = UDim2.new(0, 8),
			ZIndex = 53
		})
		local PwBox = Create("TextBox", PwRow, {
			Size = UDim2.new(1, -70, 1),
			Position = UDim2.new(0, 65),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamMedium,
			TextSize = 10,
			TextColor3 = Theme["Color Text"],
			Text = ProfileData.Password or "",
			PlaceholderText = "••••••",
			PlaceholderColor3 = Theme["Color Dark Text"],
			TextXAlignment = "Left",
			ClearTextOnFocus = false,
			ZIndex = 53
		})
		PwBox.FocusLost:Connect(function()
			ProfileData.Password = PwBox.Text
			SaveProfile()
		end)

		-- Info extra (Account info panel ao clicar na foto)
		InfoFrame = Create("Frame", Panel, {
			Size = UDim2.new(1, -20, 0, 60),
			Position = UDim2.new(0, 10, 0, 266),
			BackgroundColor3 = Theme["Color Hub 2"],
			BackgroundTransparency = 0.1,
			ZIndex = 52,
			Visible = false
		})
		Make("Corner", InfoFrame, UDim.new(0, 10))
		Create("UIStroke", InfoFrame, {
			Color = Theme["Color Stroke"],
			Thickness = 1,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		})
		Create("TextLabel", InfoFrame, {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextSize = 9,
			TextColor3 = Theme["Color Dark Text"],
			TextXAlignment = "Left",
			TextYAlignment = "Top",
			Text = "UserId: " .. Player.UserId .. "\nDisplay: " .. Player.DisplayName .. "\nName: " .. Player.Name,
			Position = UDim2.fromOffset(8, 6),
			RichText = true,
			ZIndex = 53
		})

		-- Logout button
		local LogoutBtn = Create("TextButton", Panel, {
			Size = UDim2.new(1, -20, 0, 28),
			Position = UDim2.new(0, 10, 0, 332),
			BackgroundColor3 = Color3.fromRGB(200, 50, 50),
			BackgroundTransparency = 0.1,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Text = "  Sair da conta",
			TextXAlignment = "Left",
			AutoButtonColor = false,
			ZIndex = 52
		})
		Make("Corner", LogoutBtn, UDim.new(0, 10))
		Create("ImageLabel", LogoutBtn, {
			Size = UDim2.fromOffset(14, 14),
			Position = UDim2.new(1, -14, 0.5),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Image = HzsLib:GetIcon("logout"),
			ImageColor3 = Color3.fromRGB(255, 255, 255),
			ZIndex = 53
		})
		LogoutBtn.MouseEnter:Connect(function() CreateTween({LogoutBtn, "BackgroundTransparency", 0.3, 0.15}) end)
		LogoutBtn.MouseLeave:Connect(function() CreateTween({LogoutBtn, "BackgroundTransparency", 0.1, 0.15}) end)
		LogoutBtn.Activated:Connect(function()
			ProfileData.LoggedIn = false
			SaveProfile()
			CloseAccountPanel()
			-- mostrar tela de login
			Window:ShowLoginScreen()
		end)

		-- Animate in
		Panel.Size = UDim2.fromOffset(0, 0)
		CreateTween({Panel, "Size", UDim2.fromOffset(300, 360), 0.25})
	end

	ProfileButton.Activated:Connect(OpenAccountPanel)

	-- =====================================================
	-- ============ LOGIN SCREEN ===========================
	-- =====================================================
	local LoginOverlay

	function Window:ShowLoginScreen()
		if LoginOverlay then return end
		LoginOverlay = Create("Frame", MainFrame, {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 0.1,
			ZIndex = 60,
			Name = "LoginOverlay",
			Active = true
		})
		Make("Corner", LoginOverlay, UDim.new(0, 30))
		Make("Gradient", LoginOverlay, {Rotation = 135})

		local LoginPanel = Create("Frame", LoginOverlay, {
			Size = UDim2.fromOffset(260, 230),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Theme["Color Hub 2"],
			BackgroundTransparency = 0.05,
			ZIndex = 61
		})
		Make("Corner", LoginPanel, UDim.new(0, 20))
		Create("UIStroke", LoginPanel, {
			Color = Theme["Color Theme"],
			Thickness = 1.5,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		})
		Make("Gradient", LoginPanel, {Rotation = 45})

		Create("ImageLabel", LoginPanel, {
			Size = UDim2.fromOffset(32, 32),
			Position = UDim2.new(0.5, 0, 0, 14),
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			Image = HzsLib:GetIcon("lock"),
			ImageColor3 = Theme["Color Theme"],
			ZIndex = 62
		})
		Create("TextLabel", LoginPanel, {
			Size = UDim2.new(1, -20, 0, 20),
			Position = UDim2.new(0, 10, 0, 50),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 13,
			TextColor3 = Theme["Color Text"],
			Text = "Login",
			TextXAlignment = "Center",
			ZIndex = 62
		})

		local function MakeLoginField(label, yPos, isPassword)
			local lbl = Create("TextLabel", LoginPanel, {
				Size = UDim2.new(1, -20, 0, 14),
				Position = UDim2.new(0, 10, 0, yPos),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextSize = 9,
				TextColor3 = Theme["Color Dark Text"],
				Text = label,
				TextXAlignment = "Left",
				ZIndex = 62
			})
			local bg = Create("Frame", LoginPanel, {
				Size = UDim2.new(1, -20, 0, 24),
				Position = UDim2.new(0, 10, 0, yPos + 15),
				BackgroundColor3 = Theme["Color Stroke"],
				BackgroundTransparency = 0.5,
				ZIndex = 62
			})
			Make("Corner", bg, UDim.new(0, 8))
			local tb = Create("TextBox", bg, {
				Size = UDim2.new(1, -10, 1),
				Position = UDim2.new(0, 6),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamMedium,
				TextSize = 10,
				TextColor3 = Theme["Color Text"],
				Text = "",
				PlaceholderText = isPassword and "••••••" or "...",
				PlaceholderColor3 = Theme["Color Dark Text"],
				TextXAlignment = "Left",
				ClearTextOnFocus = false,
				ZIndex = 63
			})
			return tb
		end

		local NameBox = MakeLoginField("Nome de usuário:", 78)
		local PwBox2  = MakeLoginField("Senha:", 120)

		local ErrLabel = Create("TextLabel", LoginPanel, {
			Size = UDim2.new(1, -20, 0, 14),
			Position = UDim2.new(0, 10, 0, 160),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextSize = 9,
			TextColor3 = Color3.fromRGB(255, 80, 80),
			Text = "",
			TextXAlignment = "Center",
			ZIndex = 62
		})

		local LoginBtn = Create("TextButton", LoginPanel, {
			Size = UDim2.new(1, -20, 0, 28),
			Position = UDim2.new(0, 10, 0, 180),
			BackgroundColor3 = Theme["Color Theme"],
			BackgroundTransparency = 0,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Text = "Entrar",
			AutoButtonColor = false,
			ZIndex = 62
		})
		Make("Corner", LoginBtn, UDim.new(0, 10))
		LoginBtn.MouseEnter:Connect(function() CreateTween({LoginBtn, "BackgroundTransparency", 0.3, 0.15}) end)
		LoginBtn.MouseLeave:Connect(function() CreateTween({LoginBtn, "BackgroundTransparency", 0, 0.15}) end)
		local function DoLogin()
			local uname = NameBox.Text
			local pw = PwBox2.Text
			-- validar
			if ProfileData.Password ~= "" and pw ~= ProfileData.Password then
				ErrLabel.Text = "Senha incorreta."
				return
			end
			if uname ~= "" then
				ProfileData.DisplayName = uname
			end
			ProfileData.LoggedIn = true
			SaveProfile()
			if LoginOverlay then
				CreateTween({LoginOverlay, "BackgroundTransparency", 1, 0.2, true})
				LoginOverlay:Destroy()
				LoginOverlay = nil
			end
		end
		LoginBtn.Activated:Connect(DoLogin)

		-- Auto-login se já está logado e sem senha
		if ProfileData.LoggedIn and ProfileData.Password == "" then
			DoLogin()
		end

		LoginPanel.Size = UDim2.fromOffset(0, 0)
		CreateTween({LoginPanel, "Size", UDim2.fromOffset(260, 230), 0.25})
	end

	-- mostrar login se não está logado
	if not ProfileData.LoggedIn then
		task.defer(function() Window:ShowLoginScreen() end)
	end

	-- =====================================================
	-- =========== WINDOW METHODS ==========================
	-- =====================================================
	function Window:CloseBtn()
		local Dialog = Window:Dialog({
			Title = "Close",
			Icon = "power",
			Silent = true,
			Text = "You Want Close Ui?",
			Options = {
				{"Confirm", function()
					ScreenGui:Destroy()
				end},
				{"Cancel"}
			}
		})
	end
	function Window:MinimizeBtn()
		if WaitClick then return end
		WaitClick = true
		
		if Minimized then
			MinimizeButton.Image = "rbxassetid://10734896206"
			CreateTween({MainFrame, "Size", SaveSize, 0.25, true})
			ControlSize1.Visible = true
			ControlSize2.Visible = true
			EdgeHolder.Visible = true
			Minimized = false
		else
			MinimizeButton.Image = "rbxassetid://10734924532"
			SaveSize = MainFrame.Size
			ControlSize1.Visible = false
			ControlSize2.Visible = false
			EdgeHolder.Visible = false
			CreateTween({MainFrame, "Size", UDim2.fromOffset(MainFrame.Size.X.Offset, 28), 0.25, true})
			Minimized = true
		end
		
		WaitClick = false
	end
	function Window:Minimize()
		MainFrame.Visible = not MainFrame.Visible
	end
	function Window:AddMinimizeButton(Configs)
		local Button = MakeDrag(Create("ImageButton", ScreenGui, {
			Size = UDim2.fromOffset(35, 35),
			Position = UDim2.fromScale(0.15, 0.15),
			BackgroundTransparency = 1,
			BackgroundColor3 = Theme["Color Hub 2"],
			AutoButtonColor = false
		}))
		
		local Stroke, Corner
		if Configs.Corner then
			Corner = Make("Corner", Button)
			SetProps(Corner, Configs.Corner)
		end
		if Configs.Stroke then
			Stroke = Make("Stroke", Button)
			SetProps(Stroke, Configs.Corner)
		end
		
		SetProps(Button, Configs.Button)
		Button.Activated:Connect(Window.Minimize)
		
		return {
			Stroke = Stroke,
			Corner = Corner,
			Button = Button
		}
	end
	function Window:Set(Val1, Val2)
		if type(Val1) == "string" and type(Val2) == "string" then
			Title.Text = Val1
			Title.SubTitle.Text = Val2
		elseif type(Val1) == "string" then
			Title.Text = Val1
		end
	end
	function Window:Dialog(Configs)
		if MainFrame:FindFirstChild("Dialog") then return end
		if not Configs.Silent then PlayClick("Dialog") end
		if Minimized then
			Window:MinimizeBtn()
		end
		
		local DTitle = Configs[1] or Configs.Title or "Dialog"
		local DText = Configs[2] or Configs.Text or "This is a Dialog"
		local DOptions = Configs[3] or Configs.Options or {}
		local DIcon = HzsLib:GetIcon(Configs.Icon or Configs[4] or "info")
		
		local Frame = Create("Frame", {
			Active = true,
			Size = UDim2.fromOffset(250 * 1.08, 150 * 1.08),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5)
		}, {
			InsertTheme(Create("TextLabel", {
				Font = Enum.Font.GothamBold,
				Size = UDim2.new(1, 0, 0, 20),
				Text = DTitle,
				TextXAlignment = "Left",
				TextColor3 = Theme["Color Text"],
				TextSize = 15,
				Position = UDim2.fromOffset(38, 5),
				BackgroundTransparency = 1
			}), "Text"),
			Create("ImageLabel", {
				Name = "DialogIcon",
				Size = UDim2.fromOffset(18, 18),
				Position = UDim2.fromOffset(15, 6),
				BackgroundTransparency = 1,
				Image = DIcon,
				ImageColor3 = Theme["Color Theme"]
			}),
			InsertTheme(Create("TextLabel", {
				Font = Enum.Font.GothamMedium,
				Size = UDim2.new(1, -25),
				AutomaticSize = "Y",
				Text = DText,
				TextXAlignment = "Left",
				TextColor3 = Theme["Color Dark Text"],
				TextSize = 12,
				Position = UDim2.fromOffset(15, 25),
				BackgroundTransparency = 1,
				TextWrapped = true
			}), "DarkText")
		})Make("Gradient", Frame, {Rotation = 270})Make("Corner", Frame)
		
		local ButtonsHolder = Create("Frame", Frame, {
			Size = UDim2.fromScale(1, 0.35),
			Position = UDim2.fromScale(0, 1),
			AnchorPoint = Vector2.new(0, 1),
			BackgroundColor3 = Theme["Color Hub 2"],
			BackgroundTransparency = 1
		}, {
			Create("UIListLayout", {
				Padding = UDim.new(0, 10),
				VerticalAlignment = "Center",
				FillDirection = "Horizontal",
				HorizontalAlignment = "Center"
			})
		})
		
		local Screen = InsertTheme(Create("Frame", MainFrame, {
			BackgroundTransparency = 0.6,
			Active = true,
			BackgroundColor3 = Theme["Color Hub 2"],
			Size = UDim2.new(1, 0, 1, 0),
			Name = "Dialog"
		}), "Stroke")
		
		MainCorner:Clone().Parent = Screen
		Frame.Parent = Screen
		CreateTween({Frame, "Size", UDim2.fromOffset(250, 150), 0.2})
		CreateTween({Frame, "Transparency", 0, 0.15})
		CreateTween({Screen, "Transparency", 0.3, 0.15})
		
		local ButtonCount, Dialog = 1, {}
		function Dialog:Button(Configs)
			local Name = Configs[1] or Configs.Name or Configs.Title or ""
			local Callback = Configs[2] or Configs.Callback or function()end
			
			ButtonCount = ButtonCount + 1
			local Button = Make("Button", ButtonsHolder)
			Make("Corner", Button)
			SetProps(Button, {
				Text = Name,
				Font = Enum.Font.GothamBold,
				TextColor3 = Theme["Color Text"],
				TextSize = 12
			})
			
			for _,Button in pairs(ButtonsHolder:GetChildren()) do
				if Button:IsA("TextButton") then
					Button.Size = UDim2.new(1 / ButtonCount, -(((ButtonCount - 1) * 20) / ButtonCount), 0, 32)
				end
			end
			Button.Activated:Connect(Dialog.Close)
			Button.Activated:Connect(Callback)
		end
		function Dialog:Close()
			CreateTween({Frame, "Size", UDim2.fromOffset(250 * 1.08, 150 * 1.08), 0.2})
			CreateTween({Screen, "Transparency", 1, 0.15})
			CreateTween({Frame, "Transparency", 1, 0.15, true})
			Screen:Destroy()
		end
		table.foreach(DOptions, function(_,Button)
			Dialog:Button(Button)
		end)
		return Dialog
	end
	function Window:SelectTab(TabSelect)
		if type(TabSelect) == "number" then
			HzsLib.Tabs[TabSelect].func:Enable()
		else
			for _,Tab in pairs(HzsLib.Tabs) do
				if Tab.Cont == TabSelect.Cont then
					Tab.func:Enable()
				end
			end
		end
	end
	
	local ContainerList = {}
	local TabList = {}
	local SearchQuery = ""
	
	-- barra de pesquisa
	local GlobalSearch = Create("Frame", Components, {
		Size = UDim2.new(0, MainScroll.Size.X.Offset - 26, 0, 22),
		Position = UDim2.new(0, 16, 0, TopBar.Size.Y.Offset + 4),
		AnchorPoint = Vector2.new(0, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.65,
		Name = "SearchBar"
	})Make("Corner", GlobalSearch, UDim.new(0, 20))
	MainScroll:GetPropertyChangedSignal("Size"):Connect(function()
		GlobalSearch.Size = UDim2.new(0, MainScroll.Size.X.Offset - 26, 0, 22)
	end)
	Create("UIStroke", GlobalSearch, {
		Color = Color3.fromRGB(180, 160, 220),
		Thickness = 1,
		Transparency = 0.4,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	})
	
	Create("ImageLabel", GlobalSearch, {
		Size = UDim2.new(0, 13, 0, 13),
		Position = UDim2.new(0, 7, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://92345384671606",
		Name = "SearchIcon"
	})
	
	local GlobalSearchBox = Create("TextBox", GlobalSearch, {
		Size = UDim2.new(1, -28, 1, 0),
		Position = UDim2.new(0, 25, 0, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		TextSize = 10,
		Text = "",
		PlaceholderText = "Pesquisar...",
		PlaceholderColor3 = Color3.fromRGB(150, 140, 160),
		TextColor3 = Theme["Color Text"],
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ClearTextOnFocus = false,
		Name = "SearchBox"
	})
	
	local function SearchText(Obj)
		return (tostring(Obj.Text):gsub("<[^>]+>", "")):lower()
	end
	
	local function HasText(Obj, Query)
		local function Check(O)
			return (O:IsA("TextLabel") or O:IsA("TextButton")) and SearchText(O):find(Query, 1, true) ~= nil
		end
		if Check(Obj) then return true end
		for _,D in ipairs(Obj:GetDescendants()) do
			if Check(D) then return true end
		end
		return false
	end
	
	local function SetHidden(Obj, Hide)
		if Hide then
			if Obj.Visible then
				Obj.Visible = false
				Obj:SetAttribute("SearchHidden", true)
			end
		elseif Obj:GetAttribute("SearchHidden") then
			Obj:SetAttribute("SearchHidden", nil)
			Obj.Visible = true
		end
	end
	
	local function FilterContainer(Cont, Query)
		local Matches = 0
		local CurSection, SectionShown
		local function CloseSection()
			if CurSection then SetHidden(CurSection, not SectionShown) end
		end
		for _,Child in ipairs(Cont:GetChildren()) do
			if Child:IsA("GuiObject") and (Child.Visible or Child:GetAttribute("SearchHidden")) then
				if Query == "" then
					SetHidden(Child, false)
				elseif Child:GetAttribute("IsSection") then
					CloseSection()
					CurSection = Child
					SectionShown = HasText(Child, Query)
					if SectionShown then Matches = Matches + 1 end
				else
					local Found = HasText(Child, Query)
					SetHidden(Child, not Found)
					if Found then
						Matches = Matches + 1
						SectionShown = true
					end
				end
			end
		end
		CloseSection()
		return Matches
	end
	
	local function ApplyFilter()
		local Query = SearchQuery
		local Current, CurrentCount, FirstMatch
		for _,T in ipairs(TabList) do
			if T.Cont then
				local Count = FilterContainer(T.Cont, Query)
				if T.Button then SetHidden(T.Button, Query ~= "" and Count == 0) end
				if Query ~= "" and Count > 0 and not FirstMatch then FirstMatch = T end
				if T.Cont.Parent == Containers then Current, CurrentCount = T, Count end
			end
		end
		if Query ~= "" and Current and CurrentCount == 0 and FirstMatch then
			FirstMatch.Tab:Enable()
			Current = FirstMatch
		end
		if Current then Current.Cont.CanvasPosition = Vector2.new(0, 0) end
	end
	
	GlobalSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		SearchQuery = GlobalSearchBox.Text:lower()
		ApplyFilter()
	end)

	-- =====================================================
	-- =================== MAKE TAB ========================
	-- =====================================================
	function Window:MakeTab(paste, Configs)
		if type(paste) == "table" then Configs = paste end
		local TName = Configs[1] or Configs.Title or "Tab!"
		local TIcon = Configs[2] or Configs.Icon or ""
		
		TIcon = HzsLib:GetIcon(TIcon)
		if not TIcon:find("rbxassetid://") or TIcon:gsub("rbxassetid://", ""):len() < 6 then
			TIcon = false
		end
		
		local TabSelect = Make("Button", MainScroll, {
			Size = UDim2.new(1, 0, 0, 20)
		})Make("Corner", TabSelect)
		
		local LabelTitle = InsertTheme(Create("TextLabel", TabSelect, {
			Size = UDim2.new(1, TIcon and -25 or -15, 1),
			Position = UDim2.fromOffset(TIcon and 25 or 15),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamMedium,
			Text = TName,
			TextColor3 = Theme["Color Text"],
			TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTransparency = (FirstTab and 0.3) or 0,
			TextTruncate = "AtEnd"
		}), "Text")
		
		local LabelIcon = InsertTheme(Create("ImageLabel", TabSelect, {
			Position = UDim2.new(0, 8, 0.5),
			Size = UDim2.new(0, 13, 0, 13),
			AnchorPoint = Vector2.new(0, 0.5),
			Image = TIcon or "",
			BackgroundTransparency = 1,
			ImageTransparency = (FirstTab and 0.3) or 0
		}), "Text")
		
		local Selected = InsertTheme(Create("Frame", TabSelect, {
			Size = FirstTab and UDim2.new(0, 4, 0, 4) or UDim2.new(0, 4, 0, 13),
			Position = UDim2.new(0, 1, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Theme["Color Theme"],
			BackgroundTransparency = FirstTab and 1 or 0,
			Visible = false
		}), "Theme")Make("Corner", Selected, UDim.new(0.5, 0))
		
		local Container = InsertTheme(Create("ScrollingFrame", {
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 1),
			AnchorPoint = Vector2.new(0, 1),
			ScrollBarThickness = 1.5,
			BackgroundTransparency = 1,
			ScrollBarImageTransparency = 0.2,
			ScrollBarImageColor3 = Theme["Color Theme"],
			AutomaticCanvasSize = "Y",
			ScrollingDirection = "Y",
			BorderSizePixel = 0,
			CanvasSize = UDim2.new(),
			Name = ("Container %i [ %s ]"):format(#ContainerList + 1, TName)
		}, {
			Create("UIPadding", {
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 16),
				PaddingTop = UDim.new(0, 10),
				PaddingBottom = UDim.new(0, 8)
			}), Create("UIListLayout", {
				Padding = UDim.new(0, 5)
			})
		}), "ScrollBar")
		
		table.insert(ContainerList, Container)
		
		if not FirstTab then Container.Parent = Containers end
		
		local Tab = { Enabled = (FirstTab == false) }
		
		local function Tabs()
			if Container.Parent then return end
			for _,Frame in pairs(ContainerList) do
				if Frame:IsA("ScrollingFrame") and Frame ~= Container then
					Frame.Parent = nil
				end
			end
			Container.Parent = Containers
			Container.Size = UDim2.new(1, 0, 1, 150)
			table.foreach(HzsLib.Tabs, function(_,Tab)
				if Tab.Cont ~= Container then
					Tab.func:Disable()
				end
			end)
			Tab.Enabled = true
			CreateTween({Container, "Size", UDim2.new(1, 0, 1, 0), 0.3})
			CreateTween({LabelTitle, "TextTransparency", 0, 0.35})
			CreateTween({LabelIcon, "ImageTransparency", 0, 0.35})
			CreateTween({Selected, "Size", UDim2.new(0, 4, 0, 13), 0.35})
			CreateTween({Selected, "BackgroundTransparency", 0, 0.35})
		end
		TabSelect.Activated:Connect(Tabs)
		
		FirstTab = true
		table.insert(HzsLib.Tabs, {TabInfo = {Name = TName, Icon = TIcon}, func = Tab, Cont = Container})
		table.insert(TabList, {Cont = Container, Button = TabSelect, Tab = Tab})
		Container.ChildAdded:Connect(function()
			if SearchQuery ~= "" then task.defer(ApplyFilter) end
		end)
		Tab.Cont = Container
		
		function Tab:Disable()
		  self.Enabled = false
			Container.Parent = nil
			CreateTween({LabelTitle, "TextTransparency", 0.3, 0.35})
			CreateTween({LabelIcon, "ImageTransparency", 0.3, 0.35})
			CreateTween({Selected, "Size", UDim2.new(0, 4, 0, 4), 0.35})
			CreateTween({Selected, "BackgroundTransparency", 1, 0.35})
		end
		function Tab:Enable()
			Tabs()
		end
		function Tab:Visible(Bool)
			Funcs:ToggleVisible(TabSelect, Bool)
			Funcs:ToggleParent(Container, Bool, Containers)
		end
		function Tab:Destroy() TabSelect:Destroy() Container:Destroy() end
		
		-- ============ SECTION ============
		function Tab:AddSection(Configs)
			local SectionName = type(Configs) == "string" and Configs or Configs[1] or Configs.Name or Configs.Title or Configs.Section
			
			local SectionFrame = Create("Frame", Container, {
				Size = UDim2.new(1, 0, 0, 20),
				BackgroundTransparency = 1,
				Name = "Option"
			})
			SectionFrame:SetAttribute("IsSection", true)
			
			local SectionLabel = InsertTheme(Create("TextLabel", SectionFrame, {
				Font = Enum.Font.GothamBold,
				Text = SectionName,
				TextColor3 = Theme["Color Text"],
				Size = UDim2.new(1, -25, 1, 0),
				Position = UDim2.new(0, 5),
				BackgroundTransparency = 1,
				TextTruncate = "AtEnd",
				TextSize = 14,
				TextXAlignment = "Left"
			}), "Text")
			
			local Section = {}
			table.insert(HzsLib.Options, {type = "Section", Name = SectionName, func = Section})
			function Section:Visible(Bool)
				if Bool == nil then SectionFrame.Visible = not SectionFrame.Visible return end
				SectionFrame.Visible = Bool
			end
			function Section:Destroy()
				SectionFrame:Destroy()
			end
			function Section:Set(New)
				if New then
					SectionLabel.Text = GetStr(New)
				end
			end
			return Section
		end

		-- ============ TAG ============
		function Tab:Tag(Configs)
			local TagTitle = Configs.Title or Configs[1] or "Tag"
			local TagIcon  = Configs.Icon or Configs[2] or ""
			local TagColor = Configs.Color or Theme["Color Theme"]

			local TagFrame = Create("Frame", Container, {
				Size = UDim2.new(1, 0, 0, 24),
				BackgroundTransparency = 1,
				Name = "Option"
			})

			local Pill = Create("Frame", TagFrame, {
				Size = UDim2.new(0, 0, 0, 18),
				AutomaticSize = "X",
				Position = UDim2.new(0, 0, 0.5),
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = TagColor,
				BackgroundTransparency = 0.3,
				Name = "TagPill"
			})
			Make("Corner", Pill, UDim.new(0.5, 0))
			Create("UIStroke", Pill, {
				Color = TagColor,
				Thickness = 1,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			})
			Create("UIPadding", Pill, {
				PaddingLeft = UDim.new(0, 6),
				PaddingRight = UDim.new(0, 6)
			})
			Create("UIListLayout", Pill, {
				FillDirection = "Horizontal",
				VerticalAlignment = "Center",
				Padding = UDim.new(0, 4)
			})

			local IconId = HzsLib:GetIcon(TagIcon)
			if IconId and type(IconId) == "string" and IconId:find("rbxassetid://") then
				Create("ImageLabel", Pill, {
					Size = UDim2.fromOffset(10, 10),
					BackgroundTransparency = 1,
					Image = IconId,
					ImageColor3 = Color3.fromRGB(255,255,255),
					Name = "TagIcon",
					LayoutOrder = 0
				})
			end

			Create("TextLabel", Pill, {
				BackgroundTransparency = 1,
				AutomaticSize = "XY",
				Font = Enum.Font.GothamBold,
				TextSize = 9,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Text = TagTitle,
				LayoutOrder = 1
			})

			local TagObj = {}
			function TagObj:Visible(B) Funcs:ToggleVisible(TagFrame, B) end
			function TagObj:Destroy() TagFrame:Destroy() end
			function TagObj:SetColor(C) Pill.BackgroundColor3 = C end
			function TagObj:SetTitle(T) Pill:FindFirstChildOfClass("TextLabel").Text = T end
			return TagObj
		end

		-- ============ PARAGRAPH ============
		function Tab:AddParagraph(Configs)
			local PName = Configs[1] or Configs.Title or "Paragraph"
			local PDesc = Configs[2] or Configs.Text or ""
			
			local Frame, LabelFunc = ButtonFrame(Container, PName, PDesc, UDim2.new(1, -20))
			
			local Paragraph = {}
			function Paragraph:Visible(...) Funcs:ToggleVisible(Frame, ...) end
			function Paragraph:Destroy() Frame:Destroy() end
			function Paragraph:SetTitle(Val) LabelFunc:SetTitle(GetStr(Val)) end
			function Paragraph:SetDesc(Val) LabelFunc:SetDesc(GetStr(Val)) end
			function Paragraph:Set(Val1, Val2)
				if Val1 and Val2 then
					LabelFunc:SetTitle(GetStr(Val1))
					LabelFunc:SetDesc(GetStr(Val2))
				elseif Val1 then
					LabelFunc:SetDesc(GetStr(Val1))
				end
			end
			return Paragraph
		end

		-- ============ BUTTON ============
		function Tab:AddButton(Configs)
			local BName = Configs[1] or Configs.Name or Configs.Title or "Button!"
			local BDescription = Configs.Desc or Configs.Description or ""
			local Callback = Funcs:GetCallback(Configs, 2)
			
			local FButton, LabelFunc = ButtonFrame(Container, BName, BDescription, UDim2.new(1, -20))
			
			local ButtonIcon = Create("ImageLabel", FButton, {
				Size = UDim2.new(0, 14, 0, 14),
				Position = UDim2.new(1, -10, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundTransparency = 1,
				Image = "rbxassetid://10709791437"
			})
			
			FButton.Activated:Connect(function()
				Funcs:FireCallback(Callback)
			end)
			
			local Button = {}
			function Button:Visible(...) Funcs:ToggleVisible(FButton, ...) end
			function Button:Destroy() FButton:Destroy() end
			function Button:Callback(...) Funcs:InsertCallback(Callback, ...) end
			function Button:Set(Val1, Val2)
				if type(Val1) == "string" and type(Val2) == "string" then
					LabelFunc:SetTitle(Val1)
					LabelFunc:SetDesc(Val2)
				elseif type(Val1) == "string" then
					LabelFunc:SetTitle(Val1)
				elseif type(Val1) == "function" then
					Callback = Val1
				end
			end
			return Button
		end

		-- ============ TOGGLE ============
		function Tab:AddToggle(Configs)
			local TName = Configs[1] or Configs.Name or Configs.Title or "Toggle"
			local TDesc = Configs.Desc or Configs.Description or ""
			local Callback = Funcs:GetCallback(Configs, 3)
			local Flag = Configs[4] or Configs.Flag or false
			local Default = Configs[2] or Configs.Default or false
			if CheckFlag(Flag) then Default = GetFlag(Flag) end
			
			local Button, LabelFunc = ButtonFrame(Container, TName, TDesc, UDim2.new(1, -38))
			
			local ToggleHolder = InsertTheme(Create("Frame", Button, {
				Size = UDim2.new(0, 35, 0, 18),
				Position = UDim2.new(1, -10, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = Theme["Color Stroke"]
			}), "Stroke")Make("Corner", ToggleHolder, UDim.new(0.5, 0))
			
			local Slider = Create("Frame", ToggleHolder, {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.8, 0, 0.8, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5)
			})
			
			local Toggle = InsertTheme(Create("Frame", Slider, {
				Size = UDim2.new(0, 12, 0, 12),
				Position = UDim2.new(0, 0, 0.5),
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = Theme["Color Theme"]
			}), "Theme")Make("Corner", Toggle, UDim.new(0.5, 0))
			
			local WaitClick
			local function SetToggle(Val)
				if WaitClick then return end
				WaitClick, Default = true, Val
				SetFlag(Flag, Default)
				Funcs:FireCallback(Callback, Default)
				if Default then
					CreateTween({Toggle, "Position", UDim2.new(1, 0, 0.5), 0.25})
					CreateTween({Toggle, "BackgroundTransparency", 0, 0.25})
					CreateTween({Toggle, "AnchorPoint", Vector2.new(1, 0.5), 0.25, Wait or false})
				else
					CreateTween({Toggle, "Position", UDim2.new(0, 0, 0.5), 0.25})
					CreateTween({Toggle, "BackgroundTransparency", 0.8, 0.25})
					CreateTween({Toggle, "AnchorPoint", Vector2.new(0, 0.5), 0.25, Wait or false})
				end
				WaitClick = false
			end;task.spawn(SetToggle, Default)
			
			Button:SetAttribute("Snd", "Toggle")
			Button.Activated:Connect(function()
				SetToggle(not Default)
			end)
			
			local Toggle = {}
			function Toggle:Visible(...) Funcs:ToggleVisible(Button, ...) end
			function Toggle:Destroy() Button:Destroy() end
			function Toggle:Callback(...) Funcs:InsertCallback(Callback, ...)() end
			function Toggle:Set(Val1, Val2)
				if type(Val1) == "string" and type(Val2) == "string" then
					LabelFunc:SetTitle(Val1)
					LabelFunc:SetDesc(Val2)
				elseif type(Val1) == "string" then
					LabelFunc:SetTitle(Val1, false, true)
				elseif type(Val1) == "boolean" then
					if WaitClick and Val2 then
						repeat task.wait() until not WaitClick
					end
					task.spawn(SetToggle, Val1)
				elseif type(Val1) == "function" then
					Callback = Val1
				end
			end
			return Toggle
		end

		-- ============ COLOR PICKER ============
		function Tab:AddColorPicker(Configs)
			local CName = Configs.Title or Configs[1] or Configs.Name or "Color Picker"
			local CDesc = Configs.Desc or Configs.Description or ""
			local DefaultColor = Configs.Default or Configs.Color or Color3.fromRGB(255, 100, 180)
			local Callback = Funcs:GetCallback(Configs, 2)
			local Flag = Configs.Flag or false
			if CheckFlag(Flag) then
				local flagVal = GetFlag(Flag)
				if type(flagVal) == "table" then
					DefaultColor = Color3.fromRGB(flagVal[1], flagVal[2], flagVal[3])
				end
			end

			local Button, LabelFunc = ButtonFrame(Container, CName, CDesc, UDim2.new(1, -50))

			-- Preview swatch
			local SwatchHolder = Create("TextButton", Button, {
				Size = UDim2.fromOffset(32, 20),
				Position = UDim2.new(1, -10, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = DefaultColor,
				Text = "",
				AutoButtonColor = false,
				Name = "ColorSwatch"
			})
			Make("Corner", SwatchHolder, UDim.new(0, 8))
			Create("UIStroke", SwatchHolder, {
				Color = Color3.fromRGB(200, 200, 200),
				Thickness = 1,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			})

			local CurrentColor = DefaultColor
			local PickerOpen = false
			local PickerFrame

			local function FireColor(c)
				CurrentColor = c
				SwatchHolder.BackgroundColor3 = c
				SetFlag(Flag, {math.round(c.R*255), math.round(c.G*255), math.round(c.B*255)})
				Funcs:FireCallback(Callback, c)
			end

			local function CloseColorPicker()
				if PickerFrame then
					PickerFrame:Destroy()
					PickerFrame = nil
				end
				PickerOpen = false
			end

			local function OpenColorPicker()
				if PickerOpen then CloseColorPicker() return end
				PickerOpen = true

				-- Simple HSV picker overlay
				local Overlay = Create("Frame", ScreenGui, {
					Size = UDim2.fromOffset(220, 200),
					Position = UDim2.fromOffset(
						math.clamp(SwatchHolder.AbsolutePosition.X / UIScale, 10, 600),
						math.clamp(SwatchHolder.AbsolutePosition.Y / UIScale + 24, 10, 500)
					),
					BackgroundColor3 = Theme["Color Hub 2"],
					BackgroundTransparency = 0.05,
					ZIndex = 100,
					Name = "ColorPicker",
					Active = true
				})
				Make("Corner", Overlay, UDim.new(0, 12))
				Create("UIStroke", Overlay, {
					Color = Theme["Color Theme"],
					Thickness = 1.5,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				})
				PickerFrame = Overlay

				local H, S, V = Color3.toHSV(CurrentColor)

				-- SV box (gradient)
				local SVBox = Create("ImageButton", Overlay, {
					Size = UDim2.fromOffset(190, 110),
					Position = UDim2.fromOffset(15, 15),
					BackgroundColor3 = Color3.fromHSV(H, 1, 1),
					AutoButtonColor = false,
					ZIndex = 101,
					Name = "SVBox"
				})
				Make("Corner", SVBox, UDim.new(0, 6))
				-- white to transparent gradient (saturation)
				Create("UIGradient", SVBox, {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
					}),
					Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(1, 1)
					})
				})
				local VGrad = Create("Frame", SVBox, {
					Size = UDim2.fromScale(1,1),
					BackgroundTransparency = 1,
					ZIndex = 102
				})
				Create("UIGradient", VGrad, {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))
					}),
					Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(1, 0)
					}),
					Rotation = 90
				})

				-- SV cursor
				local SVCursor = Create("Frame", SVBox, {
					Size = UDim2.fromOffset(10, 10),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255,255,255),
					Position = UDim2.fromScale(S, 1-V),
					ZIndex = 103
				})
				Make("Corner", SVCursor, UDim.new(0.5, 0))
				Create("UIStroke", SVCursor, {
					Color = Color3.fromRGB(0,0,0),
					Thickness = 1.5,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				})

				-- Hue bar
				local HueBar = Create("ImageButton", Overlay, {
					Size = UDim2.fromOffset(190, 14),
					Position = UDim2.fromOffset(15, 132),
					BackgroundColor3 = Color3.fromRGB(255,0,0),
					AutoButtonColor = false,
					ZIndex = 101,
					Name = "HueBar"
				})
				Make("Corner", HueBar, UDim.new(0.5, 0))
				local hueColors = {}
				for i = 0, 6 do
					local t = i / 6
					hueColors[#hueColors+1] = ColorSequenceKeypoint.new(t, Color3.fromHSV(t, 1, 1))
				end
				Create("UIGradient", HueBar, {
					Color = ColorSequence.new(hueColors)
				})

				local HueCursor = Create("Frame", HueBar, {
					Size = UDim2.new(0, 6, 1, 4),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255,255,255),
					Position = UDim2.fromScale(H, 0.5),
					ZIndex = 102
				})
				Make("Corner", HueCursor, UDim.new(0.5, 0))
				Create("UIStroke", HueCursor, {
					Color = Color3.fromRGB(0,0,0),
					Thickness = 1,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				})

				local function UpdateColor()
					local newC = Color3.fromHSV(H, S, V)
					SVBox.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
					SVCursor.Position = UDim2.fromScale(S, 1-V)
					HueCursor.Position = UDim2.fromScale(H, 0.5)
					FireColor(newC)
				end

				local function HueDrag(inp)
					local rel = (inp.Position.X - HueBar.AbsolutePosition.X) / HueBar.AbsoluteSize.X
					H = math.clamp(rel, 0, 1)
					UpdateColor()
				end
				local function SVDrag(inp)
					local rx = (inp.Position.X - SVBox.AbsolutePosition.X) / SVBox.AbsoluteSize.X
					local ry = (inp.Position.Y - SVBox.AbsolutePosition.Y) / SVBox.AbsoluteSize.Y
					S = math.clamp(rx, 0, 1)
					V = math.clamp(1 - ry, 0, 1)
					UpdateColor()
				end

				local function MakeDragInput(obj, fn)
					obj.InputBegan:Connect(function(inp)
						if inp.UserInputType ~= Enum.UserInputType.MouseButton1 and inp.UserInputType ~= Enum.UserInputType.Touch then return end
						fn(inp)
						local conn
						conn = RunService.Heartbeat:Connect(function()
							if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
								conn:Disconnect()
								return
							end
							fn(UserInputService:GetInputObjectsAtPosition(UserInputService:GetMouseLocation())[1] or inp)
							local fake = {Position = Vector3.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y, 0)}
							fn(fake)
						end)
					end)
				end

				MakeDragInput(HueBar, HueDrag)
				MakeDragInput(SVBox, SVDrag)
				MakeDragInput(VGrad, SVDrag)

				-- Preview + hex input
				local PreviewRow = Create("Frame", Overlay, {
					Size = UDim2.fromOffset(190, 26),
					Position = UDim2.fromOffset(15, 154),
					BackgroundColor3 = Theme["Color Stroke"],
					BackgroundTransparency = 0.5,
					ZIndex = 101
				})
				Make("Corner", PreviewRow, UDim.new(0, 8))
				local PreviewSwatch = Create("Frame", PreviewRow, {
					Size = UDim2.fromOffset(20, 18),
					Position = UDim2.new(0, 4, 0.5),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = CurrentColor,
					ZIndex = 102
				})
				Make("Corner", PreviewSwatch, UDim.new(0, 4))
				Connection.ThemeChanged:Connect(function() end)

				-- Close button
				local ClosePicker = Create("TextButton", Overlay, {
					Size = UDim2.fromOffset(14, 14),
					Position = UDim2.new(1, -6, 0, 6),
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = 1,
					Text = "✕",
					Font = Enum.Font.GothamBold,
					TextSize = 10,
					TextColor3 = Theme["Color Text"],
					ZIndex = 102,
					AutoButtonColor = false
				})
				ClosePicker.Activated:Connect(CloseColorPicker)

				UpdateColor()
			end

			SwatchHolder.Activated:Connect(OpenColorPicker)
			Button.Activated:Connect(OpenColorPicker)

			local ColorPicker = {}
			function ColorPicker:Visible(...) Funcs:ToggleVisible(Button, ...) end
			function ColorPicker:Destroy() CloseColorPicker() Button:Destroy() end
			function ColorPicker:Set(c)
				if typeof(c) == "Color3" then
					CurrentColor = c
					FireColor(c)
					H, S, V = Color3.toHSV(c)
				elseif type(c) == "function" then
					Callback = c
				end
			end
			function ColorPicker:GetColor() return CurrentColor end
			return ColorPicker
		end

		-- ============ CODE ============
		function Tab:Code(Configs)
			local CodeTitle  = Configs.Title or Configs[1] or "Code"
			local CodeText   = Configs.Code or Configs[2] or ""
			local CodeSize   = Configs.CodeSize or 13
			local CanCopy    = Configs.CanCopied ~= false
			local CodeHeight = Configs.Height or UDim.new(0, 120)
			local OnCopyCB   = Configs.OnCopy
			local UserTheme  = Configs.CodeTheme or {}

			-- Lua syntax highlight
			local LuaKeywords = {
				["local"] = true, ["function"] = true, ["end"] = true, ["if"] = true,
				["then"] = true, ["else"] = true, ["elseif"] = true, ["for"] = true,
				["while"] = true, ["do"] = true, ["repeat"] = true, ["until"] = true,
				["return"] = true, ["break"] = true, ["not"] = true, ["and"] = true,
				["or"] = true, ["in"] = true, ["nil"] = true, ["true"] = true, ["false"] = true
			}
			local RbxClasses = {
				game = true, workspace = true, script = true, Enum = true,
				Instance = true, Vector3 = true, Vector2 = true, CFrame = true,
				Color3 = true, UDim2 = true, UDim = true, TweenInfo = true,
				BrickColor = true, Ray = true, Region3 = true
			}

			local CT = {
				numbers       = UserTheme.numbers      or Color3.fromHex("#FAB387"),
				boolean       = UserTheme.boolean      or Color3.fromHex("#FAB387"),
				operator      = UserTheme.operator     or Color3.fromHex("#94E2D5"),
				lua           = UserTheme.lua          or Color3.fromHex("#CBA6F7"),
				rbx           = UserTheme.rbx          or Color3.fromHex("#F38BA8"),
				str           = UserTheme.str          or Color3.fromHex("#A6E3A1"),
				comment       = UserTheme.comment      or Color3.fromHex("#9399B2"),
				null          = UserTheme.null         or Color3.fromHex("#F38BA8"),
				call          = UserTheme.call         or Color3.fromHex("#89B4FA"),
				self_call     = UserTheme.self_call    or Color3.fromHex("#89B4FA"),
				local_property= UserTheme.local_property or Color3.fromHex("#CBA6F7"),
				default       = Color3.fromHex("#CDD6F4")
			}

			local function RGBHex(c)
				return string.format("rgb(%d,%d,%d)", math.round(c.R*255), math.round(c.G*255), math.round(c.B*255))
			end

			local function HighlightLine(line)
				local result = ""
				local i = 1
				local len = #line

				local function advance(n) i = i + (n or 1) end
				local function peek(offset) return line:sub(i+(offset or 0), i+(offset or 0)) end
				local function current() return line:sub(i,i) end
				local function wrap(text, color)
					local esc = text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
					return '<font color="' .. RGBHex(color) .. '">' .. esc .. '</font>'
				end

				while i <= len do
					local c = current()

					-- comment
					if c == "-" and peek(1) == "-" then
						local rest = line:sub(i)
						result = result .. wrap(rest, CT.comment)
						break

					-- string "..."
					elseif c == '"' or c == "'" then
						local q = c
						local j = i + 1
						while j <= len and line:sub(j,j) ~= q do
							if line:sub(j,j) == "\\" then j = j + 1 end
							j = j + 1
						end
						local s = line:sub(i, j)
						result = result .. wrap(s, CT.str)
						i = j + 1

					-- number
					elseif c:match("%d") or (c == "." and peek(1):match("%d")) then
						local j = i
						while j <= len and line:sub(j,j):match("[%d%._xXaAbBcCdDeEfF]") do j = j + 1 end
						result = result .. wrap(line:sub(i, j-1), CT.numbers)
						i = j

					-- identifier / keyword
					elseif c:match("[%a_]") then
						local j = i
						while j <= len and line:sub(j,j):match("[%w_]") do j = j + 1 end
						local word = line:sub(i, j-1)
						local color
						if word == "nil" then
							color = CT.null
						elseif word == "true" or word == "false" then
							color = CT.boolean
						elseif LuaKeywords[word] then
							color = CT.lua
						elseif RbxClasses[word] then
							color = CT.rbx
						elseif line:sub(j, j) == "(" then
							if line:sub(i-1, i-1) == ":" then
								color = CT.self_call
							else
								color = CT.call
							end
						elseif line:sub(i-1, i-1) == "." or line:sub(i-1, i-1) == ":" then
							color = CT.local_property
						else
							color = CT.default
						end
						result = result .. wrap(word, color)
						i = j

					-- operator
					elseif c:match("[%+%-%*/%%^#<>=~%(%){}%[%]%.%,%;%:]") then
						result = result .. wrap(c, CT.operator)
						advance()

					else
						result = result .. c:gsub("&","&amp;"):gsub("<","&lt;"):gsub(">","&gt;")
						advance()
					end
				end

				return result
			end

			-- Build highlighted code
			local rawCode = CodeText:gsub("\\n", "\n")
			local lines = rawCode:split("\n")
			local highlighted = ""
			for _, ln in ipairs(lines) do
				highlighted = highlighted .. HighlightLine(ln) .. "\n"
			end

			-- Main outer frame
			local Outer = Create("Frame", Container, {
				Size = UDim2.new(1, 0, CodeHeight.Scale, CodeHeight.Offset),
				BackgroundTransparency = 1,
				Name = "Option",
				ClipsDescendants = false
			})

			-- Header bar
			local Header = Create("Frame", Outer, {
				Size = UDim2.new(1, 0, 0, 24),
				BackgroundColor3 = Color3.fromRGB(30, 30, 46),
				BackgroundTransparency = 0,
				Name = "CodeHeader"
			})
			Make("Corner", Header, UDim.new(0, 10))
			Create("ImageLabel", Header, {
				Size = UDim2.fromOffset(14, 14),
				Position = UDim2.new(0, 8, 0.5),
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Image = HzsLib:GetIcon("code"),
				ImageColor3 = Color3.fromHex("#CBA6F7")
			})
			Create("TextLabel", Header, {
				Size = UDim2.new(1, -50, 1),
				Position = UDim2.new(0, 28, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextSize = 10,
				TextColor3 = Color3.fromHex("#CDD6F4"),
				TextXAlignment = "Left",
				Text = CodeTitle
			})

			-- Copy button
			local CopyBtn
			if CanCopy then
				CopyBtn = Create("TextButton", Header, {
					Size = UDim2.fromOffset(50, 16),
					Position = UDim2.new(1, -6, 0.5),
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromHex("#45475A"),
					BackgroundTransparency = 0.3,
					Font = Enum.Font.GothamBold,
					TextSize = 9,
					TextColor3 = Color3.fromHex("#CDD6F4"),
					Text = "📋 Copy",
					AutoButtonColor = false
				})
				Make("Corner", CopyBtn, UDim.new(0, 6))
				CopyBtn.MouseEnter:Connect(function() CreateTween({CopyBtn, "BackgroundTransparency", 0, 0.1}) end)
				CopyBtn.MouseLeave:Connect(function() CreateTween({CopyBtn, "BackgroundTransparency", 0.3, 0.1}) end)
				CopyBtn.Activated:Connect(function()
					if setclipboard then setclipboard(rawCode) end
					CopyBtn.Text = "✓ Copied"
					task.delay(2, function() if CopyBtn and CopyBtn.Parent then CopyBtn.Text = "📋 Copy" end end)
					if OnCopyCB then task.spawn(OnCopyCB) end
				end)
			end

			-- Code scroll area
			local Body = Create("ScrollingFrame", Outer, {
				Size = UDim2.new(1, 0, 1, -24),
				Position = UDim2.fromOffset(0, 24),
				BackgroundColor3 = Color3.fromRGB(24, 24, 37),
				BackgroundTransparency = 0,
				ScrollBarThickness = 3,
				ScrollBarImageColor3 = Color3.fromHex("#45475A"),
				CanvasSize = UDim2.new(),
				AutomaticCanvasSize = "XY",
				ScrollingDirection = "XY",
				BorderSizePixel = 0,
				Name = "CodeBody"
			})
			-- Bottom corners only
			Create("UICorner", Body, {CornerRadius = UDim.new(0, 10)})
			Create("UIPadding", Body, {
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
				PaddingTop = UDim.new(0, 6),
				PaddingBottom = UDim.new(0, 6)
			})
			Create("UIListLayout", Body, {
				Padding = UDim.new(0, 0),
				SortOrder = "LayoutOrder"
			})

			-- Line numbers + lines
			for lineIdx, ln in ipairs(lines) do
				local LineRow = Create("Frame", Body, {
					Size = UDim2.new(1, 0, 0, CodeSize + 4),
					BackgroundTransparency = 1,
					LayoutOrder = lineIdx
				})
				Create("TextLabel", LineRow, {
					Size = UDim2.fromOffset(28, CodeSize + 4),
					BackgroundTransparency = 1,
					Font = Enum.Font.Code,
					TextSize = CodeSize,
					TextColor3 = Color3.fromHex("#45475A"),
					TextXAlignment = "Right",
					Text = tostring(lineIdx),
					RichText = false
				})
				Create("TextLabel", LineRow, {
					Size = UDim2.new(1, -34, 1),
					Position = UDim2.fromOffset(34, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.Code,
					TextSize = CodeSize,
					TextColor3 = CT.default,
					TextXAlignment = "Left",
					TextWrapped = false,
					RichText = true,
					Text = HighlightLine(ln)
				})
			end

			local CodeObj = {}
			function CodeObj:Visible(B) Funcs:ToggleVisible(Outer, B) end
			function CodeObj:Destroy() Outer:Destroy() end
			function CodeObj:SetCode(newCode)
				rawCode = newCode
				-- rebuild lines
				for _, c in ipairs(Body:GetChildren()) do
					if not c:IsA("UIPadding") and not c:IsA("UIListLayout") then c:Destroy() end
				end
				local lns = newCode:gsub("\\n", "\n"):split("\n")
				for idx, l in ipairs(lns) do
					local LR = Create("Frame", Body, {
						Size = UDim2.new(1, 0, 0, CodeSize + 4),
						BackgroundTransparency = 1,
						LayoutOrder = idx
					})
					Create("TextLabel", LR, {
						Size = UDim2.fromOffset(28, CodeSize + 4),
						BackgroundTransparency = 1,
						Font = Enum.Font.Code,
						TextSize = CodeSize,
						TextColor3 = Color3.fromHex("#45475A"),
						TextXAlignment = "Right",
						Text = tostring(idx)
					})
					Create("TextLabel", LR, {
						Size = UDim2.new(1, -34, 1),
						Position = UDim2.fromOffset(34, 0),
						BackgroundTransparency = 1,
						Font = Enum.Font.Code,
						TextSize = CodeSize,
						TextColor3 = CT.default,
						TextXAlignment = "Left",
						TextWrapped = false,
						RichText = true,
						Text = HighlightLine(l)
					})
				end
			end
			return CodeObj
		end

		-- ============ DROPDOWN ============
		function Tab:AddDropdown(Configs)
			local DName = Configs[1] or Configs.Name or Configs.Title or "Dropdown"
			local DDesc = Configs.Desc or Configs.Description or ""
			local DOptions = Configs[2] or Configs.Options or {}
			local OpDefault = Configs[3] or Configs.Default or {}
			local Flag = Configs[5] or Configs.Flag or false
			local DMultiSelect = Configs.MultiSelect or false
			local Callback = Funcs:GetCallback(Configs, 4)
			
			local Button, LabelFunc = ButtonFrame(Container, DName, DDesc, UDim2.new(1, -180))
			
			local SelectedFrame = InsertTheme(Create("Frame", Button, {
				Size = UDim2.new(0, 150, 0, 18),
				Position = UDim2.new(1, -10, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = Theme["Color Stroke"]
			}), "Stroke")Make("Corner", SelectedFrame, UDim.new(0, 16))
			
			local ActiveLabel = InsertTheme(Create("TextLabel", SelectedFrame, {
				Size = UDim2.new(0.85, 0, 0.85, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextScaled = true,
				TextColor3 = Theme["Color Text"],
				Text = "..."
			}), "Text")
			
			local Arrow = Create("ImageLabel", SelectedFrame, {
				Size = UDim2.new(0, 15, 0, 15),
				Position = UDim2.new(0, -5, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				Image = "rbxassetid://10709791523",
				BackgroundTransparency = 1
			})
			
			local NoClickFrame = Create("TextButton", DropdownHolder, {
				Name = "AntiClick",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Visible = false,
				Text = ""
			})
			
			local DropFrame = Create("Frame", NoClickFrame, {
				Size = UDim2.new(SelectedFrame.Size.X, 0, 0),
				BackgroundTransparency = 0.1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				AnchorPoint = Vector2.new(0, 1),
				Name = "DropdownFrame",
				ClipsDescendants = true,
				Active = true
			})Make("Corner", DropFrame)Make("Stroke", DropFrame)Make("Gradient", DropFrame, {Rotation = 60})
			
			local ScrollFrame = InsertTheme(Create("ScrollingFrame", DropFrame, {
				ScrollBarImageColor3 = Theme["Color Theme"],
				Size = UDim2.new(1, 0, 1, -30),
				Position = UDim2.new(0, 0, 0, 30),
				ScrollBarThickness = 1.5,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				CanvasSize = UDim2.new(),
				ScrollingDirection = "Y",
				AutomaticCanvasSize = "Y",
				Active = true
			}, {
				Create("UIPadding", {
					PaddingLeft = UDim.new(0, 8),
					PaddingRight = UDim.new(0, 8),
					PaddingTop = UDim.new(0, 5),
					PaddingBottom = UDim.new(0, 5)
				}), Create("UIListLayout", {
					Padding = UDim.new(0, 4)
				})
			}), "ScrollBar")
			
			local SearchBar = InsertTheme(Create("Frame", DropFrame, {
				Size = UDim2.new(1, -16, 0, 22),
				Position = UDim2.new(0, 8, 0, 5),
				BackgroundColor3 = Theme["Color Stroke"],
				BackgroundTransparency = 0.2,
				Name = "SearchBar"
			}), "Stroke")Make("Corner", SearchBar, UDim.new(0, 20))
			
			Create("ImageLabel", SearchBar, {
				Size = UDim2.new(0, 14, 0, 14),
				Position = UDim2.new(0, 7, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Image = "rbxassetid://92345384671606",
				Name = "SearchIcon"
			})
			
			local SearchBox = Create("TextBox", SearchBar, {
				Size = UDim2.new(1, -30, 1, 0),
				Position = UDim2.new(0, 26, 0, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamMedium,
				TextSize = 10,
				Text = "",
				PlaceholderText = "Pesquisar...",
				PlaceholderColor3 = Color3.fromRGB(170, 170, 170),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left,
				ClearTextOnFocus = false,
				Name = "SearchBox"
			})
			
			SearchBar.Active = true
			SearchBox.Active = true
			local SearchClicking = false
			SearchBar.InputBegan:Connect(function(Input)
				local T = Input.UserInputType
				if T == Enum.UserInputType.MouseButton1 or T == Enum.UserInputType.Touch then
					SearchClicking = true
					task.delay(0.35, function() SearchClicking = false end)
					if not SearchBox:IsFocused() then
						task.defer(function() SearchBox:CaptureFocus() end)
					end
				end
			end)
			
			local ScrollSize, WaitClick = 5
			Button:SetAttribute("Snd", "None")
			local function Disable()
				if NoClickFrame.Visible then PlayClick("DropdownClose") end
				WaitClick = true
				CreateTween({Arrow, "Rotation", 0, 0.2})
				CreateTween({DropFrame, "Size", UDim2.new(0, 152, 0, 0), 0.2, true})
				CreateTween({Arrow, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.2})
				Arrow.Image = "rbxassetid://10709791523"
				NoClickFrame.Visible = false
				WaitClick = false
			end
			
			local function GetFrameSize()
				return UDim2.fromOffset(152, ScrollSize)
			end
			
			local function CalculateSize()
				local Count = 0
				for _,Frame in pairs(ScrollFrame:GetChildren()) do
					if Frame:IsA("GuiObject") and Frame.Visible then
						Count = Count + 1
					end
				end
				ScrollSize = (math.clamp(Count, 0, 10) * 25) + 10 + 30
				if NoClickFrame.Visible then
					NoClickFrame.Visible = true
					CreateTween({DropFrame, "Size", GetFrameSize(), 0.2, true})
				end
			end
			
			local function Minimize()
				if WaitClick then return end
				WaitClick = true
				if NoClickFrame.Visible then
					PlayClick("DropdownClose")
					Arrow.Image = "rbxassetid://10709791523"
					CreateTween({Arrow, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.2})
					CreateTween({DropFrame, "Size", UDim2.new(0, 152, 0, 0), 0.2, true})
					NoClickFrame.Visible = false
				else
					PlayClick("DropdownOpen")
					NoClickFrame.Visible = true
					Arrow.Image = "rbxassetid://10709790948"
					CreateTween({Arrow, "ImageColor3", Theme["Color Theme"], 0.2})
					CreateTween({DropFrame, "Size", GetFrameSize(), 0.2, true})
				end
				WaitClick = false
			end
			
			local function CalculatePos()
				local FramePos = SelectedFrame.AbsolutePosition
				local ScreenSize = ScreenGui.AbsoluteSize
				local ClampX = math.clamp((FramePos.X / UIScale), 0, ScreenSize.X / UIScale - DropFrame.Size.X.Offset)
				local ClampY = math.clamp((FramePos.Y / UIScale), 0, ScreenSize.Y / UIScale)
				
				local NewPos = UDim2.fromOffset(ClampX, ClampY)
				local AnchorPoint = FramePos.Y > ScreenSize.Y / 1.4 and 1 or ScrollSize > 80 and 0.5 or 0
				DropFrame.AnchorPoint = Vector2.new(0, AnchorPoint)
				CreateTween({DropFrame, "Position", NewPos, 0.1})
			end
			
			local AddNewOptions, GetOptions, AddOption, RemoveOption, Selected do
				local Default = type(OpDefault) ~= "table" and {OpDefault} or OpDefault
				local MultiSelect = DMultiSelect
				local Options = {}
				Selected = MultiSelect and {} or CheckFlag(Flag) and GetFlag(Flag) or Default[1]
				
				if MultiSelect then
					for index, Value in pairs(CheckFlag(Flag) and GetFlag(Flag) or Default) do
						if type(index) == "string" and (DOptions[index] or table.find(DOptions, index)) then
							Selected[index] = Value
						elseif DOptions[Value] then
							Selected[Value] = true
						end
					end
				end
				
				local function CallbackSelected()
					SetFlag(Flag, MultiSelect and Selected or tostring(Selected or "..."))
					Funcs:FireCallback(Callback, Selected)
				end
				
				local function UpdateLabel()
					if MultiSelect then
						local list = {}
						for index, Value in pairs(Selected) do
							if Value then table.insert(list, index) end
						end
						ActiveLabel.Text = #list > 0 and table.concat(list, ", ") or "..."
					else
						ActiveLabel.Text = tostring(Selected or "...")
					end
				end
				
				local function UpdateSelected()
					if MultiSelect then
						for _,v in pairs(Options) do
							local nodes, Stats = v.nodes, v.Stats
							CreateTween({nodes[2], "BackgroundTransparency", Stats and 0 or 0.8, 0.35})
							CreateTween({nodes[2], "Size", Stats and UDim2.fromOffset(4, 12) or UDim2.fromOffset(4, 4), 0.35})
							CreateTween({nodes[3], "TextTransparency", Stats and 0 or 0.4, 0.35})
						end
					else
						for _,v in pairs(Options) do
							local Slt = v.Value == Selected
							local nodes = v.nodes
							CreateTween({nodes[2], "BackgroundTransparency", Slt and 0 or 1, 0.35})
							CreateTween({nodes[2], "Size", Slt and UDim2.fromOffset(4, 14) or UDim2.fromOffset(4, 4), 0.35})
							CreateTween({nodes[3], "TextTransparency", Slt and 0 or 0.4, 0.35})
						end
					end
					UpdateLabel()
				end
				
				local function Select(Option)
					if MultiSelect then
						Option.Stats = not Option.Stats
						Option.LastCB = tick()
						Selected[Option.Name] = Option.Stats
						CallbackSelected()
					else
						Option.LastCB = tick()
						Selected = Option.Value
						CallbackSelected()
					end
					UpdateSelected()
				end
				
				AddOption = function(index, Value)
					local Name = tostring(type(index) == "string" and index or Value)
					if Options[Name] then return end
					Options[Name] = {
						index = index,
						Value = Value,
						Name = Name,
						Stats = false,
						LastCB = 0
					}
					
					if MultiSelect then
						local Stats = Selected[Name]
						Selected[Name] = Stats or false
						Options[Name].Stats = Stats
					end
					
					local Button = Make("Button", ScrollFrame, {
						Name = "Option",
						Size = UDim2.new(1, 0, 0, 21),
						Position = UDim2.new(0, 0, 0.5),
						AnchorPoint = Vector2.new(0, 0.5)
					})Make("Corner", Button, UDim.new(0, 16))
					
					local IsSelected = InsertTheme(Create("Frame", Button, {
						Position = UDim2.new(0, 1, 0.5),
						Size = UDim2.new(0, 4, 0, 4),
						BackgroundColor3 = Theme["Color Theme"],
						BackgroundTransparency = 1,
						AnchorPoint = Vector2.new(0, 0.5)
					}), "Theme")Make("Corner", IsSelected, UDim.new(0.5, 0))
					
					local OptioneName = InsertTheme(Create("TextLabel", Button, {
						Size = UDim2.new(1, 0, 1),
						Position = UDim2.new(0, 10),
						Text = Name,
						TextColor3 = Theme["Color Text"],
						Font = Enum.Font.GothamBold,
						TextXAlignment = "Left",
						BackgroundTransparency = 1,
						TextTransparency = 0.4
					}), "Text")
					
					Button.Activated:Connect(function()
						Select(Options[Name])
					end)
					
					Options[Name].nodes = {Button, IsSelected, OptioneName}
				end
				
				RemoveOption = function(index, Value)
					local Name = tostring(type(index) == "string" and index or Value)
					if Options[Name] then
						if MultiSelect then Selected[Name] = nil else Selected = nil end
						Options[Name].nodes[1]:Destroy()
						table.clear(Options[Name])
						Options[Name] = nil
					end
				end
				
				GetOptions = function()
					return Options
				end
				
				AddNewOptions = function(List, Clear)
					if Clear then
						table.foreach(Options, RemoveOption)
					end
					table.foreach(List, AddOption)
					CallbackSelected()
					UpdateSelected()
				end
				
				table.foreach(DOptions, AddOption)
				CallbackSelected()
				UpdateSelected()
			end
			
			local function FilterOptions()
				local Query = SearchBox.Text:lower()
				for _,Opt in ipairs(ScrollFrame:GetChildren()) do
					if Opt.Name == "Option" and Opt:IsA("GuiObject") then
						local Label = Opt:FindFirstChildOfClass("TextLabel")
						Opt.Visible = Query == "" or (Label ~= nil and Label.Text:lower():find(Query, 1, true) ~= nil)
					end
				end
				ScrollFrame.CanvasPosition = Vector2.new(0, 0)
				CalculateSize()
			end
			SearchBox:GetPropertyChangedSignal("Text"):Connect(FilterOptions)
			NoClickFrame:GetPropertyChangedSignal("Visible"):Connect(function()
				if not NoClickFrame.Visible then SearchBox.Text = "" end
			end)
			
			Button.Activated:Connect(Minimize)
			NoClickFrame.MouseButton1Down:Connect(function()
				if SearchClicking then return end
				Disable()
			end)
			NoClickFrame.MouseButton1Click:Connect(function()
				if SearchClicking then return end
				Disable()
			end)
			MainFrame:GetPropertyChangedSignal("Visible"):Connect(Disable)
			SelectedFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(CalculatePos)
			
			Button.Activated:Connect(CalculateSize)
			ScrollFrame.ChildAdded:Connect(CalculateSize)
			ScrollFrame.ChildRemoved:Connect(CalculateSize)
			CalculatePos()
			CalculateSize()
			
			local Dropdown = {}
			function Dropdown:Visible(...) Funcs:ToggleVisible(Button, ...) end
			function Dropdown:Destroy() Button:Destroy() end
			function Dropdown:Callback(...) Funcs:InsertCallback(Callback, ...)(Selected) end
			
			function Dropdown:Add(...)
				local NewOptions = {...}
				if type(NewOptions[1]) == "table" then
					table.foreach(NewOptions[1], function(_,Name) AddOption(Name) end)
				else
					table.foreach(NewOptions, function(_,Name) AddOption(Name) end)
				end
			end
			function Dropdown:Remove(Option)
				for index, Value in pairs(GetOptions()) do
					if type(Option) == "number" and index == Option or Value.Name == "Option" then
						RemoveOption(index, Value.Value)
					end
				end
			end
			function Dropdown:Select(Option)
				if type(Option) == "string" then
					for _,Val in pairs(GetOptions()) do
						if Val.Name == Option and Val.Active then Val.Active() end
					end
				end
			end
			function Dropdown:Set(Val1, Clear)
				if type(Val1) == "table" then
					AddNewOptions(Val1, not Clear)
				elseif type(Val1) == "function" then
					Callback = Val1
				end
			end
			return Dropdown
		end

		-- ============ SLIDER ============
		function Tab:AddSlider(Configs)
			local SName = Configs[1] or Configs.Name or Configs.Title or "Slider!"
			local SDesc = Configs.Desc or Configs.Description or ""
			local Min = Configs[2] or Configs.MinValue or Configs.Min or 10
			local Max = Configs[3] or Configs.MaxValue or Configs.Max or 100
			local Increase = Configs[4] or Configs.Increase or 1
			local Callback = Funcs:GetCallback(Configs, 6)
			local Flag = Configs[7] or Configs.Flag or false
			local Default = Configs[5] or Configs.Default or 25
			if CheckFlag(Flag) then Default = GetFlag(Flag) end
			Min, Max = Min / Increase, Max / Increase
			
			local Button, LabelFunc = ButtonFrame(Container, SName, SDesc, UDim2.new(1, -180))
			
			local SliderHolder = Create("TextButton", Button, {
				Size = UDim2.new(0.45, 0, 1),
				Position = UDim2.new(1),
				AnchorPoint = Vector2.new(1, 0),
				AutoButtonColor = false,
				Text = "",
				BackgroundTransparency = 1
			})
			
			local SliderBar = InsertTheme(Create("Frame", SliderHolder, {
				BackgroundColor3 = Theme["Color Stroke"],
				Size = UDim2.new(1, -20, 0, 6),
				Position = UDim2.new(0.5, 0, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5)
			}), "Stroke")Make("Corner", SliderBar)
			
			local Indicator = InsertTheme(Create("Frame", SliderBar, {
				BackgroundColor3 = Theme["Color Theme"],
				Size = UDim2.fromScale(0.3, 1),
				BorderSizePixel = 0
			}), "Theme")Make("Corner", Indicator)
			
			local SliderIcon = Create("Frame", SliderBar, {
				Size = UDim2.new(0, 6, 0, 12),
				BackgroundColor3 = Color3.fromRGB(220, 220, 220),
				Position = UDim2.fromScale(0.3, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 0.2
			})Make("Corner", SliderIcon)
			
			local LabelVal = InsertTheme(Create("TextLabel", SliderHolder, {
				Size = UDim2.new(0, 14, 0, 14),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(0, 0, 0.5),
				BackgroundTransparency = 1,
				TextColor3 = Theme["Color Text"],
				Font = Enum.Font.FredokaOne,
				TextSize = 12
			}), "Text")
			
			local UIScaleLbl = Create("UIScale", LabelVal)
			
			local BaseMousePos = Create("Frame", SliderBar, {
				Position = UDim2.new(0, 0, 0.5, 0),
				Visible = false
			})
			
			local function UpdateLabel(NewValue)
				local Number = tonumber(NewValue * Increase)
				Number = math.floor(Number * 100) / 100
				Default, LabelVal.Text = Number, tostring(Number)
				Funcs:FireCallback(Callback, Default)
			end
			
			local function ControlPos()
				local MousePos = Player:GetMouse()
				local APos = MousePos.X - BaseMousePos.AbsolutePosition.X
				local ConfigureDpiPos = APos / SliderBar.AbsoluteSize.X
				SliderIcon.Position = UDim2.new(math.clamp(ConfigureDpiPos, 0, 1), 0, 0.5, 0)
			end
			
			local function UpdateValues()
				Indicator.Size = UDim2.new(SliderIcon.Position.X.Scale, 0, 1, 0)
				local SliderPos = SliderIcon.Position.X.Scale
				local NewValue = math.floor(((SliderPos * Max) / Max) * (Max - Min) + Min)
				UpdateLabel(NewValue)
			end
			
			SliderHolder.MouseButton1Down:Connect(function()
				CreateTween({SliderIcon, "Transparency", 0, 0.3})
				Container.ScrollingEnabled = false
				while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do task.wait()
					ControlPos()
				end
				CreateTween({SliderIcon, "Transparency", 0.2, 0.3})
				Container.ScrollingEnabled = true
				SetFlag(Flag, Default)
			end)
			
			LabelVal:GetPropertyChangedSignal("Text"):Connect(function()
				UIScaleLbl.Scale = 0.3
				CreateTween({UIScaleLbl, "Scale", 1.2, 0.1})
				CreateTween({LabelVal, "Rotation", math.random(-1, 1) * 5, 0.15, true})
				CreateTween({UIScaleLbl, "Scale", 1, 0.2})
				CreateTween({LabelVal, "Rotation", 0, 0.1})
			end)
			
			local function SetSlider(NewValue)
				if type(NewValue) ~= "number" then return end
				local MinR, MaxR = Min * Increase, Max * Increase
				local SliderPos = (NewValue - MinR) / (MaxR - MinR)
				SetFlag(Flag, NewValue)
				CreateTween({ SliderIcon, "Position", UDim2.fromScale(math.clamp(SliderPos, 0, 1), 0.5), 0.3, true })
			end;SetSlider(Default)
			
			SliderIcon:GetPropertyChangedSignal("Position"):Connect(UpdateValues)UpdateValues()
			
			local Slider = {}
			function Slider:Set(NewVal1, NewVal2)
				if NewVal1 and NewVal2 then
					LabelFunc:SetTitle(NewVal1)
					LabelFunc:SetDesc(NewVal2)
				elseif type(NewVal1) == "string" then
					LabelFunc:SetTitle(NewVal1)
				elseif type(NewVal1) == "function" then
					Callback = NewVal1
				elseif type(NewVal1) == "number" then
					SetSlider(NewVal1)
				end
			end
			function Slider:Callback(...) Funcs:InsertCallback(Callback, ...)(tonumber(Default)) end
			function Slider:Visible(...) Funcs:ToggleVisible(Button, ...) end
			function Slider:Destroy() Button:Destroy() end
			return Slider
		end

		-- ============ TEXTBOX ============
		function Tab:AddTextBox(Configs)
			local TName = Configs[1] or Configs.Name or Configs.Title or "Text Box"
			local TDesc = Configs.Desc or Configs.Description or ""
			local TDefault = Configs[2] or Configs.Default or ""
			local TPlaceholderText = Configs[5] or Configs.PlaceholderText or "Input"
			local TClearText = Configs[3] or Configs.ClearText or false
			local Callback = Funcs:GetCallback(Configs, 4)
			
			if type(TDefault) ~= "string" or TDefault:gsub(" ", ""):len() < 1 then
				TDefault = false
			end
			
			local Button, LabelFunc = ButtonFrame(Container, TName, TDesc, UDim2.new(1, -38))
			
			local SelectedFrame = InsertTheme(Create("Frame", Button, {
				Size = UDim2.new(0, 150, 0, 18),
				Position = UDim2.new(1, -10, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = Theme["Color Stroke"]
			}), "Stroke")Make("Corner", SelectedFrame, UDim.new(0, 16))
			
			local TextBoxInput = InsertTheme(Create("TextBox", SelectedFrame, {
				Size = UDim2.new(0.85, 0, 0.85, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextScaled = true,
				TextColor3 = Theme["Color Text"],
				ClearTextOnFocus = TClearText,
				PlaceholderText = TPlaceholderText,
				Text = ""
			}), "Text")
			
			local Pencil = Create("ImageLabel", SelectedFrame, {
				Size = UDim2.new(0, 12, 0, 12),
				Position = UDim2.new(0, -5, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				Image = "rbxassetid://15637081879",
				BackgroundTransparency = 1
			})
			
			local TextBox = {}
			local function Input()
				local Text = TextBoxInput.Text
				if Text:gsub(" ", ""):len() > 0 then
					if TextBox.OnChanging then Text = TextBox.OnChanging(Text) or Text end
					Funcs:FireCallback(Callback, Text)
					TextBoxInput.Text = Text
				end
			end
			
			TextBoxInput.FocusLost:Connect(Input)Input()
			
			TextBoxInput.FocusLost:Connect(function()
				CreateTween({Pencil, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.2})
			end)
			TextBoxInput.Focused:Connect(function()
				CreateTween({Pencil, "ImageColor3", Theme["Color Theme"], 0.2})
			end)
			
			TextBox.OnChanging = false
			function TextBox:Visible(...) Funcs:ToggleVisible(Button, ...) end
			function TextBox:Destroy() Button:Destroy() end
			return TextBox
		end

		-- ============ DISCORD INVITE ============
		function Tab:AddDiscordInvite(Configs)
			local Title = Configs[1] or Configs.Name or Configs.Title or "Discord"
			local Desc = Configs.Desc or Configs.Description or ""
			local Logo = Configs[2] or Configs.Logo or ""
			local Invite = Configs[3] or Configs.Invite or ""
			
			local InviteHolder = Create("Frame", Container, {
				Size = UDim2.new(1, 0, 0, 80),
				Name = "Option",
				BackgroundTransparency = 1
			})
			
			local InviteLabel = Create("TextLabel", InviteHolder, {
				Size = UDim2.new(1, 0, 0, 15),
				Position = UDim2.new(0, 5),
				TextColor3 = Color3.fromRGB(40, 150, 255),
				Font = Enum.Font.GothamBold,
				TextXAlignment = "Left",
				BackgroundTransparency = 1,
				TextSize = 10,
				Text = Invite
			})
			
			local FrameHolder = InsertTheme(Create("Frame", InviteHolder, {
				Size = UDim2.new(1, 0, 0, 65),
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.new(0, 0, 1),
				BackgroundColor3 = Theme["Color Hub 2"]
			}), "Frame")Make("Corner", FrameHolder)
			
			local ImageLabel = Create("ImageLabel", FrameHolder, {
				Size = UDim2.new(0, 30, 0, 30),
				Position = UDim2.new(0, 7, 0, 7),
				Image = Logo,
				BackgroundTransparency = 1
			})Make("Corner", ImageLabel, UDim.new(0, 15))Make("Stroke", ImageLabel)
			
			local LTitle = InsertTheme(Create("TextLabel", FrameHolder, {
				Size = UDim2.new(1, -52, 0, 15),
				Position = UDim2.new(0, 44, 0, 7),
				Font = Enum.Font.GothamBold,
				TextColor3 = Theme["Color Text"],
				TextXAlignment = "Left",
				BackgroundTransparency = 1,
				TextSize = 10,
				Text = Title
			}), "Text")
			
			local LDesc = InsertTheme(Create("TextLabel", FrameHolder, {
				Size = UDim2.new(1, -52, 0, 0),
				Position = UDim2.new(0, 44, 0, 22),
				TextWrapped = "Y",
				AutomaticSize = "Y",
				Font = Enum.Font.Gotham,
				TextColor3 = Theme["Color Dark Text"],
				TextXAlignment = "Left",
				BackgroundTransparency = 1,
				TextSize = 8,
				Text = Desc
			}), "DarkText")
			
			local JoinButton = Create("TextButton", FrameHolder, {
				Size = UDim2.new(1, -14, 0, 16),
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.new(0.5, 0, 1, -7),
				Text = "Join",
				Font = Enum.Font.GothamBold,
				TextSize = 12,
				TextColor3 = Color3.fromRGB(220, 220, 220),
				BackgroundColor3 = Color3.fromRGB(50, 150, 50)
			})Make("Corner", JoinButton, UDim.new(0, 20))
			
			local ClickDelay
			JoinButton.Activated:Connect(function()
				setclipboard(Invite)
				if ClickDelay then return end
				ClickDelay = true
				SetProps(JoinButton, {
					Text = "Copied to Clipboard",
					BackgroundColor3 = Color3.fromRGB(100, 100, 100),
					TextColor3 = Color3.fromRGB(150, 150, 150)
				})task.wait(5)
				SetProps(JoinButton, {
					Text = "Join",
					BackgroundColor3 = Color3.fromRGB(50, 150, 50),
					TextColor3 = Color3.fromRGB(220, 220, 220)
				})ClickDelay = false
			end)
			
			local DiscordInvite = {}
			function DiscordInvite:Destroy() InviteHolder:Destroy() end
			function DiscordInvite:Visible(...) Funcs:ToggleVisible(InviteHolder, ...) end
			return DiscordInvite
		end

		return Tab
	end
	
	CloseButton.Activated:Connect(Window.CloseBtn)
	MinimizeButton.Activated:Connect(Window.MinimizeBtn)
	return Window
end

return HzsLib
