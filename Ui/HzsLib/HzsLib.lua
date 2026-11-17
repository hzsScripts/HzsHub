local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerMouse = Player:GetMouse()

local CoreGui = (gethui and gethui()) or game:GetService("CoreGui");

local HzsLib = {
	Themes = {
		White = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 0)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(16, 12, 15)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
			}),
			["Color Hub 2"] = Color3.fromRGB(12, 10, 12),
			["Color Stroke"] = Color3.fromRGB(90, 45, 70),
			["Color Theme"] = Color3.fromRGB(255, 105, 180), -- rosa (detalhes)
			["Color Text"] = Color3.fromRGB(255, 255, 255),
			["Color Dark Text"] = Color3.fromRGB(190, 170, 182)
		}
	},
	Info = {
		Version = "1.0.6"
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
			["alignhorizontaldistributecenter"] = "rbxassetid://10747779791",
			["alignhorizontaldistributeend"] = "rbxassetid://10747784534",
			["alignhorizontaldistributestart"] = "rbxassetid://10709754118",
			["alignhorizontaljustifycenter"] = "rbxassetid://10709754204",
			["alignhorizontaljustifyend"] = "rbxassetid://10709754317",
			["alignhorizontaljustifystart"] = "rbxassetid://10709754436",
			["alignhorizontalspacearound"] = "rbxassetid://10709754590",
			["alignhorizontalspacebetween"] = "rbxassetid://10709754749",
			["alignjustify"] = "rbxassetid://10709759610",
			["alignleft"] = "rbxassetid://10709759764",
			["alignright"] = "rbxassetid://10709759895",
			["alignstarthorizontal"] = "rbxassetid://10709760051",
			["alignstartvertical"] = "rbxassetid://10709760244",
			["alignverticaldistributecenter"] = "rbxassetid://10709760351",
			["alignverticaldistributeend"] = "rbxassetid://10709760434",
			["alignverticaldistributestart"] = "rbxassetid://10709760612",
			["alignverticaljustifycenter"] = "rbxassetid://10709760814",
			["alignverticaljustifyend"] = "rbxassetid://10709761003",
			["alignverticaljustifystart"] = "rbxassetid://10709761176",
			["alignverticalspacearound"] = "rbxassetid://10709761324",
			["alignverticalspacebetween"] = "rbxassetid://10709761434",
			["anchor"] = "rbxassetid://10709761530",
			["angry"] = "rbxassetid://10709761629",
			["annoyed"] = "rbxassetid://10709761722",
			["aperture"] = "rbxassetid://10709761813",
			["apple"] = "rbxassetid://10709761889",
			["archive"] = "rbxassetid://10709762233",
			["archiverestore"] = "rbxassetid://10709762058",
			["armchair"] = "rbxassetid://10709762327",
			["arrowbigdown"] = "rbxassetid://10747796644",
			["arrowbigleft"] = "rbxassetid://10709762574",
			["arrowbigright"] = "rbxassetid://10709762727",
			["arrowbigup"] = "rbxassetid://10709762879",
			["arrowdown"] = "rbxassetid://10709767827",
			["arrowdowncircle"] = "rbxassetid://10709763034",
			["arrowdownleft"] = "rbxassetid://10709767656",
			["arrowdownright"] = "rbxassetid://10709767750",
			["arrowleft"] = "rbxassetid://10709768114",
			["arrowleftcircle"] = "rbxassetid://10709767936",
			["arrowleftright"] = "rbxassetid://10709768019",
			["arrowright"] = "rbxassetid://10709768347",
			["arrowrightcircle"] = "rbxassetid://10709768226",
			["arrowup"] = "rbxassetid://10709768939",
			["arrowupcircle"] = "rbxassetid://10709768432",
			["arrowupdown"] = "rbxassetid://10709768538",
			["arrowupleft"] = "rbxassetid://10709768661",
			["arrowupright"] = "rbxassetid://10709768787",
			["asterisk"] = "rbxassetid://10709769095",
			["atsign"] = "rbxassetid://10709769286",
			["award"] = "rbxassetid://10709769406",
			["axe"] = "rbxassetid://10709769508",
			["axis3d"] = "rbxassetid://10709769598",
			["baby"] = "rbxassetid://10709769732",
			["backpack"] = "rbxassetid://10709769841",
			["baggageclaim"] = "rbxassetid://10709769935",
			["banana"] = "rbxassetid://10709770005",
			["banknote"] = "rbxassetid://10709770178",
			["barchart"] = "rbxassetid://10709773755",
			["barchart2"] = "rbxassetid://10709770317",
			["barchart3"] = "rbxassetid://10709770431",
			["barchart4"] = "rbxassetid://10709770560",
			["barcharthorizontal"] = "rbxassetid://10709773669",
			["barcode"] = "rbxassetid://10747360675",
			["baseline"] = "rbxassetid://10709773863",
			["bath"] = "rbxassetid://10709773963",
			["battery"] = "rbxassetid://10709774640",
			["batterycharging"] = "rbxassetid://10709774068",
			["batteryfull"] = "rbxassetid://10709774206",
			["batterylow"] = "rbxassetid://10709774370",
			["batterymedium"] = "rbxassetid://10709774513",
			["beaker"] = "rbxassetid://10709774756",
			["bed"] = "rbxassetid://10709775036",
			["beddouble"] = "rbxassetid://10709774864",
			["bedsingle"] = "rbxassetid://10709774968",
			["beer"] = "rbxassetid://10709775167",
			["bell"] = "rbxassetid://10709775704",
			["bellminus"] = "rbxassetid://10709775241",
			["belloff"] = "rbxassetid://10709775320",
			["bellplus"] = "rbxassetid://10709775448",
			["bellring"] = "rbxassetid://10709775560",
			["bike"] = "rbxassetid://10709775894",
			["binary"] = "rbxassetid://10709776050",
			["bitcoin"] = "rbxassetid://10709776126",
			["bluetooth"] = "rbxassetid://10709776655",
			["bluetoothconnected"] = "rbxassetid://10709776240",
			["bluetoothoff"] = "rbxassetid://10709776344",
			["bluetoothsearching"] = "rbxassetid://10709776501",
			["bold"] = "rbxassetid://10747813908",
			["bomb"] = "rbxassetid://10709781460",
			["bone"] = "rbxassetid://10709781605",
			["book"] = "rbxassetid://10709781824",
			["bookopen"] = "rbxassetid://10709781717",
			["bookmark"] = "rbxassetid://10709782154",
			["bookmarkminus"] = "rbxassetid://10709781919",
			["bookmarkplus"] = "rbxassetid://10709782044",
			["bot"] = "rbxassetid://10709782230",
			["box"] = "rbxassetid://10709782497",
			["boxselect"] = "rbxassetid://10709782342",
			["boxes"] = "rbxassetid://10709782582",
			["briefcase"] = "rbxassetid://10709782662",
			["brush"] = "rbxassetid://10709782758",
			["bug"] = "rbxassetid://10709782845",
			["building"] = "rbxassetid://10709783051",
			["building2"] = "rbxassetid://10709782939",
			["bus"] = "rbxassetid://10709783137",
			["cake"] = "rbxassetid://10709783217",
			["calculator"] = "rbxassetid://10709783311",
			["calendar"] = "rbxassetid://10709789505",
			["calendarcheck"] = "rbxassetid://10709783474",
			["calendarcheck2"] = "rbxassetid://10709783392",
			["calendarclock"] = "rbxassetid://10709783577",
			["calendardays"] = "rbxassetid://10709783673",
			["calendarheart"] = "rbxassetid://10709783835",
			["calendarminus"] = "rbxassetid://10709783959",
			["calendaroff"] = "rbxassetid://10709788784",
			["calendarplus"] = "rbxassetid://10709788937",
			["calendarrange"] = "rbxassetid://10709789053",
			["calendarsearch"] = "rbxassetid://10709789200",
			["calendarx"] = "rbxassetid://10709789407",
			["calendarx2"] = "rbxassetid://10709789329",
			["camera"] = "rbxassetid://10709789686",
			["cameraoff"] = "rbxassetid://10747822677",
			["car"] = "rbxassetid://10709789810",
			["carrot"] = "rbxassetid://10709789960",
			["cast"] = "rbxassetid://10709790097",
			["charge"] = "rbxassetid://10709790202",
			["check"] = "rbxassetid://10709790644",
			["checkcircle"] = "rbxassetid://10709790387",
			["checkcircle2"] = "rbxassetid://10709790298",
			["checksquare"] = "rbxassetid://10709790537",
			["chefhat"] = "rbxassetid://10709790757",
			["cherry"] = "rbxassetid://10709790875",
			["chevrondown"] = "rbxassetid://10709790948",
			["chevronfirst"] = "rbxassetid://10709791015",
			["chevronlast"] = "rbxassetid://10709791130",
			["chevronleft"] = "rbxassetid://10709791281",
			["chevronright"] = "rbxassetid://10709791437",
			["chevronup"] = "rbxassetid://10709791523",
			["chevronsdown"] = "rbxassetid://10709796864",
			["chevronsdownup"] = "rbxassetid://10709791632",
			["chevronsleft"] = "rbxassetid://10709797151",
			["chevronsleftright"] = "rbxassetid://10709797006",
			["chevronsright"] = "rbxassetid://10709797382",
			["chevronsrightleft"] = "rbxassetid://10709797274",
			["chevronsup"] = "rbxassetid://10709797622",
			["chevronsupdown"] = "rbxassetid://10709797508",
			["chrome"] = "rbxassetid://10709797725",
			["circle"] = "rbxassetid://10709798174",
			["circledot"] = "rbxassetid://10709797837",
			["circleellipsis"] = "rbxassetid://10709797985",
			["circleslashed"] = "rbxassetid://10709798100",
			["citrus"] = "rbxassetid://10709798276",
			["clapperboard"] = "rbxassetid://10709798350",
			["clipboard"] = "rbxassetid://10709799288",
			["clipboardcheck"] = "rbxassetid://10709798443",
			["clipboardcopy"] = "rbxassetid://10709798574",
			["clipboardedit"] = "rbxassetid://10709798682",
			["clipboardlist"] = "rbxassetid://10709798792",
			["clipboardsignature"] = "rbxassetid://10709798890",
			["clipboardtype"] = "rbxassetid://10709798999",
			["clipboardx"] = "rbxassetid://10709799124",
			["clock"] = "rbxassetid://10709805144",
			["clock1"] = "rbxassetid://10709799535",
			["clock10"] = "rbxassetid://10709799718",
			["clock11"] = "rbxassetid://10709799818",
			["clock12"] = "rbxassetid://10709799962",
			["clock2"] = "rbxassetid://10709803876",
			["clock3"] = "rbxassetid://10709803989",
			["clock4"] = "rbxassetid://10709804164",
			["clock5"] = "rbxassetid://10709804291",
			["clock6"] = "rbxassetid://10709804435",
			["clock7"] = "rbxassetid://10709804599",
			["clock8"] = "rbxassetid://10709804784",
			["clock9"] = "rbxassetid://10709804996",
			["cloud"] = "rbxassetid://10709806740",
			["cloudcog"] = "rbxassetid://10709805262",
			["clouddrizzle"] = "rbxassetid://10709805371",
			["cloudfog"] = "rbxassetid://10709805477",
			["cloudhail"] = "rbxassetid://10709805596",
			["cloudlightning"] = "rbxassetid://10709805727",
			["cloudmoon"] = "rbxassetid://10709805942",
			["cloudmoonrain"] = "rbxassetid://10709805838",
			["cloudoff"] = "rbxassetid://10709806060",
			["cloudrain"] = "rbxassetid://10709806277",
			["cloudrainwind"] = "rbxassetid://10709806166",
			["cloudsnow"] = "rbxassetid://10709806374",
			["cloudsun"] = "rbxassetid://10709806631",
			["cloudsunrain"] = "rbxassetid://10709806475",
			["cloudy"] = "rbxassetid://10709806859",
			["clover"] = "rbxassetid://10709806995",
			["code"] = "rbxassetid://10709810463",
			["code2"] = "rbxassetid://10709807111",
			["codepen"] = "rbxassetid://10709810534",
			["codesandbox"] = "rbxassetid://10709810676",
			["coffee"] = "rbxassetid://10709810814",
			["cog"] = "rbxassetid://10709810948",
			["coins"] = "rbxassetid://10709811110",
			["columns"] = "rbxassetid://10709811261",
			["command"] = "rbxassetid://10709811365",
			["compass"] = "rbxassetid://10709811445",
			["component"] = "rbxassetid://10709811595",
			["conciergebell"] = "rbxassetid://10709811706",
			["connection"] = "rbxassetid://10747361219",
			["contact"] = "rbxassetid://10709811834",
			["contrast"] = "rbxassetid://10709811939",
			["cookie"] = "rbxassetid://10709812067",
			["copy"] = "rbxassetid://10709812159",
			["copyleft"] = "rbxassetid://10709812251",
			["copyright"] = "rbxassetid://10709812311",
			["cornerdownleft"] = "rbxassetid://10709812396",
			["cornerdownright"] = "rbxassetid://10709812485",
			["cornerleftdown"] = "rbxassetid://10709812632",
			["cornerleftup"] = "rbxassetid://10709812784",
			["cornerrightdown"] = "rbxassetid://10709812939",
			["cornerrightup"] = "rbxassetid://10709813094",
			["cornerupleft"] = "rbxassetid://10709813185",
			["cornerupright"] = "rbxassetid://10709813281",
			["cpu"] = "rbxassetid://10709813383",
			["croissant"] = "rbxassetid://10709818125",
			["crop"] = "rbxassetid://10709818245",
			["cross"] = "rbxassetid://10709818399",
			["crosshair"] = "rbxassetid://10709818534",
			["crown"] = "rbxassetid://10709818626",
			["cupsoda"] = "rbxassetid://10709818763",
			["curlybraces"] = "rbxassetid://10709818847",
			["currency"] = "rbxassetid://10709818931",
			["database"] = "rbxassetid://10709818996",
			["delete"] = "rbxassetid://10709819059",
			["diamond"] = "rbxassetid://10709819149",
			["dice1"] = "rbxassetid://10709819266",
			["dice2"] = "rbxassetid://10709819361",
			["dice3"] = "rbxassetid://10709819508",
			["dice4"] = "rbxassetid://10709819670",
			["dice5"] = "rbxassetid://10709819801",
			["dice6"] = "rbxassetid://10709819896",
			["dices"] = "rbxassetid://10723343321",
			["diff"] = "rbxassetid://10723343416",
			["disc"] = "rbxassetid://10723343537",
			["divide"] = "rbxassetid://10723343805",
			["dividecircle"] = "rbxassetid://10723343636",
			["dividesquare"] = "rbxassetid://10723343737",
			["dollarsign"] = "rbxassetid://10723343958",
			["download"] = "rbxassetid://10723344270",
			["downloadcloud"] = "rbxassetid://10723344088",
			["droplet"] = "rbxassetid://10723344432",
			["droplets"] = "rbxassetid://10734883356",
			["drumstick"] = "rbxassetid://10723344737",
			["edit"] = "rbxassetid://10734883598",
			["edit2"] = "rbxassetid://10723344885",
			["edit3"] = "rbxassetid://10723345088",
			["egg"] = "rbxassetid://10723345518",
			["eggfried"] = "rbxassetid://10723345347",
			["electricity"] = "rbxassetid://10723345749",
			["electricityoff"] = "rbxassetid://10723345643",
			["equal"] = "rbxassetid://10723345990",
			["equalnot"] = "rbxassetid://10723345866",
			["eraser"] = "rbxassetid://10723346158",
			["euro"] = "rbxassetid://10723346372",
			["expand"] = "rbxassetid://10723346553",
			["externallink"] = "rbxassetid://10723346684",
			["eye"] = "rbxassetid://10723346959",
			["eyeoff"] = "rbxassetid://10723346871",
			["factory"] = "rbxassetid://10723347051",
			["fan"] = "rbxassetid://10723354359",
			["fastforward"] = "rbxassetid://10723354521",
			["feather"] = "rbxassetid://10723354671",
			["figma"] = "rbxassetid://10723354801",
			["file"] = "rbxassetid://10723374641",
			["filearchive"] = "rbxassetid://10723354921",
			["fileaudio"] = "rbxassetid://10723355148",
			["fileaudio2"] = "rbxassetid://10723355026",
			["fileaxis3d"] = "rbxassetid://10723355272",
			["filebadge"] = "rbxassetid://10723355622",
			["filebadge2"] = "rbxassetid://10723355451",
			["filebarchart"] = "rbxassetid://10723355887",
			["filebarchart2"] = "rbxassetid://10723355746",
			["filebox"] = "rbxassetid://10723355989",
			["filecheck"] = "rbxassetid://10723356210",
			["filecheck2"] = "rbxassetid://10723356100",
			["fileclock"] = "rbxassetid://10723356329",
			["filecode"] = "rbxassetid://10723356507",
			["filecog"] = "rbxassetid://10723356830",
			["filecog2"] = "rbxassetid://10723356676",
			["filediff"] = "rbxassetid://10723357039",
			["filedigit"] = "rbxassetid://10723357151",
			["filedown"] = "rbxassetid://10723357322",
			["fileedit"] = "rbxassetid://10723357495",
			["fileheart"] = "rbxassetid://10723357637",
			["fileimage"] = "rbxassetid://10723357790",
			["fileinput"] = "rbxassetid://10723357933",
			["filejson"] = "rbxassetid://10723364435",
			["filejson2"] = "rbxassetid://10723364361",
			["filekey"] = "rbxassetid://10723364605",
			["filekey2"] = "rbxassetid://10723364515",
			["filelinechart"] = "rbxassetid://10723364725",
			["filelock"] = "rbxassetid://10723364957",
			["filelock2"] = "rbxassetid://10723364861",
			["fileminus"] = "rbxassetid://10723365254",
			["fileminus2"] = "rbxassetid://10723365086",
			["fileoutput"] = "rbxassetid://10723365457",
			["filepiechart"] = "rbxassetid://10723365598",
			["fileplus"] = "rbxassetid://10723365877",
			["fileplus2"] = "rbxassetid://10723365766",
			["filequestion"] = "rbxassetid://10723365987",
			["filescan"] = "rbxassetid://10723366167",
			["filesearch"] = "rbxassetid://10723366550",
			["filesearch2"] = "rbxassetid://10723366340",
			["filesignature"] = "rbxassetid://10723366741",
			["filespreadsheet"] = "rbxassetid://10723366962",
			["filesymlink"] = "rbxassetid://10723367098",
			["fileterminal"] = "rbxassetid://10723367244",
			["filetext"] = "rbxassetid://10723367380",
			["filetype"] = "rbxassetid://10723367606",
			["filetype2"] = "rbxassetid://10723367509",
			["fileup"] = "rbxassetid://10723367734",
			["filevideo"] = "rbxassetid://10723373884",
			["filevideo2"] = "rbxassetid://10723367834",
			["filevolume"] = "rbxassetid://10723374172",
			["filevolume2"] = "rbxassetid://10723374030",
			["filewarning"] = "rbxassetid://10723374276",
			["filex"] = "rbxassetid://10723374544",
			["filex2"] = "rbxassetid://10723374378",
			["files"] = "rbxassetid://10723374759",
			["film"] = "rbxassetid://10723374981",
			["filter"] = "rbxassetid://10723375128",
			["fingerprint"] = "rbxassetid://10723375250",
			["flag"] = "rbxassetid://10723375890",
			["flagoff"] = "rbxassetid://10723375443",
			["flagtriangleleft"] = "rbxassetid://10723375608",
			["flagtriangleright"] = "rbxassetid://10723375727",
			["flame"] = "rbxassetid://10723376114",
			["flashlight"] = "rbxassetid://10723376471",
			["flashlightoff"] = "rbxassetid://10723376365",
			["flaskconical"] = "rbxassetid://10734883986",
			["flaskround"] = "rbxassetid://10723376614",
			["fliphorizontal"] = "rbxassetid://10723376884",
			["fliphorizontal2"] = "rbxassetid://10723376745",
			["flipvertical"] = "rbxassetid://10723377138",
			["flipvertical2"] = "rbxassetid://10723377026",
			["flower"] = "rbxassetid://10747830374",
			["flower2"] = "rbxassetid://10723377305",
			["focus"] = "rbxassetid://10723377537",
			["folder"] = "rbxassetid://10723387563",
			["folderarchive"] = "rbxassetid://10723384478",
			["foldercheck"] = "rbxassetid://10723384605",
			["folderclock"] = "rbxassetid://10723384731",
			["folderclosed"] = "rbxassetid://10723384893",
			["foldercog"] = "rbxassetid://10723385213",
			["foldercog2"] = "rbxassetid://10723385036",
			["folderdown"] = "rbxassetid://10723385338",
			["folderedit"] = "rbxassetid://10723385445",
			["folderheart"] = "rbxassetid://10723385545",
			["folderinput"] = "rbxassetid://10723385721",
			["folderkey"] = "rbxassetid://10723385848",
			["folderlock"] = "rbxassetid://10723386005",
			["folderminus"] = "rbxassetid://10723386127",
			["folderopen"] = "rbxassetid://10723386277",
			["folderoutput"] = "rbxassetid://10723386386",
			["folderplus"] = "rbxassetid://10723386531",
			["foldersearch"] = "rbxassetid://10723386787",
			["foldersearch2"] = "rbxassetid://10723386674",
			["foldersymlink"] = "rbxassetid://10723386930",
			["foldertree"] = "rbxassetid://10723387085",
			["folderup"] = "rbxassetid://10723387265",
			["folderx"] = "rbxassetid://10723387448",
			["folders"] = "rbxassetid://10723387721",
			["forminput"] = "rbxassetid://10723387841",
			["forward"] = "rbxassetid://10723388016",
			["frame"] = "rbxassetid://10723394389",
			["framer"] = "rbxassetid://10723394565",
			["frown"] = "rbxassetid://10723394681",
			["fuel"] = "rbxassetid://10723394846",
			["functionsquare"] = "rbxassetid://10723395041",
			["gamepad"] = "rbxassetid://10723395457",
			["gamepad2"] = "rbxassetid://10723395215",
			["gauge"] = "rbxassetid://10723395708",
			["gavel"] = "rbxassetid://10723395896",
			["gem"] = "rbxassetid://10723396000",
			["ghost"] = "rbxassetid://10723396107",
			["gift"] = "rbxassetid://10723396402",
			["giftcard"] = "rbxassetid://10723396225",
			["gitbranch"] = "rbxassetid://10723396676",
			["gitbranchplus"] = "rbxassetid://10723396542",
			["gitcommit"] = "rbxassetid://10723396812",
			["gitcompare"] = "rbxassetid://10723396954",
			["gitfork"] = "rbxassetid://10723397049",
			["gitmerge"] = "rbxassetid://10723397165",
			["gitpullrequest"] = "rbxassetid://10723397431",
			["gitpullrequestclosed"] = "rbxassetid://10723397268",
			["gitpullrequestdraft"] = "rbxassetid://10734884302",
			["glass"] = "rbxassetid://10723397788",
			["glass2"] = "rbxassetid://10723397529",
			["glasswater"] = "rbxassetid://10723397678",
			["glasses"] = "rbxassetid://10723397895",
			["globe"] = "rbxassetid://10723404337",
			["globe2"] = "rbxassetid://10723398002",
			["grab"] = "rbxassetid://10723404472",
			["graduationcap"] = "rbxassetid://10723404691",
			["grape"] = "rbxassetid://10723404822",
			["grid"] = "rbxassetid://10723404936",
			["griphorizontal"] = "rbxassetid://10723405089",
			["gripvertical"] = "rbxassetid://10723405236",
			["hammer"] = "rbxassetid://10723405360",
			["hand"] = "rbxassetid://10723405649",
			["handmetal"] = "rbxassetid://10723405508",
			["harddrive"] = "rbxassetid://10723405749",
			["hardhat"] = "rbxassetid://10723405859",
			["hash"] = "rbxassetid://10723405975",
			["haze"] = "rbxassetid://10723406078",
			["headphones"] = "rbxassetid://10723406165",
			["heart"] = "rbxassetid://10723406885",
			["heartcrack"] = "rbxassetid://10723406299",
			["hearthandshake"] = "rbxassetid://10723406480",
			["heartoff"] = "rbxassetid://10723406662",
			["heartpulse"] = "rbxassetid://10723406795",
			["helpcircle"] = "rbxassetid://10723406988",
			["hexagon"] = "rbxassetid://10723407092",
			["highlighter"] = "rbxassetid://10723407192",
			["history"] = "rbxassetid://10723407335",
			["home"] = "rbxassetid://10723407389",
			["hourglass"] = "rbxassetid://10723407498",
			["icecream"] = "rbxassetid://10723414308",
			["image"] = "rbxassetid://10723415040",
			["imageminus"] = "rbxassetid://10723414487",
			["imageoff"] = "rbxassetid://10723414677",
			["imageplus"] = "rbxassetid://10723414827",
			["import"] = "rbxassetid://10723415205",
			["inbox"] = "rbxassetid://10723415335",
			["indent"] = "rbxassetid://10723415494",
			["indianrupee"] = "rbxassetid://10723415642",
			["infinity"] = "rbxassetid://10723415766",
			["info"] = "rbxassetid://10723415903",
			["inspect"] = "rbxassetid://10723416057",
			["italic"] = "rbxassetid://10723416195",
			["japaneseyen"] = "rbxassetid://10723416363",
			["joystick"] = "rbxassetid://10723416527",
			["key"] = "rbxassetid://10723416652",
			["keyboard"] = "rbxassetid://10723416765",
			["lamp"] = "rbxassetid://10723417513",
			["lampceiling"] = "rbxassetid://10723416922",
			["lampdesk"] = "rbxassetid://10723417016",
			["lampfloor"] = "rbxassetid://10723417131",
			["lampwalldown"] = "rbxassetid://10723417240",
			["lampwallup"] = "rbxassetid://10723417356",
			["landmark"] = "rbxassetid://10723417608",
			["languages"] = "rbxassetid://10723417703",
			["laptop"] = "rbxassetid://10723423881",
			["laptop2"] = "rbxassetid://10723417797",
			["lasso"] = "rbxassetid://10723424235",
			["lassoselect"] = "rbxassetid://10723424058",
			["laugh"] = "rbxassetid://10723424372",
			["layers"] = "rbxassetid://10723424505",
			["layout"] = "rbxassetid://10723425376",
			["layoutdashboard"] = "rbxassetid://10723424646",
			["layoutgrid"] = "rbxassetid://10723424838",
			["layoutlist"] = "rbxassetid://10723424963",
			["layouttemplate"] = "rbxassetid://10723425187",
			["leaf"] = "rbxassetid://10723425539",
			["library"] = "rbxassetid://10723425615",
			["lifebuoy"] = "rbxassetid://10723425685",
			["lightbulb"] = "rbxassetid://10723425852",
			["lightbulboff"] = "rbxassetid://10723425762",
			["linechart"] = "rbxassetid://10723426393",
			["link"] = "rbxassetid://10723426722",
			["link2"] = "rbxassetid://10723426595",
			["link2off"] = "rbxassetid://10723426513",
			["list"] = "rbxassetid://10723433811",
			["listchecks"] = "rbxassetid://10734884548",
			["listend"] = "rbxassetid://10723426886",
			["listminus"] = "rbxassetid://10723426986",
			["listmusic"] = "rbxassetid://10723427081",
			["listordered"] = "rbxassetid://10723427199",
			["listplus"] = "rbxassetid://10723427334",
			["liststart"] = "rbxassetid://10723427494",
			["listvideo"] = "rbxassetid://10723427619",
			["listx"] = "rbxassetid://10723433655",
			["loader"] = "rbxassetid://10723434070",
			["loader2"] = "rbxassetid://10723433935",
			["locate"] = "rbxassetid://10723434557",
			["locatefixed"] = "rbxassetid://10723434236",
			["locateoff"] = "rbxassetid://10723434379",
			["lock"] = "rbxassetid://10723434711",
			["login"] = "rbxassetid://10723434830",
			["logout"] = "rbxassetid://10723434906",
			["luggage"] = "rbxassetid://10723434993",
			["magnet"] = "rbxassetid://10723435069",
			["mail"] = "rbxassetid://10734885430",
			["mailcheck"] = "rbxassetid://10723435182",
			["mailminus"] = "rbxassetid://10723435261",
			["mailopen"] = "rbxassetid://10723435342",
			["mailplus"] = "rbxassetid://10723435443",
			["mailquestion"] = "rbxassetid://10723435515",
			["mailsearch"] = "rbxassetid://10734884739",
			["mailwarning"] = "rbxassetid://10734885015",
			["mailx"] = "rbxassetid://10734885247",
			["mails"] = "rbxassetid://10734885614",
			["map"] = "rbxassetid://10734886202",
			["mappin"] = "rbxassetid://10734886004",
			["mappinoff"] = "rbxassetid://10734885803",
			["maximize"] = "rbxassetid://10734886735",
			["maximize2"] = "rbxassetid://10734886496",
			["medal"] = "rbxassetid://10734887072",
			["megaphone"] = "rbxassetid://10734887454",
			["megaphoneoff"] = "rbxassetid://10734887311",
			["meh"] = "rbxassetid://10734887603",
			["menu"] = "rbxassetid://10734887784",
			["messagecircle"] = "rbxassetid://10734888000",
			["messagesquare"] = "rbxassetid://10734888228",
			["mic"] = "rbxassetid://10734888864",
			["mic2"] = "rbxassetid://10734888430",
			["micoff"] = "rbxassetid://10734888646",
			["microscope"] = "rbxassetid://10734889106",
			["microwave"] = "rbxassetid://10734895076",
			["milestone"] = "rbxassetid://10734895310",
			["minimize"] = "rbxassetid://10734895698",
			["minimize2"] = "rbxassetid://10734895530",
			["minus"] = "rbxassetid://10734896206",
			["minuscircle"] = "rbxassetid://10734895856",
			["minussquare"] = "rbxassetid://10734896029",
			["monitor"] = "rbxassetid://10734896881",
			["monitoroff"] = "rbxassetid://10734896360",
			["monitorspeaker"] = "rbxassetid://10734896512",
			["moon"] = "rbxassetid://10734897102",
			["morehorizontal"] = "rbxassetid://10734897250",
			["morevertical"] = "rbxassetid://10734897387",
			["mountain"] = "rbxassetid://10734897956",
			["mountainsnow"] = "rbxassetid://10734897665",
			["mouse"] = "rbxassetid://10734898592",
			["mousepointer"] = "rbxassetid://10734898476",
			["mousepointer2"] = "rbxassetid://10734898194",
			["mousepointerclick"] = "rbxassetid://10734898355",
			["move"] = "rbxassetid://10734900011",
			["move3d"] = "rbxassetid://10734898756",
			["movediagonal"] = "rbxassetid://10734899164",
			["movediagonal2"] = "rbxassetid://10734898934",
			["movehorizontal"] = "rbxassetid://10734899414",
			["movevertical"] = "rbxassetid://10734899821",
			["music"] = "rbxassetid://10734905958",
			["music2"] = "rbxassetid://10734900215",
			["music3"] = "rbxassetid://10734905665",
			["music4"] = "rbxassetid://10734905823",
			["navigation"] = "rbxassetid://10734906744",
			["navigation2"] = "rbxassetid://10734906332",
			["navigation2off"] = "rbxassetid://10734906144",
			["navigationoff"] = "rbxassetid://10734906580",
			["network"] = "rbxassetid://10734906975",
			["newspaper"] = "rbxassetid://10734907168",
			["octagon"] = "rbxassetid://10734907361",
			["option"] = "rbxassetid://10734907649",
			["outdent"] = "rbxassetid://10734907933",
			["package"] = "rbxassetid://10734909540",
			["package2"] = "rbxassetid://10734908151",
			["packagecheck"] = "rbxassetid://10734908384",
			["packageminus"] = "rbxassetid://10734908626",
			["packageopen"] = "rbxassetid://10734908793",
			["packageplus"] = "rbxassetid://10734909016",
			["packagesearch"] = "rbxassetid://10734909196",
			["packagex"] = "rbxassetid://10734909375",
			["paintbucket"] = "rbxassetid://10734909847",
			["paintbrush"] = "rbxassetid://10734910187",
			["paintbrush2"] = "rbxassetid://10734910030",
			["palette"] = "rbxassetid://10734910430",
			["palmtree"] = "rbxassetid://10734910680",
			["paperclip"] = "rbxassetid://10734910927",
			["partypopper"] = "rbxassetid://10734918735",
			["pause"] = "rbxassetid://10734919336",
			["pausecircle"] = "rbxassetid://10735024209",
			["pauseoctagon"] = "rbxassetid://10734919143",
			["pentool"] = "rbxassetid://10734919503",
			["pencil"] = "rbxassetid://10734919691",
			["percent"] = "rbxassetid://10734919919",
			["personstanding"] = "rbxassetid://10734920149",
			["phone"] = "rbxassetid://10734921524",
			["phonecall"] = "rbxassetid://10734920305",
			["phoneforwarded"] = "rbxassetid://10734920508",
			["phoneincoming"] = "rbxassetid://10734920694",
			["phonemissed"] = "rbxassetid://10734920845",
			["phoneoff"] = "rbxassetid://10734921077",
			["phoneoutgoing"] = "rbxassetid://10734921288",
			["piechart"] = "rbxassetid://10734921727",
			["piggybank"] = "rbxassetid://10734921935",
			["pin"] = "rbxassetid://10734922324",
			["pinoff"] = "rbxassetid://10734922180",
			["pipette"] = "rbxassetid://10734922497",
			["pizza"] = "rbxassetid://10734922774",
			["plane"] = "rbxassetid://10734922971",
			["play"] = "rbxassetid://10734923549",
			["playcircle"] = "rbxassetid://10734923214",
			["plus"] = "rbxassetid://10734924532",
			["pluscircle"] = "rbxassetid://10734923868",
			["plussquare"] = "rbxassetid://10734924219",
			["podcast"] = "rbxassetid://10734929553",
			["pointer"] = "rbxassetid://10734929723",
			["poundsterling"] = "rbxassetid://10734929981",
			["power"] = "rbxassetid://10734930466",
			["poweroff"] = "rbxassetid://10734930257",
			["printer"] = "rbxassetid://10734930632",
			["puzzle"] = "rbxassetid://10734930886",
			["quote"] = "rbxassetid://10734931234",
			["radio"] = "rbxassetid://10734931596",
			["radioreceiver"] = "rbxassetid://10734931402",
			["rectanglehorizontal"] = "rbxassetid://10734931777",
			["rectanglevertical"] = "rbxassetid://10734932081",
			["recycle"] = "rbxassetid://10734932295",
			["redo"] = "rbxassetid://10734932822",
			["redo2"] = "rbxassetid://10734932586",
			["refreshccw"] = "rbxassetid://10734933056",
			["refreshcw"] = "rbxassetid://10734933222",
			["refrigerator"] = "rbxassetid://10734933465",
			["regex"] = "rbxassetid://10734933655",
			["repeat"] = "rbxassetid://10734933966",
			["repeat1"] = "rbxassetid://10734933826",
			["reply"] = "rbxassetid://10734934252",
			["replyall"] = "rbxassetid://10734934132",
			["rewind"] = "rbxassetid://10734934347",
			["rocket"] = "rbxassetid://10734934585",
			["rockingchair"] = "rbxassetid://10734939942",
			["rotate3d"] = "rbxassetid://10734940107",
			["rotateccw"] = "rbxassetid://10734940376",
			["rotatecw"] = "rbxassetid://10734940654",
			["rss"] = "rbxassetid://10734940825",
			["ruler"] = "rbxassetid://10734941018",
			["russianruble"] = "rbxassetid://10734941199",
			["sailboat"] = "rbxassetid://10734941354",
			["save"] = "rbxassetid://10734941499",
			["scale"] = "rbxassetid://10734941912",
			["scale3d"] = "rbxassetid://10734941739",
			["scaling"] = "rbxassetid://10734942072",
			["scan"] = "rbxassetid://10734942565",
			["scanface"] = "rbxassetid://10734942198",
			["scanline"] = "rbxassetid://10734942351",
			["scissors"] = "rbxassetid://10734942778",
			["screenshare"] = "rbxassetid://10734943193",
			["screenshareoff"] = "rbxassetid://10734942967",
			["scroll"] = "rbxassetid://10734943448",
			["search"] = "rbxassetid://10734943674",
			["send"] = "rbxassetid://10734943902",
			["separatorhorizontal"] = "rbxassetid://10734944115",
			["separatorvertical"] = "rbxassetid://10734944326",
			["server"] = "rbxassetid://10734949856",
			["servercog"] = "rbxassetid://10734944444",
			["servercrash"] = "rbxassetid://10734944554",
			["serveroff"] = "rbxassetid://10734944668",
			["settings"] = "rbxassetid://10734950309",
			["settings2"] = "rbxassetid://10734950020",
			["share"] = "rbxassetid://10734950813",
			["share2"] = "rbxassetid://10734950553",
			["sheet"] = "rbxassetid://10734951038",
			["shield"] = "rbxassetid://10734951847",
			["shieldalert"] = "rbxassetid://10734951173",
			["shieldcheck"] = "rbxassetid://10734951367",
			["shieldclose"] = "rbxassetid://10734951535",
			["shieldoff"] = "rbxassetid://10734951684",
			["shirt"] = "rbxassetid://10734952036",
			["shoppingbag"] = "rbxassetid://10734952273",
			["shoppingcart"] = "rbxassetid://10734952479",
			["shovel"] = "rbxassetid://10734952773",
			["showerhead"] = "rbxassetid://10734952942",
			["shrink"] = "rbxassetid://10734953073",
			["shrub"] = "rbxassetid://10734953241",
			["shuffle"] = "rbxassetid://10734953451",
			["sidebar"] = "rbxassetid://10734954301",
			["sidebarclose"] = "rbxassetid://10734953715",
			["sidebaropen"] = "rbxassetid://10734954000",
			["sigma"] = "rbxassetid://10734954538",
			["signal"] = "rbxassetid://10734961133",
			["signalhigh"] = "rbxassetid://10734954807",
			["signallow"] = "rbxassetid://10734955080",
			["signalmedium"] = "rbxassetid://10734955336",
			["signalzero"] = "rbxassetid://10734960878",
			["siren"] = "rbxassetid://10734961284",
			["skipback"] = "rbxassetid://10734961526",
			["skipforward"] = "rbxassetid://10734961809",
			["skull"] = "rbxassetid://10734962068",
			["slack"] = "rbxassetid://10734962339",
			["slash"] = "rbxassetid://10734962600",
			["slice"] = "rbxassetid://10734963024",
			["sliders"] = "rbxassetid://10734963400",
			["slidershorizontal"] = "rbxassetid://10734963191",
			["smartphone"] = "rbxassetid://10734963940",
			["smartphonecharging"] = "rbxassetid://10734963671",
			["smile"] = "rbxassetid://10734964441",
			["smileplus"] = "rbxassetid://10734964188",
			["snowflake"] = "rbxassetid://10734964600",
			["sofa"] = "rbxassetid://10734964852",
			["sortasc"] = "rbxassetid://10734965115",
			["sortdesc"] = "rbxassetid://10734965287",
			["speaker"] = "rbxassetid://10734965419",
			["sprout"] = "rbxassetid://10734965572",
			["square"] = "rbxassetid://10734965702",
			["star"] = "rbxassetid://10734966248",
			["starhalf"] = "rbxassetid://10734965897",
			["staroff"] = "rbxassetid://10734966097",
			["stethoscope"] = "rbxassetid://10734966384",
			["sticker"] = "rbxassetid://10734972234",
			["stickynote"] = "rbxassetid://10734972463",
			["stopcircle"] = "rbxassetid://10734972621",
			["stretchhorizontal"] = "rbxassetid://10734972862",
			["stretchvertical"] = "rbxassetid://10734973130",
			["strikethrough"] = "rbxassetid://10734973290",
			["subscript"] = "rbxassetid://10734973457",
			["sun"] = "rbxassetid://10734974297",
			["sundim"] = "rbxassetid://10734973645",
			["sunmedium"] = "rbxassetid://10734973778",
			["sunmoon"] = "rbxassetid://10734973999",
			["sunsnow"] = "rbxassetid://10734974130",
			["sunrise"] = "rbxassetid://10734974522",
			["sunset"] = "rbxassetid://10734974689",
			["superscript"] = "rbxassetid://10734974850",
			["swissfranc"] = "rbxassetid://10734975024",
			["switchcamera"] = "rbxassetid://10734975214",
			["sword"] = "rbxassetid://10734975486",
			["swords"] = "rbxassetid://10734975692",
			["syringe"] = "rbxassetid://10734975932",
			["table"] = "rbxassetid://10734976230",
			["table2"] = "rbxassetid://10734976097",
			["tablet"] = "rbxassetid://10734976394",
			["tag"] = "rbxassetid://10734976528",
			["tags"] = "rbxassetid://10734976739",
			["target"] = "rbxassetid://10734977012",
			["tent"] = "rbxassetid://10734981750",
			["terminal"] = "rbxassetid://10734982144",
			["terminalsquare"] = "rbxassetid://10734981995",
			["textcursor"] = "rbxassetid://10734982395",
			["textcursorinput"] = "rbxassetid://10734982297",
			["thermometer"] = "rbxassetid://10734983134",
			["thermometersnowflake"] = "rbxassetid://10734982571",
			["thermometersun"] = "rbxassetid://10734982771",
			["thumbsdown"] = "rbxassetid://10734983359",
			["thumbsup"] = "rbxassetid://10734983629",
			["ticket"] = "rbxassetid://10734983868",
			["timer"] = "rbxassetid://10734984606",
			["timeroff"] = "rbxassetid://10734984138",
			["timerreset"] = "rbxassetid://10734984355",
			["toggleleft"] = "rbxassetid://10734984834",
			["toggleright"] = "rbxassetid://10734985040",
			["tornado"] = "rbxassetid://10734985247",
			["toybrick"] = "rbxassetid://10747361919",
			["train"] = "rbxassetid://10747362105",
			["trash"] = "rbxassetid://10747362393",
			["trash2"] = "rbxassetid://10747362241",
			["treedeciduous"] = "rbxassetid://10747362534",
			["treepine"] = "rbxassetid://10747362748",
			["trees"] = "rbxassetid://10747363016",
			["trendingdown"] = "rbxassetid://10747363205",
			["trendingup"] = "rbxassetid://10747363465",
			["triangle"] = "rbxassetid://10747363621",
			["trophy"] = "rbxassetid://10747363809",
			["truck"] = "rbxassetid://10747364031",
			["tv"] = "rbxassetid://10747364593",
			["tv2"] = "rbxassetid://10747364302",
			["type"] = "rbxassetid://10747364761",
			["umbrella"] = "rbxassetid://10747364971",
			["underline"] = "rbxassetid://10747365191",
			["undo"] = "rbxassetid://10747365484",
			["undo2"] = "rbxassetid://10747365359",
			["unlink"] = "rbxassetid://10747365771",
			["unlink2"] = "rbxassetid://10747397871",
			["unlock"] = "rbxassetid://10747366027",
			["upload"] = "rbxassetid://10747366434",
			["uploadcloud"] = "rbxassetid://10747366266",
			["usb"] = "rbxassetid://10747366606",
			["user"] = "rbxassetid://10747373176",
			["usercheck"] = "rbxassetid://10747371901",
			["usercog"] = "rbxassetid://10747372167",
			["userminus"] = "rbxassetid://10747372346",
			["userplus"] = "rbxassetid://10747372702",
			["userx"] = "rbxassetid://10747372992",
			["users"] = "rbxassetid://10747373426",
			["utensils"] = "rbxassetid://10747373821",
			["utensilscrossed"] = "rbxassetid://10747373629",
			["venetianmask"] = "rbxassetid://10747374003",
			["verified"] = "rbxassetid://10747374131",
			["vibrate"] = "rbxassetid://10747374489",
			["vibrateoff"] = "rbxassetid://10747374269",
			["video"] = "rbxassetid://10747374938",
			["videooff"] = "rbxassetid://10747374721",
			["view"] = "rbxassetid://10747375132",
			["voicemail"] = "rbxassetid://10747375281",
			["volume"] = "rbxassetid://10747376008",
			["volume1"] = "rbxassetid://10747375450",
			["volume2"] = "rbxassetid://10747375679",
			["volumex"] = "rbxassetid://10747375880",
			["wallet"] = "rbxassetid://10747376205",
			["wand"] = "rbxassetid://10747376565",
			["wand2"] = "rbxassetid://10747376349",
			["watch"] = "rbxassetid://10747376722",
			["waves"] = "rbxassetid://10747376931",
			["webcam"] = "rbxassetid://10747381992",
			["wifi"] = "rbxassetid://10747382504",
			["wifioff"] = "rbxassetid://10747382268",
			["wind"] = "rbxassetid://10747382750",
			["wraptext"] = "rbxassetid://10747383065",
			["wrench"] = "rbxassetid://10747383470",
			["x"] = "rbxassetid://10747384394",
			["xcircle"] = "rbxassetid://10747383819",
			["xoctagon"] = "rbxassetid://10747384037",
			["xsquare"] = "rbxassetid://10747384217",
			["zoomin"] = "rbxassetid://10747384552",
			["zoomout"] = "rbxassetid://10747384679",
			["aarrowdown"] = "rbxassetid://92867583610071",
			["aarrowup"] = "rbxassetid://132318504999733",
			["alargesmall"] = "rbxassetid://111491496660216",
			["alarmclockcheck"] = "rbxassetid://76437352099157",
			["alarmclockminus"] = "rbxassetid://77364179863205",
			["alarmclockplus"] = "rbxassetid://80468822979214",
			["alarmsmoke"] = "rbxassetid://96965448419685",
			["ambulance"] = "rbxassetid://78599995190651",
			["ampersand"] = "rbxassetid://75272915739209",
			["ampersands"] = "rbxassetid://126947193455996",
			["amphora"] = "rbxassetid://137370389604364",
			["antenna"] = "rbxassetid://99628923540956",
			["anvil"] = "rbxassetid://100203029845919",
			["appwindowmac"] = "rbxassetid://79587216113811",
			["appwindow"] = "rbxassetid://93142176757189",
			["archivex"] = "rbxassetid://75830115088395",
			["arrowbigdowndash"] = "rbxassetid://137987229582002",
			["arrowbigleftdash"] = "rbxassetid://97827621354677",
			["arrowbigrightdash"] = "rbxassetid://117825834972403",
			["arrowbigupdash"] = "rbxassetid://99260194327483",
			["arrowdown01"] = "rbxassetid://120961896217875",
			["arrowdown10"] = "rbxassetid://93474255891850",
			["arrowdownaz"] = "rbxassetid://99554596207900",
			["arrowdownfromline"] = "rbxassetid://132045845807798",
			["arrowdownnarrowwide"] = "rbxassetid://129105261655061",
			["arrowdowntodot"] = "rbxassetid://101675355931221",
			["arrowdowntoline"] = "rbxassetid://87050478931254",
			["arrowdownup"] = "rbxassetid://85780258549577",
			["arrowdownwidenarrow"] = "rbxassetid://88461733425991",
			["arrowdownza"] = "rbxassetid://76115279362232",
			["arrowleftfromline"] = "rbxassetid://87857914437603",
			["arrowlefttoline"] = "rbxassetid://118645136026970",
			["arrowrightfromline"] = "rbxassetid://74073639809355",
			["arrowrightleft"] = "rbxassetid://77015754304300",
			["arrowrighttoline"] = "rbxassetid://78632510329852",
			["arrowup01"] = "rbxassetid://105257823943016",
			["arrowup10"] = "rbxassetid://134175521693798",
			["arrowupaz"] = "rbxassetid://77763416595160",
			["arrowupfromdot"] = "rbxassetid://124408496673275",
			["arrowupfromline"] = "rbxassetid://95777664626453",
			["arrowupnarrowwide"] = "rbxassetid://73006024672636",
			["arrowuptoline"] = "rbxassetid://108818207813537",
			["arrowupwidenarrow"] = "rbxassetid://87437426951568",
			["arrowupza"] = "rbxassetid://107546173611884",
			["arrowsupfromline"] = "rbxassetid://133710016938621",
			["atom"] = "rbxassetid://73167696981648",
			["audiolines"] = "rbxassetid://70930641819242",
			["audiowaveform"] = "rbxassetid://86462036665209",
			["badgealert"] = "rbxassetid://101829200081951",
			["badgecent"] = "rbxassetid://133345018873154",
			["badgecheck"] = "rbxassetid://76078495178149",
			["badgedollarsign"] = "rbxassetid://127139803581141",
			["badgeeuro"] = "rbxassetid://120016477674659",
			["badgeindianrupee"] = "rbxassetid://75659682309981",
			["badgeinfo"] = "rbxassetid://131995373201472",
			["badgejapaneseyen"] = "rbxassetid://99081574588615",
			["badgeminus"] = "rbxassetid://140321561183881",
			["badgepercent"] = "rbxassetid://121359224294885",
			["badgeplus"] = "rbxassetid://100325578561866",
			["badgepoundsterling"] = "rbxassetid://119688217279444",
			["badgequestionmark"] = "rbxassetid://121464963737502",
			["badgerussianruble"] = "rbxassetid://108839463659864",
			["badgeswissfranc"] = "rbxassetid://91447608372740",
			["badgeturkishlira"] = "rbxassetid://137839965873529",
			["badgex"] = "rbxassetid://122931434733842",
			["badge"] = "rbxassetid://116620312917084",
			["ban"] = "rbxassetid://90767043015246",
			["bandage"] = "rbxassetid://129660129590770",
			["banknotearrowdown"] = "rbxassetid://139366449345199",
			["banknotearrowup"] = "rbxassetid://133758343082529",
			["banknotex"] = "rbxassetid://95348701438065",
			["barrel"] = "rbxassetid://130647115622774",
			["batteryplus"] = "rbxassetid://91931341486966",
			["batterywarning"] = "rbxassetid://115230083817257",
			["beanoff"] = "rbxassetid://98164436608714",
			["bean"] = "rbxassetid://89491967076869",
			["beef"] = "rbxassetid://105850162318915",
			["beeroff"] = "rbxassetid://120333134736361",
			["belldot"] = "rbxassetid://93161277118810",
			["bellelectric"] = "rbxassetid://100277767266983",
			["betweenhorizontalend"] = "rbxassetid://81602774794322",
			["betweenhorizontalstart"] = "rbxassetid://76112384929846",
			["betweenverticalend"] = "rbxassetid://72817612571631",
			["betweenverticalstart"] = "rbxassetid://85278312190301",
			["bicepsflexed"] = "rbxassetid://82004462003936",
			["binoculars"] = "rbxassetid://101460003267896",
			["biohazard"] = "rbxassetid://95956532900432",
			["bird"] = "rbxassetid://132284145117371",
			["birdhouse"] = "rbxassetid://83999157401433",
			["blend"] = "rbxassetid://111679612185257",
			["blinds"] = "rbxassetid://71164165283925",
			["blocks"] = "rbxassetid://72212693357737",
			["bolt"] = "rbxassetid://102881251417484",
			["booka"] = "rbxassetid://104067275658465",
			["bookalert"] = "rbxassetid://124159928044853",
			["bookaudio"] = "rbxassetid://109208148317037",
			["bookcheck"] = "rbxassetid://115999656081696",
			["bookcopy"] = "rbxassetid://108543407492005",
			["bookdashed"] = "rbxassetid://127430784795958",
			["bookdown"] = "rbxassetid://101011730128222",
			["bookheadphones"] = "rbxassetid://108670200799574",
			["bookheart"] = "rbxassetid://112788845135284",
			["bookimage"] = "rbxassetid://80808285757226",
			["bookkey"] = "rbxassetid://116024426170705",
			["booklock"] = "rbxassetid://118765061220571",
			["bookmarked"] = "rbxassetid://73211024251780",
			["bookminus"] = "rbxassetid://112724962046282",
			["bookopencheck"] = "rbxassetid://130848362492667",
			["bookopentext"] = "rbxassetid://100629528672195",
			["bookplus"] = "rbxassetid://140267785051233",
			["booktext"] = "rbxassetid://94011772484232",
			["booktype"] = "rbxassetid://97817304725443",
			["bookup2"] = "rbxassetid://130161620853665",
			["bookup"] = "rbxassetid://98640174079190",
			["bookuser"] = "rbxassetid://128489189240523",
			["bookx"] = "rbxassetid://118754548186537",
			["bookmarkcheck"] = "rbxassetid://93940443347986",
			["bookmarkx"] = "rbxassetid://112272342584706",
			["boombox"] = "rbxassetid://99901322535868",
			["botmessagesquare"] = "rbxassetid://96145330292478",
			["botoff"] = "rbxassetid://140417690560013",
			["bottlewine"] = "rbxassetid://131675403196921",
			["bowarrow"] = "rbxassetid://124089655150375",
			["braces"] = "rbxassetid://117761094704041",
			["brackets"] = "rbxassetid://74368995728099",
			["braincircuit"] = "rbxassetid://70547962410202",
			["braincog"] = "rbxassetid://132039205501538",
			["brain"] = "rbxassetid://92424107303177",
			["brickwallfire"] = "rbxassetid://92980588705520",
			["brickwallshield"] = "rbxassetid://75954432775071",
			["brickwall"] = "rbxassetid://112878522258821",
			["briefcasebusiness"] = "rbxassetid://129135125207283",
			["briefcaseconveyorbelt"] = "rbxassetid://108665725653714",
			["briefcasemedical"] = "rbxassetid://119917756334087",
			["bringtofront"] = "rbxassetid://132975903553748",
			["brushcleaning"] = "rbxassetid://71728977448805",
			["bubbles"] = "rbxassetid://106183424168227",
			["bugoff"] = "rbxassetid://88020025049245",
			["bugplay"] = "rbxassetid://80107955888092",
			["busfront"] = "rbxassetid://89863432456045",
			["cablecar"] = "rbxassetid://128643682205596",
			["cable"] = "rbxassetid://128449944504901",
			["cakeslice"] = "rbxassetid://136769828413242",
			["calendar1"] = "rbxassetid://98458364171044",
			["calendararrowdown"] = "rbxassetid://108415736543437",
			["calendararrowup"] = "rbxassetid://70574654109118",
			["calendarcog"] = "rbxassetid://122402172360287",
			["calendarfold"] = "rbxassetid://117368871270394",
			["calendarminus2"] = "rbxassetid://98846170279891",
			["calendarplus2"] = "rbxassetid://112264562093883",
			["calendarsync"] = "rbxassetid://78082218499697",
			["candycane"] = "rbxassetid://71689468772492",
			["candyoff"] = "rbxassetid://110232752314832",
			["candy"] = "rbxassetid://107812129154678",
			["cannabis"] = "rbxassetid://98792006538601",
			["captionsoff"] = "rbxassetid://105223545364193",
			["captions"] = "rbxassetid://104960225031445",
			["carfront"] = "rbxassetid://87380942739063",
			["cartaxifront"] = "rbxassetid://122455403384057",
			["caravan"] = "rbxassetid://120070979471783",
			["cardsim"] = "rbxassetid://134490550095771",
			["caselower"] = "rbxassetid://129303130603241",
			["casesensitive"] = "rbxassetid://125410273293056",
			["caseupper"] = "rbxassetid://111633433531325",
			["cassettetape"] = "rbxassetid://137065788934157",
			["castle"] = "rbxassetid://119275077187784",
			["cat"] = "rbxassetid://124252153404931",
			["cctv"] = "rbxassetid://99979894766624",
			["chartarea"] = "rbxassetid://123446436762366",
			["chartbarbig"] = "rbxassetid://72336824986044",
			["chartbardecreasing"] = "rbxassetid://107217459044963",
			["chartbarincreasing"] = "rbxassetid://88268905998571",
			["chartbarstacked"] = "rbxassetid://98478751113024",
			["chartbar"] = "rbxassetid://105389816384108",
			["chartcandlestick"] = "rbxassetid://125676898615697",
			["chartcolumnbig"] = "rbxassetid://98598733210787",
			["chartcolumndecreasing"] = "rbxassetid://73586137373563",
			["chartcolumnincreasing"] = "rbxassetid://120421615068601",
			["chartcolumnstacked"] = "rbxassetid://86031449675105",
			["chartcolumn"] = "rbxassetid://97915995538580",
			["chartgantt"] = "rbxassetid://88811660555940",
			["chartline"] = "rbxassetid://101833156055618",
			["chartnetwork"] = "rbxassetid://104027882693561",
			["chartnoaxescolumndecreasing"] = "rbxassetid://123371717192542",
			["chartnoaxescolumnincreasing"] = "rbxassetid://140383830943049",
			["chartnoaxescolumn"] = "rbxassetid://94078751170351",
			["chartnoaxescombined"] = "rbxassetid://121424233161912",
			["chartnoaxesgantt"] = "rbxassetid://131936541106368",
			["chartpie"] = "rbxassetid://113412261630136",
			["chartscatter"] = "rbxassetid://108217585014571",
			["chartspline"] = "rbxassetid://90307460742494",
			["checkcheck"] = "rbxassetid://95183312173858",
			["checkline"] = "rbxassetid://115122343485290",
			["chessbishop"] = "rbxassetid://121701705580238",
			["chessking"] = "rbxassetid://90885687223462",
			["chessknight"] = "rbxassetid://96467707042169",
			["chesspawn"] = "rbxassetid://111318574652751",
			["chessqueen"] = "rbxassetid://98304702099749",
			["chessrook"] = "rbxassetid://76223925830262",
			["chevronsleftrightellipsis"] = "rbxassetid://125035817741526",
			["chromium"] = "rbxassetid://128165143739006",
			["church"] = "rbxassetid://113714744350666",
			["cigaretteoff"] = "rbxassetid://77797883078452",
			["circlealert"] = "rbxassetid://83898160590116",
			["circlearrowdown"] = "rbxassetid://95901860261344",
			["circlearrowleft"] = "rbxassetid://102148876968988",
			["circlearrowoutdownleft"] = "rbxassetid://140598097856694",
			["circlearrowoutdownright"] = "rbxassetid://119952801379305",
			["circlearrowoutupleft"] = "rbxassetid://132858212688303",
			["circlearrowoutupright"] = "rbxassetid://81783743753173",
			["circlearrowright"] = "rbxassetid://70786767999559",
			["circlearrowup"] = "rbxassetid://84395128546494",
			["circlecheckbig"] = "rbxassetid://93202927221730",
			["circlecheck"] = "rbxassetid://85262178816537",
			["circlechevrondown"] = "rbxassetid://137069490345718",
			["circlechevronleft"] = "rbxassetid://130250009740827",
			["circlechevronright"] = "rbxassetid://125943696958495",
			["circlechevronup"] = "rbxassetid://111223574026321",
			["circledashed"] = "rbxassetid://126799443883746",
			["circledivide"] = "rbxassetid://106398997754208",
			["circledollarsign"] = "rbxassetid://91106238890387",
			["circledotdashed"] = "rbxassetid://111451232827180",
			["circleequal"] = "rbxassetid://95133963751438",
			["circlefadingarrowup"] = "rbxassetid://104648212910336",
			["circlefadingplus"] = "rbxassetid://91847890443490",
			["circlegauge"] = "rbxassetid://108157549473765",
			["circleminus"] = "rbxassetid://133556159576809",
			["circleoff"] = "rbxassetid://97923456918886",
			["circleparkingoff"] = "rbxassetid://128369410981252",
			["circleparking"] = "rbxassetid://124034962915196",
			["circlepause"] = "rbxassetid://139337739700879",
			["circlepercent"] = "rbxassetid://133311912860256",
			["circleplay"] = "rbxassetid://120408917249739",
			["circleplus"] = "rbxassetid://113157136350384",
			["circlepoundsterling"] = "rbxassetid://105476153083828",
			["circlepower"] = "rbxassetid://140676030155098",
			["circlequestionmark"] = "rbxassetid://97516698664325",
			["circleslash2"] = "rbxassetid://136766902186549",
			["circleslash"] = "rbxassetid://125206439913049",
			["circlesmall"] = "rbxassetid://73685402843600",
			["circlestar"] = "rbxassetid://120318414957104",
			["circlestop"] = "rbxassetid://87400503942659",
			["circleuserround"] = "rbxassetid://95489465399880",
			["circleuser"] = "rbxassetid://136220511671311",
			["circlex"] = "rbxassetid://76821953846248",
			["circuitboard"] = "rbxassetid://107695264369312",
			["clipboardclock"] = "rbxassetid://123957515687745",
			["clipboardminus"] = "rbxassetid://107968008485671",
			["clipboardpaste"] = "rbxassetid://74382068849983",
			["clipboardpenline"] = "rbxassetid://77711589791615",
			["clipboardpen"] = "rbxassetid://75290966822953",
			["clipboardplus"] = "rbxassetid://134285318675662",
			["clockalert"] = "rbxassetid://97157344465162",
			["clockarrowdown"] = "rbxassetid://92349314416042",
			["clockarrowup"] = "rbxassetid://111484286332629",
			["clockcheck"] = "rbxassetid://85231630218857",
			["clockfading"] = "rbxassetid://93205297285245",
			["clockplus"] = "rbxassetid://93367709263150",
			["closedcaption"] = "rbxassetid://99832644030788",
			["cloudalert"] = "rbxassetid://91967273658626",
			["cloudcheck"] = "rbxassetid://97318598202432",
			["clouddownload"] = "rbxassetid://121435581993566",
			["cloudupload"] = "rbxassetid://93307473217005",
			["club"] = "rbxassetid://108490365816628",
			["codexml"] = "rbxassetid://130150477351734",
			["columns2"] = "rbxassetid://113004100221850",
			["columns3cog"] = "rbxassetid://121589691981064",
			["columns3"] = "rbxassetid://115223357399375",
			["columns4"] = "rbxassetid://130807991968419",
			["combine"] = "rbxassetid://79908476334048",
			["computer"] = "rbxassetid://77480056459407",
			["cone"] = "rbxassetid://97759550688437",
			["construction"] = "rbxassetid://106539489968173",
			["contactround"] = "rbxassetid://71907624112229",
			["container"] = "rbxassetid://91507237573499",
			["cookingpot"] = "rbxassetid://94959783129799",
			["copycheck"] = "rbxassetid://91177247988892",
			["copyminus"] = "rbxassetid://109524509933035",
			["copyplus"] = "rbxassetid://113618379616952",
			["copyslash"] = "rbxassetid://93805787810390",
			["copyx"] = "rbxassetid://106557557978061",
			["creativecommons"] = "rbxassetid://90408210735312",
			["creditcard"] = "rbxassetid://99163352872346",
			["cuboid"] = "rbxassetid://75618807946111",
			["cylinder"] = "rbxassetid://90569677179169",
			["dam"] = "rbxassetid://76874486231393",
			["databasebackup"] = "rbxassetid://103403210984699",
			["databasezap"] = "rbxassetid://131199921258418",
			["decimalsarrowleft"] = "rbxassetid://120198500638749",
			["decimalsarrowright"] = "rbxassetid://118263047146797",
			["dessert"] = "rbxassetid://71508133278830",
			["diameter"] = "rbxassetid://97429051503783",
			["diamondminus"] = "rbxassetid://128989071438290",
			["diamondpercent"] = "rbxassetid://107717860105959",
			["diamondplus"] = "rbxassetid://134701163723675",
			["disc2"] = "rbxassetid://91419420404185",
			["disc3"] = "rbxassetid://135470554736048",
			["discalbum"] = "rbxassetid://74693460404344",
			["dnaoff"] = "rbxassetid://89612426361540",
			["dna"] = "rbxassetid://74007982981741",
			["dock"] = "rbxassetid://121997427160252",
			["dog"] = "rbxassetid://71920105558570",
			["donut"] = "rbxassetid://72204922742657",
			["doorclosedlocked"] = "rbxassetid://74027613267551",
			["doorclosed"] = "rbxassetid://136249099949073",
			["dooropen"] = "rbxassetid://91306356501736",
			["dot"] = "rbxassetid://137321056643916",
			["draftingcompass"] = "rbxassetid://99701976182841",
			["drama"] = "rbxassetid://110297795801577",
			["dribbble"] = "rbxassetid://80231809663849",
			["drill"] = "rbxassetid://108644821412796",
			["drone"] = "rbxassetid://117299095794783",
			["dropletoff"] = "rbxassetid://119365002225172",
			["drum"] = "rbxassetid://136979060344890",
			["dumbbell"] = "rbxassetid://80277236776212",
			["earoff"] = "rbxassetid://87421916192807",
			["ear"] = "rbxassetid://121894949934209",
			["earthlock"] = "rbxassetid://88814147073745",
			["earth"] = "rbxassetid://76231597751076",
			["eclipse"] = "rbxassetid://114829622118222",
			["eggoff"] = "rbxassetid://92288321309285",
			["ellipsisvertical"] = "rbxassetid://117978708573781",
			["ellipsis"] = "rbxassetid://140019550645825",
			["equalapproximately"] = "rbxassetid://105382689698323",
			["ethernetport"] = "rbxassetid://75391715149314",
			["evcharger"] = "rbxassetid://97906158859623",
			["eyeclosed"] = "rbxassetid://111063268625789",
			["facebook"] = "rbxassetid://72098528632192",
			["fence"] = "rbxassetid://123451565578029",
			["ferriswheel"] = "rbxassetid://79729205796176",
			["filebracescorner"] = "rbxassetid://77253337986109",
			["filebraces"] = "rbxassetid://95314128621234",
			["filechartcolumnincreasing"] = "rbxassetid://134449481172067",
			["filechartcolumn"] = "rbxassetid://82048481252560",
			["filechartline"] = "rbxassetid://71954360551345",
			["filechartpie"] = "rbxassetid://81072193564497",
			["filecheckcorner"] = "rbxassetid://76295552859171",
			["filecodecorner"] = "rbxassetid://78293841184371",
			["fileexclamationpoint"] = "rbxassetid://102821865889635",
			["fileheadphone"] = "rbxassetid://100533735901986",
			["fileminuscorner"] = "rbxassetid://119263271735124",
			["filemusic"] = "rbxassetid://134948051536671",
			["filepenline"] = "rbxassetid://104622936345006",
			["filepen"] = "rbxassetid://79556179730240",
			["fileplay"] = "rbxassetid://89006821567838",
			["filepluscorner"] = "rbxassetid://76544604043974",
			["filequestionmark"] = "rbxassetid://127617422859576",
			["filesearchcorner"] = "rbxassetid://90974165234008",
			["filesignal"] = "rbxassetid://122070252538165",
			["filesliders"] = "rbxassetid://85787771732439",
			["filestack"] = "rbxassetid://138929929862605",
			["filetypecorner"] = "rbxassetid://124902230275209",
			["fileuser"] = "rbxassetid://99552018455009",
			["filevideocamera"] = "rbxassetid://81719056173960",
			["filexcorner"] = "rbxassetid://87554136773609",
			["fireextinguisher"] = "rbxassetid://111643493006960",
			["fishoff"] = "rbxassetid://89756724887508",
			["fishsymbol"] = "rbxassetid://118475177681618",
			["fish"] = "rbxassetid://124360663785796",
			["flamekindling"] = "rbxassetid://139728976917928",
			["flaskconicaloff"] = "rbxassetid://112597970025298",
			["foldhorizontal"] = "rbxassetid://92835712442240",
			["foldvertical"] = "rbxassetid://108873727253656",
			["foldercode"] = "rbxassetid://70624096349370",
			["folderdot"] = "rbxassetid://138687772725278",
			["foldergit2"] = "rbxassetid://101394054141166",
			["foldergit"] = "rbxassetid://121885778095158",
			["folderkanban"] = "rbxassetid://78313285104072",
			["folderopendot"] = "rbxassetid://74741494767354",
			["folderpen"] = "rbxassetid://112770491173911",
			["folderroot"] = "rbxassetid://103333751154693",
			["foldersync"] = "rbxassetid://91544602659796",
			["footprints"] = "rbxassetid://139192589041315",
			["forklift"] = "rbxassetid://72030930983101",
			["fullscreen"] = "rbxassetid://77793665526178",
			["funnelplus"] = "rbxassetid://100780233821928",
			["funnelx"] = "rbxassetid://70984385812555",
			["funnel"] = "rbxassetid://108829540827529",
			["galleryhorizontalend"] = "rbxassetid://74672430161161",
			["galleryhorizontal"] = "rbxassetid://80004001442122",
			["gallerythumbnails"] = "rbxassetid://136219289862706",
			["galleryverticalend"] = "rbxassetid://106461402088317",
			["galleryvertical"] = "rbxassetid://119299431466725",
			["gamepaddirectional"] = "rbxassetid://84342305212226",
			["georgianlari"] = "rbxassetid://98084432591687",
			["gitbranchminus"] = "rbxassetid://97385010649411",
			["gitcommithorizontal"] = "rbxassetid://133646041800147",
			["gitcommitvertical"] = "rbxassetid://122098032990350",
			["gitcomparearrows"] = "rbxassetid://84874426520216",
			["gitgraph"] = "rbxassetid://86166832019304",
			["gitpullrequestarrow"] = "rbxassetid://94507974577439",
			["gitpullrequestcreatearrow"] = "rbxassetid://127422677061091",
			["gitpullrequestcreate"] = "rbxassetid://105929577383926",
			["github"] = "rbxassetid://120349554354380",
			["gitlab"] = "rbxassetid://114054627192933",
			["globelock"] = "rbxassetid://134065526704402",
			["goal"] = "rbxassetid://120517954878160",
			["gpu"] = "rbxassetid://95577823614219",
			["grid2x2check"] = "rbxassetid://138468840220821",
			["grid2x2plus"] = "rbxassetid://91811610580247",
			["grid2x2x"] = "rbxassetid://72407303981388",
			["grid2x2"] = "rbxassetid://99050491897640",
			["grid3x2"] = "rbxassetid://95528684210010",
			["grid3x3"] = "rbxassetid://70419024781206",
			["grip"] = "rbxassetid://109058783556768",
			["group"] = "rbxassetid://107643418926671",
			["guitar"] = "rbxassetid://75915531867926",
			["ham"] = "rbxassetid://74465607934635",
			["hamburger"] = "rbxassetid://93086916815495",
			["handcoins"] = "rbxassetid://126990543175462",
			["handfist"] = "rbxassetid://83341608917591",
			["handgrab"] = "rbxassetid://88867162163985",
			["handheart"] = "rbxassetid://117507367668412",
			["handhelping"] = "rbxassetid://89897738419446",
			["handplatter"] = "rbxassetid://88594727743168",
			["handbag"] = "rbxassetid://135675846264061",
			["handshake"] = "rbxassetid://78442115255814",
			["harddrivedownload"] = "rbxassetid://73913801230614",
			["harddriveupload"] = "rbxassetid://85762133615118",
			["hatglasses"] = "rbxassetid://101165538224815",
			["hdmiport"] = "rbxassetid://103693661037020",
			["heading1"] = "rbxassetid://118129315662110",
			["heading2"] = "rbxassetid://110209069670094",
			["heading3"] = "rbxassetid://90267885237062",
			["heading4"] = "rbxassetid://129625620307602",
			["heading5"] = "rbxassetid://120386663181267",
			["heading6"] = "rbxassetid://90959079775093",
			["heading"] = "rbxassetid://129254312067735",
			["headphoneoff"] = "rbxassetid://85038251615641",
			["headset"] = "rbxassetid://129269236787694",
			["heartminus"] = "rbxassetid://96827380163326",
			["heartplus"] = "rbxassetid://94877796283249",
			["heater"] = "rbxassetid://140478466880916",
			["helicopter"] = "rbxassetid://111557171735930",
			["hopoff"] = "rbxassetid://103386036934034",
			["hop"] = "rbxassetid://82778923997672",
			["hospital"] = "rbxassetid://105868763850707",
			["hotel"] = "rbxassetid://132283390859718",
			["househeart"] = "rbxassetid://136054771868597",
			["houseplug"] = "rbxassetid://71438263712075",
			["houseplus"] = "rbxassetid://118495165208309",
			["housewifi"] = "rbxassetid://126495519725698",
			["house"] = "rbxassetid://98755624629571",
			["icecreambowl"] = "rbxassetid://124867218454386",
			["icecreamcone"] = "rbxassetid://90751397288639",
			["idcardlanyard"] = "rbxassetid://90761480469224",
			["idcard"] = "rbxassetid://75354294622640",
			["imagedown"] = "rbxassetid://78972295741235",
			["imageplay"] = "rbxassetid://129501806784210",
			["imageup"] = "rbxassetid://126610009605241",
			["imageupscale"] = "rbxassetid://106963545024679",
			["images"] = "rbxassetid://79350649395557",
			["inspectionpanel"] = "rbxassetid://70905313146088",
			["instagram"] = "rbxassetid://119864798614855",
			["iterationccw"] = "rbxassetid://140221832794083",
			["iterationcw"] = "rbxassetid://95534489554662",
			["kanban"] = "rbxassetid://125934100055431",
			["kayak"] = "rbxassetid://136107544609389",
			["keyround"] = "rbxassetid://83619031955390",
			["keysquare"] = "rbxassetid://94621420033649",
			["keyboardmusic"] = "rbxassetid://121058541758636",
			["keyboardoff"] = "rbxassetid://92466375369772",
			["landplot"] = "rbxassetid://96449039620294",
			["laptopminimalcheck"] = "rbxassetid://114352019833865",
			["laptopminimal"] = "rbxassetid://136705765566068",
			["layers2"] = "rbxassetid://70536710516357",
			["layoutpanelleft"] = "rbxassetid://125092469751491",
			["layoutpaneltop"] = "rbxassetid://91943941515944",
			["leafygreen"] = "rbxassetid://105146290493154",
			["lectern"] = "rbxassetid://106166425183862",
			["librarybig"] = "rbxassetid://106794530191412",
			["ligature"] = "rbxassetid://111397873269411",
			["linesquiggle"] = "rbxassetid://109555164424447",
			["linkedin"] = "rbxassetid://132842789255788",
			["listcheck"] = "rbxassetid://72374358471156",
			["listchevronsdownup"] = "rbxassetid://137409641500711",
			["listchevronsupdown"] = "rbxassetid://81825351389084",
			["listcollapse"] = "rbxassetid://124505247702401",
			["listfilterplus"] = "rbxassetid://96385120752336",
			["listfilter"] = "rbxassetid://103321376129527",
			["listindentdecrease"] = "rbxassetid://137879979228193",
			["listindentincrease"] = "rbxassetid://79051053161201",
			["listrestart"] = "rbxassetid://91703153577421",
			["listtodo"] = "rbxassetid://132980603752108",
			["listtree"] = "rbxassetid://97685396239010",
			["loadercircle"] = "rbxassetid://116535712789945",
			["loaderpinwheel"] = "rbxassetid://108513357940900",
			["lockkeyholeopen"] = "rbxassetid://110863509313073",
			["lockkeyhole"] = "rbxassetid://78672912777756",
			["lockopen"] = "rbxassetid://93597915325122",
			["logs"] = "rbxassetid://89772091251787",
			["lollipop"] = "rbxassetid://84681611583044",
			["mailquestionmark"] = "rbxassetid://126540170949819",
			["mailbox"] = "rbxassetid://82765503320335",
			["mapminus"] = "rbxassetid://129525760577747",
			["mappincheckinside"] = "rbxassetid://107130529843809",
			["mappincheck"] = "rbxassetid://118110914690154",
			["mappinhouse"] = "rbxassetid://80546885029816",
			["mappinminusinside"] = "rbxassetid://79005529692964",
			["mappinminus"] = "rbxassetid://74518762643623",
			["mappinpen"] = "rbxassetid://113515395277504",
			["mappinplusinside"] = "rbxassetid://134639656514430",
			["mappinplus"] = "rbxassetid://91875228967029",
			["mappinxinside"] = "rbxassetid://126235934252379",
			["mappinx"] = "rbxassetid://101085273547316",
			["mappinned"] = "rbxassetid://103963788475034",
			["mapplus"] = "rbxassetid://129388826743495",
			["marsstroke"] = "rbxassetid://131973193186828",
			["mars"] = "rbxassetid://111287112372511",
			["martini"] = "rbxassetid://82977695401058",
			["memorystick"] = "rbxassetid://93212591343119",
			["merge"] = "rbxassetid://126201866476775",
			["messagecirclecode"] = "rbxassetid://112865244991651",
			["messagecircledashed"] = "rbxassetid://81525157881897",
			["messagecircleheart"] = "rbxassetid://101990756073677",
			["messagecirclemore"] = "rbxassetid://92856823884663",
			["messagecircleoff"] = "rbxassetid://134955643890328",
			["messagecircleplus"] = "rbxassetid://106562979649273",
			["messagecirclequestionmark"] = "rbxassetid://107700302759934",
			["messagecirclereply"] = "rbxassetid://137071749508334",
			["messagecirclewarning"] = "rbxassetid://119020096067894",
			["messagecirclex"] = "rbxassetid://126843387725536",
			["messagesquarecode"] = "rbxassetid://110968863152123",
			["messagesquaredashed"] = "rbxassetid://107653455516238",
			["messagesquarediff"] = "rbxassetid://75472190472625",
			["messagesquaredot"] = "rbxassetid://127806382463916",
			["messagesquareheart"] = "rbxassetid://75612811742074",
			["messagesquarelock"] = "rbxassetid://81268215619563",
			["messagesquaremore"] = "rbxassetid://120139782405970",
			["messagesquareoff"] = "rbxassetid://99961019005789",
			["messagesquareplus"] = "rbxassetid://76934450256199",
			["messagesquarequote"] = "rbxassetid://116670768629340",
			["messagesquarereply"] = "rbxassetid://130985622754637",
			["messagesquareshare"] = "rbxassetid://131017005324026",
			["messagesquaretext"] = "rbxassetid://94899503194205",
			["messagesquarewarning"] = "rbxassetid://138432903962261",
			["messagesquarex"] = "rbxassetid://137285463279462",
			["messagessquare"] = "rbxassetid://97532166733358",
			["micvocal"] = "rbxassetid://99082286164362",
			["microchip"] = "rbxassetid://73937907669903",
			["milkoff"] = "rbxassetid://72388480962742",
			["milk"] = "rbxassetid://96221903896918",
			["monitorcheck"] = "rbxassetid://86651948439229",
			["monitorcloud"] = "rbxassetid://85931096038318",
			["monitorcog"] = "rbxassetid://94345128715799",
			["monitordot"] = "rbxassetid://130394010063680",
			["monitordown"] = "rbxassetid://97466933743423",
			["monitorpause"] = "rbxassetid://76002184067562",
			["monitorplay"] = "rbxassetid://133018824306217",
			["monitorsmartphone"] = "rbxassetid://84335680433378",
			["monitorstop"] = "rbxassetid://98708958984757",
			["monitorup"] = "rbxassetid://96035360858377",
			["monitorx"] = "rbxassetid://126265210441423",
			["moonstar"] = "rbxassetid://82782200506348",
			["motorbike"] = "rbxassetid://94580787368233",
			["mouseoff"] = "rbxassetid://75267871697595",
			["mousepointer2off"] = "rbxassetid://104701076865632",
			["mousepointerban"] = "rbxassetid://106849413057133",
			["movedownleft"] = "rbxassetid://102819433534567",
			["movedownright"] = "rbxassetid://101479760041877",
			["movedown"] = "rbxassetid://70510115135583",
			["moveleft"] = "rbxassetid://137614740247980",
			["moveright"] = "rbxassetid://132455779472989",
			["moveupleft"] = "rbxassetid://139079815540148",
			["moveupright"] = "rbxassetid://105885140592646",
			["moveup"] = "rbxassetid://84505444262658",
			["nfc"] = "rbxassetid://76822396542242",
			["nonbinary"] = "rbxassetid://78442360386235",
			["notebookpen"] = "rbxassetid://140380614761023",
			["notebooktabs"] = "rbxassetid://127371085570083",
			["notebooktext"] = "rbxassetid://93061585217270",
			["notebook"] = "rbxassetid://136132108664987",
			["notepadtextdashed"] = "rbxassetid://135793446376219",
			["notepadtext"] = "rbxassetid://93404682958966",
			["nutoff"] = "rbxassetid://78795397311573",
			["nut"] = "rbxassetid://127146410705656",
			["octagonalert"] = "rbxassetid://140438367956051",
			["octagonminus"] = "rbxassetid://74720436795421",
			["octagonpause"] = "rbxassetid://103161463909039",
			["octagonx"] = "rbxassetid://90498161006311",
			["omega"] = "rbxassetid://70414080018786",
			["orbit"] = "rbxassetid://108926136860562",
			["origami"] = "rbxassetid://136020626667101",
			["paintroller"] = "rbxassetid://115248074358348",
			["paintbrushvertical"] = "rbxassetid://105151296591292",
			["panda"] = "rbxassetid://132509022802512",
			["panelbottomclose"] = "rbxassetid://74287004071159",
			["panelbottomdashed"] = "rbxassetid://131084651621603",
			["panelbottomopen"] = "rbxassetid://107768659586540",
			["panelbottom"] = "rbxassetid://132127145048511",
			["panelleftclose"] = "rbxassetid://126579818823552",
			["panelleftdashed"] = "rbxassetid://75536606374585",
			["panelleftopen"] = "rbxassetid://111075816195767",
			["panelleftrightdashed"] = "rbxassetid://110100707973959",
			["panelleft"] = "rbxassetid://97419752870313",
			["panelrightclose"] = "rbxassetid://139528655524132",
			["panelrightdashed"] = "rbxassetid://94959793877311",
			["panelrightopen"] = "rbxassetid://118114419142794",
			["panelright"] = "rbxassetid://116365035443156",
			["paneltopbottomdashed"] = "rbxassetid://134737235653344",
			["paneltopclose"] = "rbxassetid://83578325777808",
			["paneltopdashed"] = "rbxassetid://70522913169237",
			["paneltopopen"] = "rbxassetid://137959875507454",
			["paneltop"] = "rbxassetid://75838479462875",
			["panelsleftbottom"] = "rbxassetid://72996856149149",
			["panelsrightbottom"] = "rbxassetid://90659068960726",
			["panelstopleft"] = "rbxassetid://79858853850600",
			["parentheses"] = "rbxassetid://78950955173096",
			["parkingmeter"] = "rbxassetid://84652733960568",
			["pawprint"] = "rbxassetid://112218825427601",
			["pccase"] = "rbxassetid://122978648019101",
			["penline"] = "rbxassetid://109108135755303",
			["penoff"] = "rbxassetid://84807123119438",
			["pen"] = "rbxassetid://72037878096321",
			["pencilline"] = "rbxassetid://88392917053533",
			["penciloff"] = "rbxassetid://103330927652832",
			["pencilruler"] = "rbxassetid://110120288284597",
			["pentagon"] = "rbxassetid://79184802179890",
			["philippinepeso"] = "rbxassetid://91173798254675",
			["pi"] = "rbxassetid://74936036243146",
			["piano"] = "rbxassetid://85008880789520",
			["pickaxe"] = "rbxassetid://105888023317688",
			["pictureinpicture2"] = "rbxassetid://112803319544468",
			["pictureinpicture"] = "rbxassetid://80579597835123",
			["pilcrowleft"] = "rbxassetid://103803000849583",
			["pilcrowright"] = "rbxassetid://104881733911870",
			["pilcrow"] = "rbxassetid://139512780392871",
			["pillbottle"] = "rbxassetid://118394692404597",
			["pill"] = "rbxassetid://73280534813448",
			["planelanding"] = "rbxassetid://122555692211889",
			["planetakeoff"] = "rbxassetid://117179478829575",
			["plug2"] = "rbxassetid://97912386476366",
			["plugzap"] = "rbxassetid://74506269884055",
			["plug"] = "rbxassetid://99782373064495",
			["pocketknife"] = "rbxassetid://134075428063965",
			["pocket"] = "rbxassetid://136686762542964",
			["pointeroff"] = "rbxassetid://95488389312794",
			["popcorn"] = "rbxassetid://139446511232750",
			["popsicle"] = "rbxassetid://112696318077073",
			["presentation"] = "rbxassetid://106134583757890",
			["printercheck"] = "rbxassetid://130273549443689",
			["projector"] = "rbxassetid://103281856385283",
			["proportions"] = "rbxassetid://130046855997237",
			["pyramid"] = "rbxassetid://107811442374127",
			["qrcode"] = "rbxassetid://105329945723350",
			["rabbit"] = "rbxassetid://98580518804206",
			["radar"] = "rbxassetid://138528222906635",
			["radiation"] = "rbxassetid://104499586848433",
			["radical"] = "rbxassetid://132758286926047",
			["radiotower"] = "rbxassetid://93958663130054",
			["radius"] = "rbxassetid://89814505307129",
			["railsymbol"] = "rbxassetid://134295386306962",
			["rainbow"] = "rbxassetid://132488862841895",
			["rat"] = "rbxassetid://127400975953159",
			["ratio"] = "rbxassetid://126369423897295",
			["receiptcent"] = "rbxassetid://91557573925201",
			["receipteuro"] = "rbxassetid://94015722210295",
			["receiptindianrupee"] = "rbxassetid://89718170439990",
			["receiptjapaneseyen"] = "rbxassetid://132472560758851",
			["receiptpoundsterling"] = "rbxassetid://73934967569625",
			["receiptrussianruble"] = "rbxassetid://105164576936853",
			["receiptswissfranc"] = "rbxassetid://72503668620116",
			["receipttext"] = "rbxassetid://138483536013737",
			["receiptturkishlira"] = "rbxassetid://91950765836342",
			["receipt"] = "rbxassetid://77877895901792",
			["rectanglecircle"] = "rbxassetid://100642423153903",
			["rectangleellipsis"] = "rbxassetid://112919953980965",
			["rectanglegoggles"] = "rbxassetid://98605436666727",
			["redodot"] = "rbxassetid://94252981719732",
			["refreshccwdot"] = "rbxassetid://106702246753270",
			["refreshcwoff"] = "rbxassetid://140179498843054",
			["removeformatting"] = "rbxassetid://112833162022628",
			["repeat2"] = "rbxassetid://85927537182704",
			["replaceall"] = "rbxassetid://127862728198635",
			["replace"] = "rbxassetid://128404082279430",
			["ribbon"] = "rbxassetid://94265331526851",
			["rollercoaster"] = "rbxassetid://112426178972099",
			["rose"] = "rbxassetid://126336840238769",
			["rotateccwkey"] = "rbxassetid://74976035240976",
			["rotateccwsquare"] = "rbxassetid://90515853170424",
			["rotatecwsquare"] = "rbxassetid://77095448159303",
			["routeoff"] = "rbxassetid://106350402024079",
			["route"] = "rbxassetid://89968303228953",
			["router"] = "rbxassetid://102130331994471",
			["rows2"] = "rbxassetid://112556185960101",
			["rows3"] = "rbxassetid://117215586961375",
			["rows4"] = "rbxassetid://125646021959055",
			["rulerdimensionline"] = "rbxassetid://70673861371412",
			["salad"] = "rbxassetid://128864507821603",
			["sandwich"] = "rbxassetid://104573187458917",
			["satellitedish"] = "rbxassetid://136742443888305",
			["satellite"] = "rbxassetid://134967053164645",
			["saudiriyal"] = "rbxassetid://102282769104635",
			["saveall"] = "rbxassetid://116946975799440",
			["saveoff"] = "rbxassetid://87085435778560",
			["scanbarcode"] = "rbxassetid://96889457154761",
			["scaneye"] = "rbxassetid://99244790601968",
			["scanheart"] = "rbxassetid://106280819776142",
			["scanqrcode"] = "rbxassetid://105409149549927",
			["scansearch"] = "rbxassetid://80009010551347",
			["scantext"] = "rbxassetid://73702396787766",
			["school"] = "rbxassetid://76351530290068",
			["scissorslinedashed"] = "rbxassetid://122237447974173",
			["scrolltext"] = "rbxassetid://97321022666868",
			["searchcheck"] = "rbxassetid://75442076191356",
			["searchcode"] = "rbxassetid://117114794592802",
			["searchslash"] = "rbxassetid://96483932261041",
			["searchx"] = "rbxassetid://137319957522951",
			["section"] = "rbxassetid://91732188298948",
			["sendhorizontal"] = "rbxassetid://111734392411664",
			["sendtoback"] = "rbxassetid://75340312862253",
			["shapes"] = "rbxassetid://129989433311409",
			["shell"] = "rbxassetid://140212943563599",
			["shieldban"] = "rbxassetid://108765041044649",
			["shieldellipsis"] = "rbxassetid://114794739892123",
			["shieldhalf"] = "rbxassetid://117842634172647",
			["shieldminus"] = "rbxassetid://89965059528921",
			["shieldplus"] = "rbxassetid://100664857995498",
			["shieldquestionmark"] = "rbxassetid://135722075265150",
			["shielduser"] = "rbxassetid://124832775645347",
			["shieldx"] = "rbxassetid://73370117343811",
			["shipwheel"] = "rbxassetid://130797795829448",
			["ship"] = "rbxassetid://83995100553930",
			["shoppingbasket"] = "rbxassetid://138646411956433",
			["shredder"] = "rbxassetid://122125164414463",
			["shrimp"] = "rbxassetid://102625900815307",
			["signature"] = "rbxassetid://114402748013000",
			["signpostbig"] = "rbxassetid://115780185675001",
			["signpost"] = "rbxassetid://106584743791433",
			["slidersvertical"] = "rbxassetid://101190569086853",
			["smartphonenfc"] = "rbxassetid://82326425754446",
			["snail"] = "rbxassetid://70904536548363",
			["soapdispenserdroplet"] = "rbxassetid://77258480479465",
			["solarpanel"] = "rbxassetid://132448188047921",
			["soup"] = "rbxassetid://115092551871618",
			["space"] = "rbxassetid://87072088914178",
			["spade"] = "rbxassetid://131444449466462",
			["sparkle"] = "rbxassetid://111044800239623",
			["sparkles"] = "rbxassetid://138635884129147",
			["speech"] = "rbxassetid://87013139446349",
			["spellcheck2"] = "rbxassetid://81556731785534",
			["spellcheck"] = "rbxassetid://91913483031334",
			["splinepointer"] = "rbxassetid://84842840956804",
			["spline"] = "rbxassetid://129406685807412",
			["split"] = "rbxassetid://105112438805988",
			["spool"] = "rbxassetid://124541981347743",
			["spotlight"] = "rbxassetid://77571742539344",
			["spraycan"] = "rbxassetid://128372039366326",
			["squareactivity"] = "rbxassetid://89496630185293",
			["squarearrowdownleft"] = "rbxassetid://108194680296901",
			["squarearrowdownright"] = "rbxassetid://99403846801050",
			["squarearrowdown"] = "rbxassetid://135962519626588",
			["squarearrowleft"] = "rbxassetid://111671474549238",
			["squarearrowoutdownleft"] = "rbxassetid://125714881756353",
			["squarearrowoutdownright"] = "rbxassetid://89971003001390",
			["squarearrowoutupleft"] = "rbxassetid://103759986579087",
			["squarearrowoutupright"] = "rbxassetid://91221896066807",
			["squarearrowright"] = "rbxassetid://113920471701361",
			["squarearrowupleft"] = "rbxassetid://112424670290693",
			["squarearrowupright"] = "rbxassetid://76602291406940",
			["squarearrowup"] = "rbxassetid://106998604646718",
			["squareasterisk"] = "rbxassetid://89186832353625",
			["squarebottomdashedscissors"] = "rbxassetid://79076980104803",
			["squarechartgantt"] = "rbxassetid://104034017316411",
			["squarecheckbig"] = "rbxassetid://115320390907184",
			["squarecheck"] = "rbxassetid://134682053539509",
			["squarechevrondown"] = "rbxassetid://91032307924592",
			["squarechevronleft"] = "rbxassetid://73143404829510",
			["squarechevronright"] = "rbxassetid://90612077729930",
			["squarechevronup"] = "rbxassetid://85565910197337",
			["squarecode"] = "rbxassetid://81604576616881",
			["squaredashedbottomcode"] = "rbxassetid://100354801563230",
			["squaredashedbottom"] = "rbxassetid://101102319625624",
			["squaredashedkanban"] = "rbxassetid://90388067649847",
			["squaredashedmousepointer"] = "rbxassetid://121016142178467",
			["squaredashedtopsolid"] = "rbxassetid://117157577548540",
			["squaredashed"] = "rbxassetid://136905537847606",
			["squaredivide"] = "rbxassetid://99894657101970",
			["squaredot"] = "rbxassetid://116613421354866",
			["squareequal"] = "rbxassetid://110283363706707",
			["squarefunction"] = "rbxassetid://86075219551088",
			["squarekanban"] = "rbxassetid://114537101260131",
			["squarelibrary"] = "rbxassetid://73810931222081",
			["squarem"] = "rbxassetid://117662700410577",
			["squaremenu"] = "rbxassetid://104067089444415",
			["squareminus"] = "rbxassetid://116764432015770",
			["squaremousepointer"] = "rbxassetid://76141850603920",
			["squareparkingoff"] = "rbxassetid://100857293535141",
			["squareparking"] = "rbxassetid://133116656122387",
			["squarepause"] = "rbxassetid://86608552787615",
			["squarepen"] = "rbxassetid://120239476110475",
			["squarepercent"] = "rbxassetid://87111930314567",
			["squarepi"] = "rbxassetid://75383328781618",
			["squarepilcrow"] = "rbxassetid://131854284699367",
			["squareplay"] = "rbxassetid://108186325238481",
			["squareplus"] = "rbxassetid://114713264461873",
			["squarepower"] = "rbxassetid://129240437805187",
			["squareradical"] = "rbxassetid://132645931868292",
			["squareroundcorner"] = "rbxassetid://104592745113567",
			["squarescissors"] = "rbxassetid://110601255612411",
			["squaresigma"] = "rbxassetid://113231244246816",
			["squareslash"] = "rbxassetid://105477013908757",
			["squaresplithorizontal"] = "rbxassetid://76095370148660",
			["squaresplitvertical"] = "rbxassetid://88589192032058",
			["squaresquare"] = "rbxassetid://136555087357875",
			["squarestack"] = "rbxassetid://100463396619394",
			["squarestar"] = "rbxassetid://94506958703720",
			["squarestop"] = "rbxassetid://80018708472943",
			["squareterminal"] = "rbxassetid://83969264476798",
			["squareuserround"] = "rbxassetid://86484997229302",
			["squareuser"] = "rbxassetid://70771214183445",
			["squarex"] = "rbxassetid://125136183850190",
			["squaresexclude"] = "rbxassetid://102345385822324",
			["squaresintersect"] = "rbxassetid://120869602570119",
			["squaressubtract"] = "rbxassetid://131484650948795",
			["squaresunite"] = "rbxassetid://96673080107843",
			["squircledashed"] = "rbxassetid://129936702532522",
			["squircle"] = "rbxassetid://82426632573807",
			["squirrel"] = "rbxassetid://112864252085343",
			["stamp"] = "rbxassetid://92370779813368",
			["stepback"] = "rbxassetid://108672750005121",
			["stepforward"] = "rbxassetid://126131872136145",
			["store"] = "rbxassetid://90338129673705",
			["swatchbook"] = "rbxassetid://126786244872453",
			["tablecellsmerge"] = "rbxassetid://95363715175258",
			["tablecellssplit"] = "rbxassetid://114799086088649",
			["tablecolumnssplit"] = "rbxassetid://111011625447949",
			["tableofcontents"] = "rbxassetid://135044763275414",
			["tableproperties"] = "rbxassetid://125062886015372",
			["tablerowssplit"] = "rbxassetid://96443733673997",
			["tabletsmartphone"] = "rbxassetid://133680859813404",
			["tablets"] = "rbxassetid://80835787970735",
			["tally1"] = "rbxassetid://115301298241643",
			["tally2"] = "rbxassetid://110363186864027",
			["tally3"] = "rbxassetid://97655344572540",
			["tally4"] = "rbxassetid://102633494371890",
			["tally5"] = "rbxassetid://88031817475886",
			["tangent"] = "rbxassetid://123263132981724",
			["telescope"] = "rbxassetid://91755049143647",
			["tenttree"] = "rbxassetid://76698322463977",
			["testtubediagonal"] = "rbxassetid://75662704378840",
			["testtube"] = "rbxassetid://98801015650164",
			["testtubes"] = "rbxassetid://92555361447433",
			["textaligncenter"] = "rbxassetid://84051028246390",
			["textalignend"] = "rbxassetid://130041738343555",
			["textalignjustify"] = "rbxassetid://80279880143030",
			["textalignstart"] = "rbxassetid://134489585487649",
			["textinitial"] = "rbxassetid://129458097472087",
			["textquote"] = "rbxassetid://139278366448736",
			["textsearch"] = "rbxassetid://92345384671606",
			["textselect"] = "rbxassetid://117087320884956",
			["textwrap"] = "rbxassetid://114804318314018",
			["theater"] = "rbxassetid://108558145549163",
			["ticketcheck"] = "rbxassetid://105428777212507",
			["ticketminus"] = "rbxassetid://78966299769328",
			["ticketpercent"] = "rbxassetid://80834774406405",
			["ticketplus"] = "rbxassetid://110086734392189",
			["ticketslash"] = "rbxassetid://89045681172265",
			["ticketx"] = "rbxassetid://88674114109926",
			["ticketsplane"] = "rbxassetid://100367018248695",
			["tickets"] = "rbxassetid://135268612687833",
			["toilet"] = "rbxassetid://80930782432931",
			["toolcase"] = "rbxassetid://87533537832522",
			["torus"] = "rbxassetid://70855707283051",
			["touchpadoff"] = "rbxassetid://78784008075456",
			["touchpad"] = "rbxassetid://74882354908014",
			["towercontrol"] = "rbxassetid://95937619060532",
			["tractor"] = "rbxassetid://103376704722051",
			["trafficcone"] = "rbxassetid://74110220470369",
			["trainfronttunnel"] = "rbxassetid://105194827005114",
			["trainfront"] = "rbxassetid://125237934215370",
			["traintrack"] = "rbxassetid://77451032453723",
			["tramfront"] = "rbxassetid://93315182364998",
			["transgender"] = "rbxassetid://135530817673639",
			["treepalm"] = "rbxassetid://103846705893963",
			["trello"] = "rbxassetid://130987241149527",
			["trendingupdown"] = "rbxassetid://85083293981691",
			["trianglealert"] = "rbxassetid://125920361880643",
			["triangledashed"] = "rbxassetid://124324079103935",
			["triangleright"] = "rbxassetid://116930791412791",
			["truckelectric"] = "rbxassetid://111873446387359",
			["turkishlira"] = "rbxassetid://114589876174070",
			["turntable"] = "rbxassetid://129870346487856",
			["turtle"] = "rbxassetid://118295081560334",
			["tvminimalplay"] = "rbxassetid://99201833426972",
			["tvminimal"] = "rbxassetid://100382201729427",
			["twitch"] = "rbxassetid://71383308134888",
			["twitter"] = "rbxassetid://88791703276842",
			["typeoutline"] = "rbxassetid://80108627791690",
			["umbrellaoff"] = "rbxassetid://72395143739955",
			["undodot"] = "rbxassetid://132055277744844",
			["unfoldhorizontal"] = "rbxassetid://117128358526398",
			["unfoldvertical"] = "rbxassetid://116593025265499",
			["ungroup"] = "rbxassetid://106674800451003",
			["university"] = "rbxassetid://84652528263642",
			["unplug"] = "rbxassetid://90171381619874",
			["userlock"] = "rbxassetid://78892639693821",
			["userpen"] = "rbxassetid://87445472574836",
			["userroundcheck"] = "rbxassetid://118794737621941",
			["userroundcog"] = "rbxassetid://78239503290053",
			["userroundminus"] = "rbxassetid://98944176636447",
			["userroundpen"] = "rbxassetid://108155244324878",
			["userroundplus"] = "rbxassetid://113301899567470",
			["userroundsearch"] = "rbxassetid://71565774381870",
			["userroundx"] = "rbxassetid://122367980560930",
			["userround"] = "rbxassetid://136485052187963",
			["usersearch"] = "rbxassetid://101335649828115",
			["userstar"] = "rbxassetid://98777846316000",
			["usersround"] = "rbxassetid://103005444008339",
			["utilitypole"] = "rbxassetid://101965541238242",
			["variable"] = "rbxassetid://104743088438151",
			["vault"] = "rbxassetid://108049164599845",
			["vectorsquare"] = "rbxassetid://86713728565344",
			["vegan"] = "rbxassetid://119489190688082",
			["venusandmars"] = "rbxassetid://120227752103771",
			["venus"] = "rbxassetid://82891342220859",
			["videotape"] = "rbxassetid://114816894323398",
			["volleyball"] = "rbxassetid://83889351124153",
			["volumeoff"] = "rbxassetid://103047478058767",
			["vote"] = "rbxassetid://89409762851246",
			["walletcards"] = "rbxassetid://129728715308337",
			["walletminimal"] = "rbxassetid://137800448816116",
			["wallpaper"] = "rbxassetid://74682121235494",
			["wandsparkles"] = "rbxassetid://82546429942392",
			["warehouse"] = "rbxassetid://78388887451080",
			["washingmachine"] = "rbxassetid://104194127573858",
			["wavesladder"] = "rbxassetid://101808619355514",
			["waypoints"] = "rbxassetid://102450133666017",
			["webhookoff"] = "rbxassetid://96370548093471",
			["webhook"] = "rbxassetid://112812457747322",
			["weight"] = "rbxassetid://103860559844854",
			["wheatoff"] = "rbxassetid://133294844612307",
			["wheat"] = "rbxassetid://85261952080359",
			["wholeword"] = "rbxassetid://90111083954485",
			["wificog"] = "rbxassetid://110500263326209",
			["wifihigh"] = "rbxassetid://81954601342139",
			["wifilow"] = "rbxassetid://138217335635913",
			["wifipen"] = "rbxassetid://91290205064712",
			["wifisync"] = "rbxassetid://84043971055177",
			["wifizero"] = "rbxassetid://124286465246123",
			["windarrowdown"] = "rbxassetid://127753987414870",
			["wineoff"] = "rbxassetid://108294164302317",
			["wine"] = "rbxassetid://115743721332829",
			["workflow"] = "rbxassetid://99186544029189",
			["worm"] = "rbxassetid://115752311548091",
			["youtube"] = "rbxassetid://123663668456341",
			["zapoff"] = "rbxassetid://81385483183652",
			["zap"] = "rbxassetid://130551565616516",
			["balloon"] = "rbxassetid://97489111621526",
			["beefoff"] = "rbxassetid://99869959725200",
			["booksearch"] = "rbxassetid://132585409504950",
			["calendars"] = "rbxassetid://130944763042289",
			["cannabisoff"] = "rbxassetid://101938500363812",
			["cctvoff"] = "rbxassetid://75925370187295",
			["cigarette"] = "rbxassetid://137149549886852",
			["circlepile"] = "rbxassetid://116353155251541",
			["cloudbackup"] = "rbxassetid://111649579696132",
			["cloudsync"] = "rbxassetid://79393911188593",
			["databasesearch"] = "rbxassetid://92017137080138",
			["ellipse"] = "rbxassetid://71559658267482",
			["fingerprintpattern"] = "rbxassetid://80934710831288",
			["fishinghook"] = "rbxassetid://121038780855899",
			["fishingrod"] = "rbxassetid://71754848048049",
			["form"] = "rbxassetid://72999643971000",
			["gitmergeconflict"] = "rbxassetid://85677801675703",
			["globeoff"] = "rbxassetid://77775243585824",
			["globex"] = "rbxassetid://109268097029296",
			["hd"] = "rbxassetid://71682790698278",
			["layersplus"] = "rbxassetid://77587765623057",
			["lensconcave"] = "rbxassetid://94819631937027",
			["lensconvex"] = "rbxassetid://74736504195474",
			["linedotrighthorizontal"] = "rbxassetid://104718593155221",
			["linestyle"] = "rbxassetid://90176717785772",
			["mappinsearch"] = "rbxassetid://89065012915078",
			["messagecirclecheck"] = "rbxassetid://132772297689418",
			["messagesquarecheck"] = "rbxassetid://125789987055668",
			["metronome"] = "rbxassetid://101991829345965",
			["mirrorrectangular"] = "rbxassetid://109046769760336",
			["mirrorround"] = "rbxassetid://121534049429097",
			["mouseleft"] = "rbxassetid://99144293708743",
			["mouseright"] = "rbxassetid://88331710212594",
			["printerx"] = "rbxassetid://103002721801548",
			["radiooff"] = "rbxassetid://80359258046586",
			["road"] = "rbxassetid://120251329173530",
			["scooter"] = "rbxassetid://100035452787934",
			["searchalert"] = "rbxassetid://127597984617505",
			["shelvingunit"] = "rbxassetid://80116568514793",
			["shieldcogcorner"] = "rbxassetid://111694066132698",
			["shieldcog"] = "rbxassetid://129235695057857",
			["sportshoe"] = "rbxassetid://120495992692630",
			["squarearrowrightenter"] = "rbxassetid://138867831495334",
			["squarearrowrightexit"] = "rbxassetid://133688575845430",
			["squarecenterlinedashedhorizontal"] = "rbxassetid://77780104374341",
			["squarecenterlinedashedvertical"] = "rbxassetid://107878435803525",
			["stone"] = "rbxassetid://135161057497830",
			["toolbox"] = "rbxassetid://85341033903792",
			["towelrack"] = "rbxassetid://125223915620991",
			["userkey"] = "rbxassetid://105403041782190",
			["userroundkey"] = "rbxassetid://124547549008939",
			["van"] = "rbxassetid://122066377022942",
			["wavesarrowdown"] = "rbxassetid://129215220911792",
			["wavesarrowup"] = "rbxassetid://102314705716217",
			["weighttilde"] = "rbxassetid://112081212176951",
			["xlinetop"] = "rbxassetid://140592656289509",
			["zodiacaquarius"] = "rbxassetid://74560047770362",
			["zodiacaries"] = "rbxassetid://73255859670234",
			["zodiaccancer"] = "rbxassetid://131985162532947",
			["zodiaccapricorn"] = "rbxassetid://97859568140652",
			["zodiacgemini"] = "rbxassetid://80997588122992",
			["zodiacleo"] = "rbxassetid://75509406718106",
			["zodiaclibra"] = "rbxassetid://113222735060218",
			["zodiacophiuchus"] = "rbxassetid://129180108892480",
			["zodiacpisces"] = "rbxassetid://95845819440327",
			["zodiacsagittarius"] = "rbxassetid://82651026742181",
			["zodiacscorpio"] = "rbxassetid://113640924054631",
			["zodiactaurus"] = "rbxassetid://123053219704400",
			["zodiacvirgo"] = "rbxassetid://99462994613661"
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
			
			if type(decode) == "table" then
				-- (tamanho salvo ignorado: vale o padrao do Save)
				
				-- (tema salvo ignorado: o padrao agora e White)
			end
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
				-- local _Flags = {}
				-- for _,Flag in pairs(Flags) do _Flags[_] = Flag.Value end
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
	Name = "redz-library-v5",
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

-- ===== sons de clique (um ID por evento, editáveis) ===== --
local DefaultSounds = {
	Click = "rbxassetid://127105730240202",
	Tab = "rbxassetid://127105730240202",
	DropdownOpen = "rbxassetid://128266063262896",
	DropdownClose = "rbxassetid://128266063262896",
	Toggle = "rbxassetid://127105730240202",
	Dialog = "rbxassetid://127105730240202",
	Close = "rbxassetid://7244593699"
}
local SoundCache = {}
local function PlayClick(Name)
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
	Snd.Volume = HzsLib.SoundVolume or 0.6
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
	
	-- cancela o tween anterior da mesma propriedade (evita acumular tweens)
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
		Color = Color3.fromRGB(255, 255, 255),
		Thickness = 1,
		Transparency = 0.55,
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

-- /////////// --
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

-- HzsLib:SetSoundId("DropdownOpen", 1234567) troca o som de um evento
-- eventos: Click, Tab, DropdownOpen, DropdownClose, Toggle, Dialog, Close
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
	
	Comnection:FireConnection("ThemeChanged", NewTheme)
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

function HzsLib:MakeWindow(Configs)
	local WTitle = Configs[1] or Configs.Name or Configs.Title or "redz Library V5"
	local WMiniText = Configs[2] or Configs.SubTitle or "by : redz9999"
	
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
	
	-- contorno branco da janela
	Create("UIStroke", MainFrame, {
		Color = Color3.fromRGB(255, 255, 255),
		Thickness = 1.5,
		Transparency = 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Name = "WindowStroke"
	})
	
	-- ===== Background por URL ===== --
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
	
	local function BgWarn(...) warn("[redz bg]", ...) end
	
	local function IsImage(Body)
		if type(Body) ~= "string" or #Body < 200 then return false end
		local b1, b2, b3, b4 = Body:byte(1, 4)
		return (b1 == 0xFF and b2 == 0xD8)                         -- JPEG
			or (b1 == 0x89 and b2 == 0x50 and b3 == 0x4E and b4 == 0x47) -- PNG
			or (b1 == 0x47 and b2 == 0x49 and b3 == 0x46)             -- GIF
			or (b1 == 0x52 and b2 == 0x49 and b3 == 0x46 and b4 == 0x46) -- WEBP
	end
	
	local function Download(Url)
		local Req = (syn and syn.request) or (http and http.request) or http_request or request
		if Req then
			local Ok, Res = pcall(Req, {
				Url = Url,
				Method = "GET",
				Headers = {["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120 Safari/537.36"}
			})
			if Ok and type(Res) == "table" then
				if Res.StatusCode == 200 and IsImage(Res.Body) then return Res.Body end
				BgWarn("download falhou, status:", Res.StatusCode, "(link expirado ou bloqueado?)")
			else
				BgWarn("request falhou:", tostring(Res))
			end
		end
		local Ok, Res = pcall(function() return game:HttpGet(Url) end)
		if Ok and IsImage(Res) then return Res end
		return nil
	end
	
	local function GetBackgroundAsset(Url)
		local GetAsset = getcustomasset or getsynasset
		if type(Url) ~= "string" or #Url == 0 then return end
		if not (writefile and GetAsset) then
			BgWarn("seu executor nao tem writefile/getcustomasset")
			return
		end
		
		local Name = Url:match("/([%w_%-]+)%.%w+%?") or Url:match("/([%w_%-]+)%.%w+$") or "bg"
		local File = "redz_bg_" .. Name .. ".jpg"
		
		-- cache invalido (ex: salvou uma pagina de erro) e apagado
		if isfile and isfile(File) then
			local Ok, Data = pcall(readfile, File)
			if not (Ok and IsImage(Data)) then
				pcall(delfile or function() end, File)
			end
		end
		
		if not (isfile and isfile(File)) then
			local Body = Download(Url)
			if not Body and Url:find("cdn.discordapp.com", 1, true) then
				Body = Download((Url:gsub("cdn.discordapp.com", "media.discordapp.net")))
			end
			if not Body then
				BgWarn("nao consegui baixar a imagem. Gere um link novo ou use outro host (ex: imgur).")
				return
			end
			writefile(File, Body)
			task.wait(0.15)
		end
		
		local Ok, Asset = pcall(GetAsset, File)
		if not Ok then BgWarn("getcustomasset falhou:", tostring(Asset)) return end
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
	-- ===== fim do Background ===== --
	
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
	
	local SearchH = 30 -- espaço da barra de pesquisa acima das abas
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
	
	-- ===== animação de abertura (leve, centralizada) ===== --
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
	
	-- ===== sons de clique em todos os botões ===== --
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
	
	-- ===== redimensionar pelas bordas e cantos ===== --
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
	
	-- bordas
	MakeEdge("Right",  UDim2.new(0, 8, 1, -68), UDim2.new(1, 0, 0, 34), Vector2.new(1, 0), 1, 0)
	MakeEdge("Left",   UDim2.new(0, 8, 1, -68), UDim2.new(0, 0, 0, 34), Vector2.new(0, 0), -1, 0)
	MakeEdge("Bottom", UDim2.new(1, -68, 0, 8), UDim2.new(0, 34, 1, 0), Vector2.new(0, 1), 0, 1)
	MakeEdge("Top",    UDim2.new(1, -68, 0, 5), UDim2.new(0, 34, 0, 0), Vector2.new(0, 0), 0, -1)
	-- cantos (o canto inferior direito já é o "Control Hub Size")
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
	
	SetChildren(ButtonsFolder, {
		CloseButton,
		MinimizeButton
	})
	
	CloseButton:SetAttribute("Snd", "Close")
	
	-- hover leve nos botões da barra
	CloseButton.MouseEnter:Connect(function() CreateTween({CloseButton, "ImageColor3", Color3.fromRGB(255, 90, 90), 0.15}) end)
	CloseButton.MouseLeave:Connect(function() CreateTween({CloseButton, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.15}) end)
	MinimizeButton.MouseEnter:Connect(function() CreateTween({MinimizeButton, "ImageColor3", Color3.fromRGB(200, 200, 200), 0.15}) end)
	MinimizeButton.MouseLeave:Connect(function() CreateTween({MinimizeButton, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.15}) end)
	
	local Minimized, SaveSize, WaitClick
	local Window, FirstTab = {}, false
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
			BackgroundColor3 = Theme["Color Stroke"],
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
					Button.Size = UDim2.new(1 / ButtonCount, -(((ButtonCount - 1) * 20) / ButtonCount), 0, 32) -- Fluent Library :)
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
	
	-- ===== barra de pesquisa de componentes (topo) ===== --
	local GlobalSearch = Create("Frame", Components, {
		Size = UDim2.new(0, MainScroll.Size.X.Offset - 26, 0, 22),
		Position = UDim2.new(0, 16, 0, TopBar.Size.Y.Offset + 4),
		AnchorPoint = Vector2.new(0, 0),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.35,
		Name = "SearchBar"
	})Make("Corner", GlobalSearch, UDim.new(0, 20))
	-- acompanha a largura da coluna de abas ao redimensionar
	MainScroll:GetPropertyChangedSignal("Size"):Connect(function()
		GlobalSearch.Size = UDim2.new(0, MainScroll.Size.X.Offset - 26, 0, 22)
	end)
	Create("UIStroke", GlobalSearch, {
		Color = Color3.fromRGB(255, 255, 255),
		Thickness = 1,
		Transparency = 0.55,
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
		PlaceholderText = "Pesquisar componente...",
		PlaceholderColor3 = Color3.fromRGB(170, 170, 170),
		TextColor3 = Color3.fromRGB(255, 255, 255),
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
	
	-- esconde/mostra sem mexer no que o usuario escondeu por conta propria
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
		-- se a aba aberta nao tem resultado, pula para a primeira que tiver
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
	-- ===== fim da pesquisa de componentes ===== --
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
			Visible = false -- barrinha rosa removida
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
		function Tab:AddParagraph(Configs)
			local PName = Configs[1] or Configs.Title or "Paragraph"
			local PDesc = Configs[2] or Configs.Text or ""
			
			local Frame, LabelFunc = ButtonFrame(Container, PName, PDesc, UDim2.new(1, -20))
			
			local Paragraph = {}
			function Paragraph:Visible(...) Funcs:ToggleVisible(Frame, ...) end
			function Paragraph:Destroy() Frame:Destroy() end
			function Paragraph:SetTitle(Val)
				LabelFunc:SetTitle(GetStr(Val))
			end
			function Paragraph:SetDesc(Val)
				LabelFunc:SetDesc(GetStr(Val))
			end
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
			
			-- barra de pesquisa do dropdown
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
			
			-- clique na barra: não fecha o dropdown e foca a caixa de texto
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
			Button:SetAttribute("Snd", "None") -- o dropdown toca o próprio som
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
				local ClampY = math.clamp((FramePos.Y / UIScale) , 0, ScreenSize.Y / UIScale)
				
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
					SetFlag(Flag, if MultiSelect then Selected else tostring(Selected or "..."))
					Funcs:FireCallback(Callback, Selected)
				end
				
				local function UpdateLabel()
					if MultiSelect then
						local list = {}
						for index, Value in pairs(Selected) do
							if Value then
								table.insert(list, index)
							end
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
					table.foreach(Option, function(_,Name)
						AddOption(Name)
					end)
				else
					table.foreach(NewOptions, function(_,Name)
						AddOption(Name)
					end)
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
					for _,Val in pairs(Options) do
						if Val.Name == Option then
							Val.Active()
						end
					end
				elseif type(Option) == "number" then
					for ind,Val in pairs(Options) do
						if ind == Option then
							Val.Active()
						end
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
			
			local UIScale = Create("UIScale", LabelVal)
			
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
				UIScale.Scale = 0.3
				CreateTween({UIScale, "Scale", 1.2, 0.1})
				CreateTween({LabelVal, "Rotation", math.random(-1, 1) * 5, 0.15, true})
				CreateTween({UIScale, "Scale", 1, 0.2})
				CreateTween({LabelVal, "Rotation", 0, 0.1})
			end)
			
			function SetSlider(NewValue)
				if type(NewValue) ~= "number" then return end
				
				local Min, Max = Min * Increase, Max * Increase
				
				local SliderPos = (NewValue - Min) / (Max - Min)
				
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
