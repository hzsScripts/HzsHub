local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")
local MarketplaceService = game:GetService("MarketplaceService")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")
local Library = {}
local Window, Tab, Section = {}, {}, {}
Window.__index, Tab.__index, Section.__index = Window, Tab, Section
local rgb = Color3.fromRGB
local C = {
    bg1=rgb(29,27,37), bg2=rgb(22,21,28), side1=rgb(32,30,40), side2=rgb(26,25,33),
    card1=rgb(36,34,46), card2=rgb(31,30,40), row=rgb(41,39,52), hover=rgb(49,47,62),
    line=rgb(52,49,64), track=rgb(57,54,71), text=rgb(226,223,235), text2=rgb(198,194,212),
    sub=rgb(156,151,174), muted=rgb(126,121,144), dim=rgb(100,96,117),
    accent=rgb(152,134,226), accent2=rgb(206,132,196), accentDim=rgb(54,47,76), pinkDim=rgb(62,46,72),
    knob=rgb(236,233,245), online=rgb(98,206,140), white=rgb(255,255,255), black=rgb(0,0,0),
    danger=rgb(222,118,132), dangerDim=rgb(66,40,48)}
local THEMES = {
    Violet={rgb(152,134,226),rgb(206,132,196),rgb(54,47,76),rgb(62,46,72)},
    Ocean={rgb(104,160,232),rgb(96,198,206),rgb(38,52,76),rgb(36,60,70)},
    Crimson={rgb(226,112,122),rgb(232,160,106),rgb(72,40,48),rgb(74,50,44)},
    Emerald={rgb(98,196,148),rgb(124,198,220),rgb(36,62,54),rgb(36,58,66)},
    Sakura={rgb(226,140,186),rgb(238,170,150),rgb(74,44,62),rgb(76,52,56)},
    Midnight={rgb(110,125,190),rgb(150,120,210),rgb(35,39,66),rgb(48,42,72)},
    Rose={rgb(235,105,155),rgb(255,155,185),rgb(75,38,57),rgb(78,45,62)},
    Sunset={rgb(245,145,85),rgb(235,95,115),rgb(78,48,43),rgb(78,43,53)},
    Arctic={rgb(105,190,225),rgb(155,225,240),rgb(35,60,75),rgb(40,68,78)},
    Monochrome={rgb(175,175,185),rgb(225,225,230),rgb(48,48,54),rgb(60,60,66)},
    Gold={rgb(220,175,80),rgb(250,215,125),rgb(72,59,35),rgb(78,65,39)},
    Neon={rgb(80,235,190),rgb(110,180,255),rgb(30,65,65),rgb(35,55,80)},
    Mint={rgb(105,205,165),rgb(155,230,190),rgb(35,65,55),rgb(40,70,60)},
    Cyberpunk={rgb(220,85,220),rgb(70,210,245),rgb(70,35,78),rgb(35,60,78)},
    Lava={rgb(235,90,65),rgb(255,165,75),rgb(78,38,32),rgb(80,48,30)},
    Coffee={rgb(175,130,95),rgb(220,180,135),rgb(65,48,39),rgb(75,56,43)},
    Royal={rgb(115,105,220),rgb(195,145,235),rgb(45,40,85),rgb(62,45,88)},
    Pink={rgb(255,105,180),rgb(255,160,210),rgb(78,38,65),rgb(84,43,73)},
    Aqua={rgb(40,205,205),rgb(105,225,235),rgb(30,66,72),rgb(36,76,82)},
    Graphite={rgb(145,155,170),rgb(195,202,214),rgb(43,48,58),rgb(53,58,68)},
    Lavender={rgb(165,135,235),rgb(205,175,255),rgb(55,43,82),rgb(68,51,92)},
    Cherry={rgb(205,55,105),rgb(245,105,145),rgb(72,31,48),rgb(82,38,57)},
    Cobalt={rgb(65,125,235),rgb(105,175,255),rgb(32,48,82),rgb(35,58,95)},
    Coral={rgb(245,125,115),rgb(255,180,145),rgb(78,43,47),rgb(88,53,52)},
    Lime={rgb(160,210,75),rgb(205,235,115),rgb(48,66,35),rgb(60,78,40)},
    Ice={rgb(150,205,245),rgb(205,235,255),rgb(40,58,78),rgb(48,70,88)}}
local THEME_ORDER = {"Violet","Ocean","Crimson","Emerald","Sakura","Midnight","Rose","Sunset","Arctic","Monochrome","Gold","Neon","Mint","Cyberpunk","Lava","Coffee","Royal","Pink","Aqua","Graphite","Lavender","Cherry","Cobalt","Coral","Lime","Ice"}
local themedObjects = setmetatable({}, {__mode="k"})
local function themed(object,apply)
    themedObjects[object]=apply
    apply()
    return object
end
local function applyTheme(name)
    local t=THEMES[name] or THEMES.Violet
    C.accent,C.accent2,C.accentDim,C.pinkDim=t[1],t[2],t[3],t[4]
    for object,apply in pairs(themedObjects) do
        if object.Parent then pcall(apply) end
    end
end
local function font(name,fallback)
    local ok,result=pcall(function() return Enum.Font[name] end)
    return ok and result or fallback
end
local F = {body=font("BuilderSansMedium",Enum.Font.GothamMedium), bold=font("BuilderSansBold",Enum.Font.GothamBold)}
local HAS_FILES = type(readfile)=="function" and type(writefile)=="function" and type(isfile)=="function"
local LOGO, CLICK_SOUND = "https://cdn.discordapp.com/attachments/1552055729450520656/1571244099737100318/f7d253ec8f25453ac387322c3061e848.jpg?ex=6aff4c99&is=6afdfb19&hm=b59cf54605f0d5f763d488fe32b54807fe09f0043abc2873754e684964bac9a8", 6895079853
-- Lucide icons for Roblox (MIT, Latte Softworks / lucide-roblox; icons ISC, Lucide contributors)
local ICON_SHEETS = {16898612629,16898612819,16898613044,16898613353,16898613509,16898613613,16898613699,16898613777,16898613869}
local ICON_DATA = table.concat({
    "a-arrow-down:1,771,0;a-arrow-up:1,0,771;a-large-small:1,771,257;accessibility:1,257,771;activity:1,514,771;activity-square:1,771,514;air-vent:1,820,0;airplay:1,771,49;alarm-check:1",
    ",49,771;alarm-clock:1,257,820;alarm-clock-check:1,0,820;alarm-clock-minus:1,820,257;alarm-clock-off:1,771,306;alarm-clock-plus:1,306,771;alarm-minus:1,820,514;alarm-plus:1,771,563;",
    "alarm-smoke:1,563,771;album:1,514,820;alert-circle:1,869,0;alert-octagon:1,820,49;alert-triangle:1,771,98;align-center:1,0,869;align-center-horizontal:1,98,771;align-center-vertica",
    "l:1,49,820;align-end-horizontal:1,869,257;align-end-vertical:1,820,306;align-horizontal-distribute-center:1,771,355;align-horizontal-distribute-end:1,355,771;align-horizontal-distr",
    "ibute-start:1,306,820;align-horizontal-justify-center:1,257,869;align-horizontal-justify-end:1,869,514;align-horizontal-justify-start:1,820,563;align-horizontal-space-around:1,771,",
    "612;align-horizontal-space-between:1,612,771;align-justify:1,563,820;align-left:1,514,869;align-right:1,918,0;align-start-horizontal:1,869,49;align-start-vertical:1,820,98;align-ve",
    "rtical-distribute-center:1,771,147;align-vertical-distribute-end:1,147,771;align-vertical-distribute-start:1,98,820;align-vertical-justify-center:1,49,869;align-vertical-justify-en",
    "d:1,0,918;align-vertical-justify-start:1,918,257;align-vertical-space-around:1,869,306;align-vertical-space-between:1,820,355;ambulance:1,771,404;ampersand:1,404,771;ampersands:1,3",
    "55,820;anchor:1,306,869;angry:1,257,918;annoyed:1,918,514;antenna:1,869,563;anvil:1,820,612;aperture:1,771,661;app-window:1,612,820;app-window-mac:1,661,771;apple:1,563,869;archive",
    ":1,918,49;archive-restore:1,514,918;archive-x:1,967,0;area-chart:1,869,98;armchair:1,820,147;arrow-big-down:1,196,771;arrow-big-down-dash:1,771,196;arrow-big-left:1,98,869;arrow-bi",
    "g-left-dash:1,147,820;arrow-big-right:1,0,967;arrow-big-right-dash:1,49,918;arrow-big-up:1,918,306;arrow-big-up-dash:1,967,257;arrow-down:1,967,49;arrow-down-0-1:1,869,355;arrow-do",
    "wn-1-0:1,820,404;arrow-down-a-z:1,771,453;arrow-down-circle:1,453,771;arrow-down-from-line:1,404,820;arrow-down-left:1,257,967;arrow-down-left-from-circle:1,355,869;arrow-down-left",
    "-square:1,306,918;arrow-down-narrow-wide:1,967,514;arrow-down-right:1,820,661;arrow-down-right-from-circle:1,918,563;arrow-down-right-square:1,869,612;arrow-down-square:1,771,710;a",
    "rrow-down-to-dot:1,710,771;arrow-down-to-line:1,661,820;arrow-down-up:1,612,869;arrow-down-wide-narrow:1,563,918;arrow-down-z-a:1,514,967;arrow-left:1,98,918;arrow-left-circle:1,91",
    "8,98;arrow-left-from-line:1,869,147;arrow-left-right:1,820,196;arrow-left-square:1,196,820;arrow-left-to-line:1,147,869;arrow-right:1,453,820;arrow-right-circle:1,49,967;arrow-righ",
    "t-from-line:1,967,306;arrow-right-left:1,918,355;arrow-right-square:1,869,404;arrow-right-to-line:1,820,453;arrow-up:1,967,355;arrow-up-0-1:1,404,869;arrow-up-1-0:1,355,918;arrow-u",
    "p-a-z:1,306,967;arrow-up-circle:1,967,563;arrow-up-down:1,918,612;arrow-up-from-dot:1,869,661;arrow-up-from-line:1,820,710;arrow-up-left:1,661,869;arrow-up-left-from-circle:1,771,7",
    "59;arrow-up-left-square:1,710,820;arrow-up-narrow-wide:1,612,918;arrow-up-right:1,918,147;arrow-up-right-from-circle:1,563,967;arrow-up-right-square:1,967,98;arrow-up-square:1,869,",
    "196;arrow-up-to-line:1,196,869;arrow-up-wide-narrow:1,147,918;arrow-up-z-a:1,98,967;arrows-up-from-line:1,918,404;asterisk:1,869,453;at-sign:1,453,869;atom:1,404,918;audio-lines:1,",
    "355,967;audio-waveform:1,967,612;award:1,918,661;axe:1,869,710;axis-3d:1,820,759;baby:1,771,808;backpack:1,710,869;badge:1,661,967;badge-alert:1,661,918;badge-cent:1,612,967;badge-",
    "check:1,967,147;badge-dollar-sign:1,918,196;badge-euro:1,196,918;badge-help:1,147,967;badge-indian-rupee:1,967,404;badge-info:1,918,453;badge-japanese-yen:1,453,918;badge-minus:1,4",
    "04,967;badge-percent:1,967,661;badge-plus:1,918,710;badge-pound-sterling:1,869,759;badge-russian-ruble:1,820,808;badge-swiss-franc:1,771,857;badge-x:1,710,918;baggage-claim:1,967,1",
    "96;ban:1,196,967;banana:1,967,453;banknote:1,453,967;bar-chart:1,967,759;bar-chart-2:1,967,710;bar-chart-3:1,918,759;bar-chart-4:1,869,808;bar-chart-big:1,820,857;bar-chart-horizon",
    "tal:1,710,967;bar-chart-horizontal-big:1,771,906;barcode:1,918,808;baseline:1,869,857;bath:1,820,906;battery:1,967,857;battery-charging:1,771,955;battery-full:1,967,808;battery-low",
    ":1,918,857;battery-medium:1,869,906;battery-warning:1,820,955;beaker:1,918,906;bean:1,967,906;bean-off:1,869,955;bed:2,771,0;bed-double:1,918,955;bed-single:1,967,955;beef:2,0,771;",
    "beer:2,257,771;beer-off:2,771,257;bell:2,820,257;bell-dot:2,771,514;bell-electric:2,514,771;bell-minus:2,820,0;bell-off:2,771,49;bell-plus:2,49,771;bell-ring:2,0,820;between-horizo",
    "ntal-end:2,771,306;between-horizontal-start:2,306,771;between-vertical-end:2,257,820;between-vertical-start:2,820,514;bike:2,771,563;binary:2,563,771;biohazard:2,514,820;bird:2,869",
    ",0;bitcoin:2,820,49;blend:2,771,98;blinds:2,98,771;blocks:2,49,820;bluetooth:2,771,355;bluetooth-connected:2,0,869;bluetooth-off:2,869,257;bluetooth-searching:2,820,306;bold:2,355,",
    "771;bolt:2,306,820;bomb:2,257,869;bone:2,869,514;book:2,820,612;book-a:2,820,563;book-audio:2,771,612;book-check:2,612,771;book-copy:2,563,820;book-dashed:2,514,869;book-down:2,918",
    ",0;book-headphones:2,869,49;book-heart:2,820,98;book-image:2,771,147;book-key:2,147,771;book-lock:2,98,820;book-marked:2,49,869;book-minus:2,0,918;book-open:2,820,355;book-open-che",
    "ck:2,918,257;book-open-text:2,869,306;book-plus:2,771,404;book-text:2,404,771;book-type:2,355,820;book-up:2,257,918;book-up-2:2,306,869;book-user:2,918,514;book-x:2,869,563;bookmar",
    "k:2,514,918;bookmark-check:2,771,661;bookmark-minus:2,661,771;bookmark-plus:2,612,820;bookmark-x:2,563,869;boom-box:2,967,0;bot:2,869,98;bot-message-square:2,918,49;box:2,771,196;b",
    "ox-select:2,820,147;boxes:2,196,771;braces:2,147,820;brackets:2,98,869;brain:2,967,257;brain-circuit:2,49,918;brain-cog:2,0,967;brick-wall:2,918,306;briefcase:2,771,453;briefcase-b",
    "usiness:2,869,355;briefcase-medical:2,820,404;bring-to-front:2,453,771;brush:2,404,820;bug:2,257,967;bug-off:2,355,869;bug-play:2,306,918;building:2,918,563;building-2:2,967,514;bu",
    "s:2,820,661;bus-front:2,869,612;cable:2,710,771;cable-car:2,771,710;cake:2,612,869;cake-slice:2,661,820;calculator:2,563,918;calendar:2,355,918;calendar-check:2,967,49;calendar-che",
    "ck-2:2,514,967;calendar-clock:2,918,98;calendar-days:2,869,147;calendar-fold:2,820,196;calendar-heart:2,196,820;calendar-minus:2,98,918;calendar-minus-2:2,147,869;calendar-off:2,49",
    ",967;calendar-plus:2,918,355;calendar-plus-2:2,967,306;calendar-range:2,869,404;calendar-search:2,820,453;calendar-x:2,404,869;calendar-x-2:2,453,820;camera:2,967,563;camera-off:2,",
    "306,967;candlestick-chart:2,918,612;candy:2,771,759;candy-cane:2,869,661;candy-off:2,820,710;cannabis:2,710,820;captions:2,612,918;captions-off:2,661,869;car:2,918,147;car-front:2,",
    "563,967;car-taxi-front:2,967,98;caravan:2,869,196;carrot:2,196,869;case-lower:2,147,918;case-sensitive:2,98,967;case-upper:2,967,355;cassette-tape:2,918,404;cast:2,869,453;castle:2",
    ",453,869;cat:2,404,918;cctv:2,355,967;check:2,710,869;check-check:2,967,612;check-circle:2,869,710;check-circle-2:2,918,661;check-square:2,771,808;check-square-2:2,820,759;chef-hat",
    ":2,661,918;cherry:2,612,967;chevron-down:2,196,918;chevron-down-circle:2,967,147;chevron-down-square:2,918,196;chevron-first:2,147,967;chevron-last:2,967,404;chevron-left:2,404,967",
    ";chevron-left-circle:2,918,453;chevron-left-square:2,453,918;chevron-right:2,869,759;chevron-right-circle:2,967,661;chevron-right-square:2,918,710;chevron-up:2,710,918;chevron-up-c",
    "ircle:2,820,808;chevron-up-square:2,771,857;chevrons-down:2,967,196;chevrons-down-up:2,661,967;chevrons-left:2,967,453;chevrons-left-right:2,196,967;chevrons-right:2,967,710;chevro",
    "ns-right-left:2,453,967;chevrons-up:2,869,808;chevrons-up-down:2,918,759;chrome:2,820,857;church:2,771,906;cigarette:2,967,759;cigarette-off:2,710,967;circle:3,771,355;circle-alert",
    ":2,918,808;circle-arrow-down:2,869,857;circle-arrow-left:2,820,906;circle-arrow-out-down-left:2,771,955;circle-arrow-out-down-right:2,967,808;circle-arrow-out-up-left:2,918,857;cir",
    "cle-arrow-out-up-right:2,869,906;circle-arrow-right:2,820,955;circle-arrow-up:2,967,857;circle-check:2,869,955;circle-check-big:2,918,906;circle-chevron-down:2,967,906;circle-chevr",
    "on-left:2,918,955;circle-chevron-right:2,967,955;circle-chevron-up:3,771,0;circle-dashed:3,0,771;circle-divide:3,771,257;circle-dollar-sign:3,257,771;circle-dot:3,514,771;circle-do",
    "t-dashed:3,771,514;circle-ellipsis:3,820,0;circle-equal:3,771,49;circle-fading-plus:3,49,771;circle-gauge:3,0,820;circle-help:3,820,257;circle-minus:3,771,306;circle-off:3,306,771;",
    "circle-parking:3,820,514;circle-parking-off:3,257,820;circle-pause:3,771,563;circle-percent:3,563,771;circle-play:3,514,820;circle-plus:3,869,0;circle-power:3,820,49;circle-slash:3",
    ",98,771;circle-slash-2:3,771,98;circle-stop:3,49,820;circle-user:3,869,257;circle-user-round:3,0,869;circle-x:3,820,306;circuit-board:3,355,771;citrus:3,306,820;clapperboard:3,257,",
    "869;clipboard:3,49,869;clipboard-check:3,869,514;clipboard-copy:3,820,563;clipboard-edit:3,771,612;clipboard-list:3,612,771;clipboard-minus:3,563,820;clipboard-paste:3,514,869;clip",
    "board-pen:3,869,49;clipboard-pen-line:3,918,0;clipboard-plus:3,820,98;clipboard-signature:3,771,147;clipboard-type:3,147,771;clipboard-x:3,98,820;clock:3,771,661;clock-1:3,0,918;cl",
    "ock-10:3,918,257;clock-11:3,869,306;clock-12:3,820,355;clock-2:3,771,404;clock-3:3,404,771;clock-4:3,355,820;clock-5:3,306,869;clock-6:3,257,918;clock-7:3,918,514;clock-8:3,869,563",
    ";clock-9:3,820,612;cloud:3,918,306;cloud-cog:3,661,771;cloud-download:3,612,820;cloud-drizzle:3,563,869;cloud-fog:3,514,918;cloud-hail:3,967,0;cloud-lightning:3,918,49;cloud-moon:3",
    ",820,147;cloud-moon-rain:3,869,98;cloud-off:3,771,196;cloud-rain:3,147,820;cloud-rain-wind:3,196,771;cloud-snow:3,98,869;cloud-sun:3,0,967;cloud-sun-rain:3,49,918;cloud-upload:3,96",
    "7,257;cloudy:3,869,355;clover:3,820,404;club:3,771,453;code:3,355,869;code-2:3,453,771;code-xml:3,404,820;codepen:3,306,918;codesandbox:3,257,967;coffee:3,967,514;cog:3,918,563;coi",
    "ns:3,869,612;columns:3,661,820;columns-2:3,820,661;columns-3:3,771,710;columns-4:3,710,771;combine:3,612,869;command:3,563,918;compass:3,514,967;component:3,967,49;computer:3,918,9",
    "8;concierge-bell:3,869,147;cone:3,820,196;construction:3,196,820;contact:3,49,967;contact-2:3,147,869;contact-round:3,98,918;container:3,967,306;contrast:3,918,355;cookie:3,869,404",
    ";cooking-pot:3,820,453;copy:3,918,612;copy-check:3,453,820;copy-minus:3,404,869;copy-plus:3,355,918;copy-slash:3,306,967;copy-x:3,967,563;copyleft:3,869,661;copyright:3,820,710;cor",
    "ner-down-left:3,771,759;corner-down-right:3,710,820;corner-left-down:3,661,869;corner-left-up:3,612,918;corner-right-down:3,563,967;corner-right-up:3,967,98;corner-up-left:3,918,14",
    "7;corner-up-right:3,869,196;cpu:3,196,869;creative-commons:3,147,918;credit-card:3,98,967;croissant:3,967,355;crop:3,918,404;cross:3,869,453;crosshair:3,453,869;crown:3,404,918;cub",
    "oid:3,355,967;cup-soda:3,967,612;currency:3,918,661;cylinder:3,869,710;database:3,710,869;database-backup:3,820,759;database-zap:3,771,808;delete:3,661,918;dessert:3,612,967;diamet",
    "er:3,967,147;diamond:3,196,918;diamond-percent:3,918,196;dice-1:3,147,967;dice-2:3,967,404;dice-3:3,918,453;dice-4:3,453,918;dice-5:3,404,967;dice-6:3,967,661;dices:3,918,710;diff:",
    "3,869,759;disc:3,661,967;disc-2:3,820,808;disc-3:3,771,857;disc-album:3,710,918;divide:3,967,453;divide-circle:3,967,196;divide-square:3,196,967;dna:3,967,710;dna-off:3,453,967;doc",
    "k:3,918,759;dog:3,869,808;dollar-sign:3,820,857;donut:3,771,906;door-closed:3,710,967;door-open:3,967,759;dot:3,918,808;download:3,820,906;download-cloud:3,869,857;drafting-compass",
    ":3,771,955;drama:3,967,808;dribbble:3,918,857;drill:3,869,906;droplet:3,820,955;droplets:3,967,857;drum:3,918,906;drumstick:3,869,955;dumbbell:3,967,906;ear:3,967,955;ear-off:3,918",
    ",955;earth:4,0,771;earth-lock:4,771,0;eclipse:4,771,257;egg:4,514,771;egg-fried:4,257,771;egg-off:4,771,514;ellipsis:4,771,49;ellipsis-vertical:4,820,0;equal:4,0,820;equal-not:4,49",
    ",771;eraser:4,820,257;euro:4,771,306;expand:4,306,771;external-link:4,257,820;eye:4,771,563;eye-off:4,820,514;facebook:4,563,771;factory:4,514,820;fan:4,869,0;fast-forward:4,820,49",
    ";feather:4,771,98;fence:4,98,771;ferris-wheel:4,49,820;figma:4,0,869;file:4,820,661;file-archive:4,869,257;file-audio:4,771,355;file-audio-2:4,820,306;file-axis-3d:4,355,771;file-b",
    "adge:4,257,869;file-badge-2:4,306,820;file-bar-chart:4,820,563;file-bar-chart-2:4,869,514;file-box:4,771,612;file-check:4,563,820;file-check-2:4,612,771;file-clock:4,514,869;file-c",
    "ode:4,869,49;file-code-2:4,918,0;file-cog:4,820,98;file-diff:4,771,147;file-digit:4,147,771;file-down:4,98,820;file-edit:4,49,869;file-heart:4,0,918;file-image:4,918,257;file-input",
    ":4,869,306;file-json:4,771,404;file-json-2:4,820,355;file-key:4,355,820;file-key-2:4,404,771;file-line-chart:4,306,869;file-lock:4,918,514;file-lock-2:4,257,918;file-minus:4,820,61",
    "2;file-minus-2:4,869,563;file-music:4,771,661;file-output:4,661,771;file-pen:4,563,869;file-pen-line:4,612,820;file-pie-chart:4,514,918;file-plus:4,918,49;file-plus-2:4,967,0;file-",
    "question:4,869,98;file-scan:4,820,147;file-search:4,196,771;file-search-2:4,771,196;file-signature:4,147,820;file-sliders:4,98,869;file-spreadsheet:4,49,918;file-stack:4,0,967;file",
    "-symlink:4,967,257;file-terminal:4,918,306;file-text:4,869,355;file-type:4,771,453;file-type-2:4,820,404;file-up:4,453,771;file-video:4,355,869;file-video-2:4,404,820;file-volume:4",
    ",257,967;file-volume-2:4,306,918;file-warning:4,967,514;file-x:4,869,612;file-x-2:4,918,563;files:4,771,710;film:4,710,771;filter:4,612,869;filter-x:4,661,820;fingerprint:4,563,918",
    ";fire-extinguisher:4,514,967;fish:4,869,147;fish-off:4,967,49;fish-symbol:4,918,98;flag:4,98,918;flag-off:4,820,196;flag-triangle-left:4,196,820;flag-triangle-right:4,147,869;flame",
    ":4,967,306;flame-kindling:4,49,967;flashlight:4,869,404;flashlight-off:4,918,355;flask-conical:4,453,820;flask-conical-off:4,820,453;flask-round:4,404,869;flip-horizontal:4,306,967",
    ";flip-horizontal-2:4,355,918;flip-vertical:4,918,612;flip-vertical-2:4,967,563;flower:4,820,710;flower-2:4,869,661;focus:4,771,759;fold-horizontal:4,710,820;fold-vertical:4,661,869",
    ";folder:4,404,967;folder-archive:4,612,918;folder-check:4,563,967;folder-clock:4,967,98;folder-closed:4,918,147;folder-cog:4,869,196;folder-dot:4,196,869;folder-down:4,147,918;fold",
    "er-edit:4,98,967;folder-git:4,918,404;folder-git-2:4,967,355;folder-heart:4,869,453;folder-input:4,453,869;folder-kanban:4,404,918;folder-key:4,355,967;folder-lock:4,967,612;folder",
    "-minus:4,918,661;folder-open:4,820,759;folder-open-dot:4,869,710;folder-output:4,771,808;folder-pen:4,710,869;folder-plus:4,661,918;folder-root:4,612,967;folder-search:4,918,196;fo",
    "lder-search-2:4,967,147;folder-symlink:4,196,918;folder-sync:4,147,967;folder-tree:4,967,404;folder-up:4,918,453;folder-x:4,453,918;folders:4,967,661;footprints:4,918,710;forklift:",
    "4,869,759;form-input:4,820,808;forward:4,771,857;frame:4,710,918;framer:4,661,967;frown:4,967,196;fuel:4,196,967;fullscreen:4,967,453;function-square:4,453,967;gallery-horizontal:4",
    ",918,759;gallery-horizontal-end:4,967,710;gallery-thumbnails:4,869,808;gallery-vertical:4,771,906;gallery-vertical-end:4,820,857;gamepad:4,967,759;gamepad-2:4,710,967;gantt-chart:4",
    ",869,857;gantt-chart-square:4,918,808;gauge:4,771,955;gauge-circle:4,820,906;gavel:4,967,808;gem:4,918,857;ghost:4,869,906;gift:4,820,955;git-branch:4,918,906;git-branch-plus:4,967",
    ",857;git-commit-horizontal:4,869,955;git-commit-vertical:4,967,906;git-compare:4,967,955;git-compare-arrows:4,918,955;git-fork:5,771,0;git-graph:5,0,771;git-merge:5,771,257;git-pul",
    "l-request:5,49,771;git-pull-request-arrow:5,257,771;git-pull-request-closed:5,771,514;git-pull-request-create:5,820,0;git-pull-request-create-arrow:5,514,771;git-pull-request-draft",
    ":5,771,49;github:5,0,820;gitlab:5,820,257;glass-water:5,771,306;glasses:5,306,771;globe:5,771,563;globe-2:5,257,820;globe-lock:5,820,514;goal:5,563,771;grab:5,514,820;graduation-ca",
    "p:5,869,0;grape:5,820,49;grid-2x2:5,771,98;grid-3x3:5,98,771;grip:5,869,257;grip-horizontal:5,49,820;grip-vertical:5,0,869;group:5,820,306;guitar:5,771,355;ham:5,355,771;hammer:5,3",
    "06,820;hand:5,563,820;hand-coins:5,257,869;hand-heart:5,869,514;hand-helping:5,820,563;hand-metal:5,771,612;hand-platter:5,612,771;handshake:5,514,869;hard-drive:5,820,98;hard-driv",
    "e-download:5,918,0;hard-drive-upload:5,869,49;hard-hat:5,771,147;hash:5,147,771;haze:5,98,820;hdmi-port:5,49,869;heading:5,355,820;heading-1:5,0,918;heading-2:5,918,257;heading-3:5",
    ",869,306;heading-4:5,820,355;heading-5:5,771,404;heading-6:5,404,771;headphones:5,306,869;headset:5,257,918;heart:5,661,771;heart-crack:5,918,514;heart-handshake:5,869,563;heart-of",
    "f:5,820,612;heart-pulse:5,771,661;heater:5,612,820;help-circle:5,563,869;helping-hand:5,514,918;hexagon:5,967,0;highlighter:5,918,49;history:5,869,98;home:5,820,147;hop:5,196,771;h",
    "op-off:5,771,196;hospital:5,147,820;hotel:5,98,869;hourglass:5,49,918;ice-cream:5,869,355;ice-cream-2:5,0,967;ice-cream-bowl:5,967,257;ice-cream-cone:5,918,306;image:5,306,918;imag",
    "e-down:5,820,404;image-minus:5,771,453;image-off:5,453,771;image-plus:5,404,820;image-up:5,355,869;images:5,257,967;import:5,967,514;inbox:5,918,563;indent:5,771,710;indent-decreas",
    "e:5,869,612;indent-increase:5,820,661;indian-rupee:5,710,771;infinity:5,661,820;info:5,612,869;inspection-panel:5,563,918;instagram:5,514,967;italic:5,967,49;iteration-ccw:5,918,98",
    ";iteration-cw:5,869,147;japanese-yen:5,820,196;joystick:5,196,820;kanban:5,49,967;kanban-square:5,98,918;kanban-square-dashed:5,147,869;key:5,869,404;key-round:5,967,306;key-square",
    ":5,918,355;keyboard:5,453,820;keyboard-music:5,820,453;lamp:5,869,661;lamp-ceiling:5,404,869;lamp-desk:5,355,918;lamp-floor:5,306,967;lamp-wall-down:5,967,563;lamp-wall-up:5,918,61",
    "2;land-plot:5,820,710;landmark:5,771,759;languages:5,710,820;laptop:5,563,967;laptop-2:5,661,869;laptop-minimal:5,612,918;lasso:5,918,147;lasso-select:5,967,98;laugh:5,869,196;laye",
    "rs:5,98,967;layers-2:5,196,869;layers-3:5,147,918;layout:5,967,612;layout-dashboard:5,967,355;layout-grid:5,918,404;layout-list:5,869,453;layout-panel-left:5,453,869;layout-panel-t",
    "op:5,404,918;layout-template:5,355,967;leaf:5,918,661;leafy-green:5,869,710;library:5,710,869;library-big:5,820,759;library-square:5,771,808;life-buoy:5,661,918;ligature:5,612,967;",
    "lightbulb:5,918,196;lightbulb-off:5,967,147;line-chart:5,196,918;link:5,918,453;link-2:5,967,404;link-2-off:5,147,967;linkedin:5,453,918;list:5,869,808;list-checks:5,404,967;list-c",
    "ollapse:5,967,661;list-end:5,918,710;list-filter:5,869,759;list-minus:5,820,808;list-music:5,771,857;list-ordered:5,710,918;list-plus:5,661,967;list-restart:5,967,196;list-start:5,",
    "196,967;list-todo:5,967,453;list-tree:5,453,967;list-video:5,967,710;list-x:5,918,759;loader:5,710,967;loader-2:5,820,857;loader-circle:5,771,906;locate:5,869,857;locate-fixed:5,96",
    "7,759;locate-off:5,918,808;lock:5,918,857;lock-keyhole:5,771,955;lock-keyhole-open:5,820,906;lock-open:5,967,808;log-in:5,869,906;log-out:5,820,955;lollipop:5,967,857;luggage:5,918",
    ",906;m-square:5,869,955;magnet:5,967,906;mail:6,820,0;mail-check:5,918,955;mail-minus:5,967,955;mail-open:6,771,0;mail-plus:6,0,771;mail-question:6,771,257;mail-search:6,257,771;ma",
    "il-warning:6,771,514;mail-x:6,514,771;mailbox:6,771,49;mails:6,49,771;map:6,306,771;map-pin:6,820,257;map-pin-off:6,0,820;map-pinned:6,771,306;martini:6,257,820;maximize:6,771,563;",
    "maximize-2:6,820,514;medal:6,563,771;megaphone:6,869,0;megaphone-off:6,514,820;meh:6,820,49;memory-stick:6,771,98;menu:6,49,820;menu-square:6,98,771;merge:6,0,869;message-circle:6,",
    "563,820;message-circle-code:6,869,257;message-circle-dashed:6,820,306;message-circle-heart:6,771,355;message-circle-more:6,355,771;message-circle-off:6,306,820;message-circle-plus:",
    "6,257,869;message-circle-question:6,869,514;message-circle-reply:6,820,563;message-circle-warning:6,771,612;message-circle-x:6,612,771;message-square:6,355,820;message-square-code:",
    "6,514,869;message-square-dashed:6,918,0;message-square-diff:6,869,49;message-square-dot:6,820,98;message-square-heart:6,771,147;message-square-more:6,147,771;message-square-off:6,9",
    "8,820;message-square-plus:6,49,869;message-square-quote:6,0,918;message-square-reply:6,918,257;message-square-share:6,869,306;message-square-text:6,820,355;message-square-warning:6",
    ",771,404;message-square-x:6,404,771;messages-square:6,306,869;mic:6,820,612;mic-2:6,257,918;mic-off:6,918,514;mic-vocal:6,869,563;microscope:6,771,661;microwave:6,661,771;milestone",
    ":6,612,820;milk:6,514,918;milk-off:6,563,869;minimize:6,918,49;minimize-2:6,967,0;minus:6,771,196;minus-circle:6,869,98;minus-square:6,820,147;monitor:6,404,820;monitor-check:6,196",
    ",771;monitor-dot:6,147,820;monitor-down:6,98,869;monitor-off:6,49,918;monitor-pause:6,0,967;monitor-play:6,967,257;monitor-smartphone:6,918,306;monitor-speaker:6,869,355;monitor-st",
    "op:6,820,404;monitor-up:6,771,453;monitor-x:6,453,771;moon:6,306,918;moon-star:6,355,869;more-horizontal:6,257,967;more-vertical:6,967,514;mountain:6,869,612;mountain-snow:6,918,56",
    "3;mouse:6,563,918;mouse-pointer:6,612,869;mouse-pointer-2:6,820,661;mouse-pointer-click:6,771,710;mouse-pointer-square:6,661,820;mouse-pointer-square-dashed:6,710,771;move:6,453,82",
    "0;move-3d:6,514,967;move-diagonal:6,918,98;move-diagonal-2:6,967,49;move-down:6,196,820;move-down-left:6,869,147;move-down-right:6,820,196;move-horizontal:6,147,869;move-left:6,98,",
    "918;move-right:6,49,967;move-up:6,869,404;move-up-left:6,967,306;move-up-right:6,918,355;move-vertical:6,820,453;music:6,967,563;music-2:6,404,869;music-3:6,355,918;music-4:6,306,9",
    "67;navigation:6,771,759;navigation-2:6,869,661;navigation-2-off:6,918,612;navigation-off:6,820,710;network:6,710,820;newspaper:6,661,869;nfc:6,612,918;notebook:6,869,196;notebook-p",
    "en:6,563,967;notebook-tabs:6,967,98;notebook-text:6,918,147;notepad-text:6,147,918;notepad-text-dashed:6,196,869;nut:6,967,355;nut-off:6,98,967;octagon:6,404,918;octagon-alert:6,91",
    "8,404;octagon-pause:6,869,453;octagon-x:6,453,869;option:6,355,967;orbit:6,967,612;outdent:6,918,661;package:6,918,196;package-2:6,869,710;package-check:6,820,759;package-minus:6,7",
    "71,808;package-open:6,710,869;package-plus:6,661,918;package-search:6,612,967;package-x:6,967,147;paint-bucket:6,196,918;paint-roller:6,147,967;paintbrush:6,918,453;paintbrush-2:6,",
    "967,404;palette:6,453,918;palmtree:6,404,967;panel-bottom:6,771,857;panel-bottom-close:6,967,661;panel-bottom-dashed:6,918,710;panel-bottom-inactive:6,869,759;panel-bottom-open:6,8",
    "20,808;panel-left:6,967,453;panel-left-close:6,710,918;panel-left-dashed:6,661,967;panel-left-inactive:6,967,196;panel-left-open:6,196,967;panel-right:6,820,857;panel-right-close:6",
    ",453,967;panel-right-dashed:6,967,710;panel-right-inactive:6,918,759;panel-right-open:6,869,808;panel-top:6,869,857;panel-top-close:6,771,906;panel-top-dashed:6,710,967;panel-top-i",
    "nactive:6,967,759;panel-top-open:6,918,808;panels-left-bottom:6,820,906;panels-right-bottom:6,771,955;panels-top-left:6,967,808;paperclip:6,918,857;parentheses:6,869,906;parking-ci",
    "rcle:6,967,857;parking-circle-off:6,820,955;parking-meter:6,918,906;parking-square:6,967,906;parking-square-off:6,869,955;party-popper:6,918,955;pause:7,0,771;pause-circle:6,967,95",
    "5;pause-octagon:7,771,0;paw-print:7,771,257;pc-case:7,257,771;pen:7,771,49;pen-line:7,771,514;pen-square:7,514,771;pen-tool:7,820,0;pencil:7,820,257;pencil-line:7,49,771;pencil-rul",
    "er:7,0,820;pentagon:7,771,306;percent:7,771,563;percent-circle:7,306,771;percent-diamond:7,257,820;percent-square:7,820,514;person-standing:7,563,771;phone:7,0,869;phone-call:7,514",
    ",820;phone-forwarded:7,869,0;phone-incoming:7,820,49;phone-missed:7,771,98;phone-off:7,98,771;phone-outgoing:7,49,820;pi:7,820,306;pi-square:7,869,257;piano:7,771,355;pickaxe:7,355",
    ",771;picture-in-picture:7,257,869;picture-in-picture-2:7,306,820;pie-chart:7,869,514;piggy-bank:7,820,563;pilcrow:7,612,771;pilcrow-square:7,771,612;pill:7,563,820;pin:7,918,0;pin-",
    "off:7,514,869;pipette:7,869,49;pizza:7,820,98;plane:7,98,820;plane-landing:7,771,147;plane-takeoff:7,147,771;play:7,918,257;play-circle:7,49,869;play-square:7,0,918;plug:7,404,771;",
    "plug-2:7,869,306;plug-zap:7,771,404;plug-zap-2:7,820,355;plus:7,257,918;plus-circle:7,355,820;plus-square:7,306,869;pocket:7,869,563;pocket-knife:7,918,514;podcast:7,820,612;pointe",
    "r:7,661,771;pointer-off:7,771,661;popcorn:7,612,820;popsicle:7,563,869;pound-sterling:7,514,918;power:7,820,147;power-circle:7,967,0;power-off:7,918,49;power-square:7,869,98;presen",
    "tation:7,771,196;printer:7,196,771;projector:7,147,820;proportions:7,98,869;puzzle:7,49,918;pyramid:7,0,967;qr-code:7,967,257;quote:7,918,306;rabbit:7,869,355;radar:7,820,404;radia",
    "tion:7,771,453;radical:7,453,771;radio:7,306,918;radio-receiver:7,404,820;radio-tower:7,355,869;radius:7,257,967;rail-symbol:7,967,514;rainbow:7,918,563;rat:7,869,612;ratio:7,820,6",
    "61;receipt:7,869,147;receipt-cent:7,771,710;receipt-euro:7,710,771;receipt-indian-rupee:7,661,820;receipt-japanese-yen:7,612,869;receipt-pound-sterling:7,563,918;receipt-russian-ru",
    "ble:7,514,967;receipt-swiss-franc:7,967,49;receipt-text:7,918,98;rectangle-ellipsis:7,820,196;rectangle-horizontal:7,196,820;rectangle-vertical:7,147,869;recycle:7,98,918;redo:7,91",
    "8,355;redo-2:7,49,967;redo-dot:7,967,306;refresh-ccw:7,820,453;refresh-ccw-dot:7,869,404;refresh-cw:7,404,869;refresh-cw-off:7,453,820;refrigerator:7,355,918;regex:7,306,967;remove",
    "-formatting:7,967,563;repeat:7,820,710;repeat-1:7,918,612;repeat-2:7,869,661;replace:7,710,820;replace-all:7,771,759;reply:7,612,918;reply-all:7,661,869;rewind:7,563,967;ribbon:7,9",
    "67,98;rocket:7,918,147;rocking-chair:7,869,196;roller-coaster:7,196,869;rotate-3d:7,147,918;rotate-ccw:7,967,355;rotate-ccw-square:7,98,967;rotate-cw:7,869,453;rotate-cw-square:7,9",
    "18,404;route:7,404,918;route-off:7,453,869;router:7,355,967;rows:7,820,759;rows-2:7,967,612;rows-3:7,918,661;rows-4:7,869,710;rss:7,771,808;ruler:7,710,869;russian-ruble:7,661,918;",
    "sailboat:7,612,967;salad:7,967,147;sandwich:7,918,196;satellite:7,147,967;satellite-dish:7,196,918;save:7,918,453;save-all:7,967,404;scale:7,404,967;scale-3d:7,453,918;scaling:7,96",
    "7,661;scan:7,967,196;scan-barcode:7,918,710;scan-eye:7,869,759;scan-face:7,820,808;scan-line:7,771,857;scan-search:7,710,918;scan-text:7,661,967;scatter-chart:7,196,967;school:7,45",
    "3,967;school-2:7,967,453;scissors:7,820,857;scissors-line-dashed:7,967,710;scissors-square:7,869,808;scissors-square-dashed-bottom:7,918,759;screen-share:7,710,967;screen-share-off",
    ":7,771,906;scroll:7,918,808;scroll-text:7,967,759;search:7,918,857;search-check:7,869,857;search-code:7,820,906;search-slash:7,771,955;search-x:7,967,808;send:7,967,857;send-horizo",
    "ntal:7,869,906;send-to-back:7,820,955;separator-horizontal:7,918,906;separator-vertical:7,869,955;server:8,771,0;server-cog:7,967,906;server-crash:7,918,955;server-off:7,967,955;se",
    "ttings:8,771,257;settings-2:8,0,771;shapes:8,257,771;share:8,514,771;share-2:8,771,514;sheet:8,820,0;shell:8,771,49;shield:8,869,0;shield-alert:8,49,771;shield-ban:8,0,820;shield-c",
    "heck:8,820,257;shield-ellipsis:8,771,306;shield-half:8,306,771;shield-minus:8,257,820;shield-off:8,820,514;shield-plus:8,771,563;shield-question:8,563,771;shield-x:8,514,820;ship:8",
    ",771,98;ship-wheel:8,820,49;shirt:8,98,771;shopping-bag:8,49,820;shopping-basket:8,0,869;shopping-cart:8,869,257;shovel:8,820,306;shower-head:8,771,355;shrink:8,355,771;shrub:8,306",
    ",820;shuffle:8,257,869;sigma:8,820,563;sigma-square:8,869,514;signal:8,918,0;signal-high:8,771,612;signal-low:8,612,771;signal-medium:8,563,820;signal-zero:8,514,869;signpost:8,820",
    ",98;signpost-big:8,869,49;siren:8,771,147;skip-back:8,147,771;skip-forward:8,98,820;skull:8,49,869;slack:8,0,918;slash:8,918,257;slice:8,869,306;sliders:8,404,771;sliders-horizonta",
    "l:8,820,355;sliders-vertical:8,771,404;smartphone:8,257,918;smartphone-charging:8,355,820;smartphone-nfc:8,306,869;smile:8,869,563;smile-plus:8,918,514;snail:8,820,612;snowflake:8,",
    "771,661;sofa:8,661,771;soup:8,612,820;space:8,563,869;spade:8,514,918;sparkle:8,967,0;sparkles:8,918,49;speaker:8,869,98;speech:8,820,147;spell-check:8,196,771;spell-check-2:8,771,",
    "196;spline:8,147,820;split:8,0,967;split-square-horizontal:8,98,869;split-square-vertical:8,49,918;spray-can:8,967,257;sprout:8,918,306;square:8,869,710;square-activity:8,869,355;s",
    "quare-arrow-down:8,453,771;square-arrow-down-left:8,820,404;square-arrow-down-right:8,771,453;square-arrow-left:8,404,820;square-arrow-out-down-left:8,355,869;square-arrow-out-down",
    "-right:8,306,918;square-arrow-out-up-left:8,257,967;square-arrow-out-up-right:8,967,514;square-arrow-right:8,918,563;square-arrow-up:8,771,710;square-arrow-up-left:8,869,612;square",
    "-arrow-up-right:8,820,661;square-asterisk:8,710,771;square-bottom-dashed-scissors:8,661,820;square-check:8,563,918;square-check-big:8,612,869;square-chevron-down:8,514,967;square-c",
    "hevron-left:8,967,49;square-chevron-right:8,918,98;square-chevron-up:8,869,147;square-code:8,820,196;square-dashed-bottom:8,147,869;square-dashed-bottom-code:8,196,820;square-dashe",
    "d-kanban:8,98,918;square-dashed-mouse-pointer:8,49,967;square-divide:8,967,306;square-dot:8,918,355;square-equal:8,869,404;square-function:8,820,453;square-gantt-chart:8,453,820;sq",
    "uare-kanban:8,404,869;square-library:8,355,918;square-m:8,306,967;square-menu:8,967,563;square-minus:8,918,612;square-mouse-pointer:8,869,661;square-parking:8,771,759;square-parkin",
    "g-off:8,820,710;square-pen:8,710,820;square-percent:8,661,869;square-pi:8,612,918;square-pilcrow:8,563,967;square-play:8,967,98;square-plus:8,918,147;square-power:8,869,196;square-",
    "radical:8,196,869;square-scissors:8,147,918;square-sigma:8,98,967;square-slash:8,967,355;square-split-horizontal:8,918,404;square-split-vertical:8,869,453;square-stack:8,453,869;sq",
    "uare-terminal:8,404,918;square-user:8,967,612;square-user-round:8,355,967;square-x:8,918,661;squircle:8,820,759;squirrel:8,771,808;stamp:8,710,869;star:8,967,147;star-half:8,661,91",
    "8;star-off:8,612,967;step-back:8,918,196;step-forward:8,196,918;stethoscope:8,147,967;sticker:8,967,404;sticky-note:8,918,453;stop-circle:8,453,918;store:8,404,967;stretch-horizont",
    "al:8,967,661;stretch-vertical:8,918,710;strikethrough:8,869,759;subscript:8,820,808;subtitles:8,771,857;sun:8,967,453;sun-dim:8,710,918;sun-medium:8,661,967;sun-moon:8,967,196;sun-",
    "snow:8,196,967;sunrise:8,453,967;sunset:8,967,710;superscript:8,918,759;swatch-book:8,869,808;swiss-franc:8,820,857;switch-camera:8,771,906;sword:8,710,967;swords:8,967,759;syringe",
    ":8,918,808;table:8,820,955;table-2:8,869,857;table-cells-merge:8,820,906;table-cells-split:8,771,955;table-columns-split:8,967,808;table-properties:8,918,857;table-rows-split:8,869",
    ",906;tablet:8,918,906;tablet-smartphone:8,967,857;tablets:8,869,955;tag:8,967,906;tags:8,918,955;tally-1:8,967,955;tally-2:9,771,0;tally-3:9,0,771;tally-4:9,771,257;tally-5:9,257,7",
    "71;tangent:9,771,514;target:9,514,771;telescope:9,820,0;tent:9,49,771;tent-tree:9,771,49;terminal:9,820,257;terminal-square:9,0,820;test-tube:9,257,820;test-tube-2:9,771,306;test-t",
    "ube-diagonal:9,306,771;test-tubes:9,820,514;text:9,771,98;text-cursor:9,563,771;text-cursor-input:9,771,563;text-quote:9,514,820;text-search:9,869,0;text-select:9,820,49;theater:9,",
    "98,771;thermometer:9,869,257;thermometer-snowflake:9,49,820;thermometer-sun:9,0,869;thumbs-down:9,820,306;thumbs-up:9,771,355;ticket:9,612,771;ticket-check:9,355,771;ticket-minus:9",
    ",306,820;ticket-percent:9,257,869;ticket-plus:9,869,514;ticket-slash:9,820,563;ticket-x:9,771,612;timer:9,918,0;timer-off:9,563,820;timer-reset:9,514,869;toggle-left:9,869,49;toggl",
    "e-right:9,820,98;tornado:9,771,147;torus:9,147,771;touchpad:9,49,869;touchpad-off:9,98,820;tower-control:9,0,918;toy-brick:9,918,257;tractor:9,869,306;traffic-cone:9,820,355;train-",
    "front:9,404,771;train-front-tunnel:9,771,404;train-track:9,355,820;tram-front:9,306,869;trash:9,918,514;trash-2:9,257,918;tree-deciduous:9,869,563;tree-palm:9,820,612;tree-pine:9,7",
    "71,661;trees:9,661,771;trello:9,612,820;trending-down:9,563,869;trending-up:9,514,918;triangle:9,869,98;triangle-alert:9,967,0;triangle-right:9,918,49;trophy:9,820,147;truck:9,771,",
    "196;turtle:9,196,771;tv:9,98,869;tv-2:9,147,820;twitch:9,49,918;twitter:9,0,967;type:9,967,257;umbrella:9,869,355;umbrella-off:9,918,306;underline:9,820,404;undo:9,404,820;undo-2:9",
    ",771,453;undo-dot:9,453,771;unfold-horizontal:9,355,869;unfold-vertical:9,306,918;ungroup:9,257,967;university:9,967,514;unlink:9,869,612;unlink-2:9,918,563;unlock:9,771,710;unlock",
    "-keyhole:9,820,661;unplug:9,710,771;upload:9,612,869;upload-cloud:9,661,820;usb:9,563,918;user:9,661,869;user-2:9,514,967;user-check:9,918,98;user-check-2:9,967,49;user-circle:9,82",
    "0,196;user-circle-2:9,869,147;user-cog:9,147,869;user-cog-2:9,196,820;user-minus:9,49,967;user-minus-2:9,98,918;user-plus:9,918,355;user-plus-2:9,967,306;user-round:9,967,563;user-",
    "round-check:9,869,404;user-round-cog:9,820,453;user-round-minus:9,453,820;user-round-plus:9,404,869;user-round-search:9,355,918;user-round-x:9,306,967;user-search:9,918,612;user-sq",
    "uare:9,820,710;user-square-2:9,869,661;user-x:9,710,820;user-x-2:9,771,759;users:9,967,98;users-2:9,612,918;users-round:9,563,967;utensils:9,869,196;utensils-crossed:9,918,147;util",
    "ity-pole:9,196,869;variable:9,147,918;vault:9,98,967;vegan:9,967,355;venetian-mask:9,918,404;vibrate:9,453,869;vibrate-off:9,869,453;video:9,355,967;video-off:9,404,918;videotape:9",
    ",967,612;view:9,918,661;voicemail:9,869,710;volume:9,661,918;volume-1:9,820,759;volume-2:9,771,808;volume-x:9,710,869;vote:9,612,967;wallet:9,147,967;wallet-2:9,967,147;wallet-card",
    "s:9,918,196;wallet-minimal:9,196,918;wallpaper:9,967,404;wand:9,404,967;wand-2:9,918,453;wand-sparkles:9,453,918;warehouse:9,967,661;washing-machine:9,918,710;watch:9,869,759;waves",
    ":9,820,808;waypoints:9,771,857;webcam:9,710,918;webhook:9,967,196;webhook-off:9,661,967;weight:9,196,967;wheat:9,453,967;wheat-off:9,967,453;whole-word:9,967,710;wifi:9,869,808;wif",
    "i-off:9,918,759;wind:9,820,857;wine:9,710,967;wine-off:9,771,906;workflow:9,967,759;worm:9,918,808;wrap-text:9,869,857;wrench:9,820,906;x:9,869,906;x-circle:9,771,955;x-octagon:9,9",
    "67,808;x-square:9,918,857;youtube:9,820,955;zap:9,918,906;zap-off:9,967,857;zoom-in:9,869,955;zoom-out:9,967,906"
})
local iconCache
local function iconInfo(name)
    if not iconCache then
        iconCache={}
        for key,sheet,x,y in ICON_DATA:gmatch("([%w%-]+):(%d+),(%d+),(%d+)") do
            iconCache[key]={ICON_SHEETS[tonumber(sheet)],tonumber(x),tonumber(y)}
        end
    end
    return iconCache[name]
end
local function new(class, props, parent)
    local x=Instance.new(class)
    for k,v in pairs(props) do x[k]=v end
    x.Parent=parent
    return x
end
local function round(x,n) new("UICorner",{CornerRadius=n=="full" and UDim.new(1,0) or UDim.new(0,n or 8)},x) end
local function gradient(parent,a,b,rotation,t1,t2)
    return new("UIGradient",{Color=ColorSequence.new(a,b),Rotation=rotation or 0,
        Transparency=NumberSequence.new(t1 or 0,t2 or t1 or 0)},parent)
end
local function themedGradient(parent,colors,rotation,t1,t2)
    local g=gradient(parent,C.white,C.white,rotation,t1,t2)
    return themed(g,function() local a,b=colors();g.Color=ColorSequence.new(a,b) end)
end
local function accentFill(parent,rotation)
    return themedGradient(parent,function() return C.accent,C.accent2 end,rotation or 0)
end
local function border(x,transparency) return new("UIStroke",{Color=C.line,Transparency=transparency or 0.35,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},x) end
local function glowBorder(x,strength)
    local s=new("UIStroke",{Color=C.white,Transparency=0,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},x)
    strength=strength or 0.6
    local g=new("UIGradient",{Rotation=125,
        Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,strength),NumberSequenceKeypoint.new(0.4,0.66),NumberSequenceKeypoint.new(1,0.72)})},s)
    themed(g,function()
        g.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,C.accent),ColorSequenceKeypoint.new(0.4,C.line),ColorSequenceKeypoint.new(1,C.line)})
    end)
    return s
end
local function accentStroke(x,transparency)
    local s=new("UIStroke",{Color=C.white,Transparency=transparency or 1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},x)
    accentFill(s,0)
    return s
end
local function frame(parent,size,color)
    return new("Frame",{Size=size,BackgroundColor3=color or C.card2,BorderSizePixel=0},parent)
end
local function shaded(parent,size,top,bottom,rotation)
    local f=frame(parent,size,C.white)
    gradient(f,top,bottom,rotation or 90)
    return f
end
local function cardSkin(card)
    local bg=shaded(card,UDim2.fromScale(1,1),C.card1,C.card2)
    bg.ZIndex=0;bg.Name="Skin"
    card.BackgroundTransparency=1
    return bg
end
local function text(parent,value,size)
    return new("TextLabel",{Text=value,Size=size or UDim2.new(1,0,0,22),BackgroundTransparency=1,
        TextColor3=C.text,TextSize=13,Font=F.body,
        TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},parent)
end
local function button(parent,value,size)
    local b=new("TextButton",{Text=value,Size=size,BackgroundColor3=C.row,BorderSizePixel=0,
        TextColor3=C.text2,TextSize=13,Font=F.body,AutoButtonColor=false},parent)
    round(b,8)
    return b
end
local function pad(parent,l,r,t,b)
    new("UIPadding",{PaddingLeft=UDim.new(0,l),PaddingRight=UDim.new(0,r or l),
        PaddingTop=UDim.new(0,t or l),PaddingBottom=UDim.new(0,b or t or l)},parent)
end
local function stack(parent,gap)
    return new("UIListLayout",{Padding=UDim.new(0,gap or 8),SortOrder=Enum.SortOrder.LayoutOrder},parent)
end
local function image(parent,id,size)
    local source=tostring(id)
    if not source:match("^https?://") then
        source="rbxthumb://type=Asset&id="..source.."&w=150&h=150"
    end
    return new("ImageLabel",{BackgroundTransparency=1,Size=size,
        Image=source,ScaleType=Enum.ScaleType.Fit},parent)
end
local customIcons,iconAliases,iconPacks,iconResolver={},{},{},nil
local defaultIcon="circle-help"
local iconUsers=setmetatable({},{__mode="k"})
local function normalizeSpec(v)
    if type(v)=="number" then
        return {Image="rbxthumb://type=Asset&id="..tostring(v).."&w=150&h=150"}
    end
    if type(v)=="string" then
        if v:match("^%d+$") then return {Image="rbxthumb://type=Asset&id="..v.."&w=150&h=150"} end
        if v:find("^rbx") then return {Image=v} end
        return nil
    end
    if type(v)=="table" then
        local image=v.Image
        if type(image)=="number" then image="rbxassetid://"..tostring(image) end
        if type(image)~="string" or image=="" then return nil end
        return {Image=image,RectSize=v.RectSize or v.Size or Vector2.zero,RectOffset=v.RectOffset or v.Offset or Vector2.zero}
    end
    return nil
end
local function builtinSpec(key)
    local info=iconInfo(key)
    if not info then return nil end
    return {Image="rbxassetid://"..info[1],RectSize=Vector2.new(48,48),RectOffset=Vector2.new(info[2],info[3])}
end
local function resolveIcon(name,depth)
    depth=depth or 0
    if depth>6 then return nil end
    if type(name)~="string" then return normalizeSpec(name) end
    if name:match("^%d+$") or name:find("^rbx") then return normalizeSpec(name) end
    local key=name:lower()
    if customIcons[key] then return customIcons[key] end
    if iconAliases[key] then return resolveIcon(iconAliases[key],depth+1) end
    local prefix,rest=key:match("^([%w_%-]+):(.+)$")
    if prefix and iconPacks[prefix] then return iconPacks[prefix][rest] end
    if iconResolver then
        local ok,res=pcall(iconResolver,name)
        if ok and res~=nil then
            local spec
            if type(res)=="string" and res:lower()~=key and not res:match("^%d+$") and not res:find("^rbx") then
                spec=resolveIcon(res,depth+1)
            else
                spec=normalizeSpec(res)
            end
            if spec then return spec end
        end
    end
    return builtinSpec(key)
end
local function setIcon(img,name)
    iconUsers[img]=name
    local spec=resolveIcon(name) or resolveIcon(defaultIcon) or builtinSpec("circle-help")
    img.Image=spec.Image
    img.ImageRectSize=spec.RectSize or Vector2.zero
    img.ImageRectOffset=spec.RectOffset or Vector2.zero
end
local function refreshIcons()
    for img,name in pairs(iconUsers) do
        if img.Parent then setIcon(img,name) end
    end
end
local function icon(parent,name,size,color)
    local img=new("ImageLabel",{BackgroundTransparency=1,Size=UDim2.fromOffset(size or 16,size or 16),
        ImageColor3=color or C.text,ScaleType=Enum.ScaleType.Fit},parent)
    setIcon(img,name)
    return img
end
-- Icon API: plug in your own icons or override Lucide ones, existing icons update live.
-- Library:RegisterIcon("sword", 123456789)                       asset id
-- Library:RegisterIcon("sword", "rbxassetid://123456789")         asset string
-- Library:RegisterIcon("sword", {Image=111,Offset=Vector2.new(48,0),Size=Vector2.new(48,48)})  sprite
-- Library:RegisterIcon("home", nil)                               remove your override
function Library:RegisterIcon(name,spec)
    local key=tostring(name):lower()
    if spec==nil then customIcons[key]=nil;refreshIcons();return true end
    local norm=normalizeSpec(spec)
    if not norm then warn("[Hzs-Hub] RegisterIcon '"..key.."': unsupported icon value");return false end
    customIcons[key]=norm;refreshIcons();return true
end
function Library:RegisterIcons(map)
    local ok=true
    for name,spec in pairs(map or {}) do
        local key=tostring(name):lower()
        local norm=spec~=nil and normalizeSpec(spec) or nil
        if spec~=nil and not norm then warn("[Hzs-Hub] RegisterIcons '"..key.."': unsupported icon value");ok=false
        else customIcons[key]=norm end
    end
    refreshIcons();return ok
end
-- Library:AliasIcon("farm","sprout") makes Icon="farm" show the Lucide "sprout".
function Library:AliasIcon(alias,target)
    iconAliases[tostring(alias):lower()]=target~=nil and tostring(target) or nil
    refreshIcons()
end
-- Whole set under a prefix: Library:RegisterIconPack("mine",{sword=111,shield=222}) -> Icon="mine:sword"
function Library:RegisterIconPack(prefix,icons)
    local pack={}
    for name,spec in pairs(icons or {}) do
        local norm=normalizeSpec(spec)
        if norm then pack[tostring(name):lower()]=norm end
    end
    iconPacks[tostring(prefix):lower()]=pack;refreshIcons()
end
-- Sprite sheet pack: Library:RegisterIconSheet("mine",{Image=123,TileSize=48,Icons={sword={0,0},shield={48,0}}})
function Library:RegisterIconSheet(prefix,sheet)
    local image=sheet and sheet.Image
    local tile=sheet and sheet.TileSize or 48
    local icons={}
    for name,pos in pairs(sheet and sheet.Icons or {}) do
        icons[name]={Image=image,Size=Vector2.new(tile,tile),Offset=Vector2.new(pos[1] or 0,pos[2] or 0)}
    end
    Library:RegisterIconPack(prefix,icons)
end
-- Last-chance lookup for names nothing else knew: return a name, asset id, asset string or sprite table.
function Library:SetIconResolver(fn)
    iconResolver=type(fn)=="function" and fn or nil;refreshIcons()
end
function Library:SetDefaultIcon(name) defaultIcon=tostring(name or "circle-help");refreshIcons() end
function Library:HasIcon(name) return resolveIcon(name)~=nil end
function Library:GetIcon(name)
    local spec=resolveIcon(name)
    if not spec then return nil end
    return {Image=spec.Image,RectSize=spec.RectSize,RectOffset=spec.RectOffset}
end
function Library:ListIcons(filter)
    iconInfo("")
    local seen,out={},{}
    local function add(key) if not seen[key] and (not filter or key:find(tostring(filter):lower(),1,true)) then seen[key]=true;table.insert(out,key) end end
    for key in pairs(iconCache) do add(key) end
    for key in pairs(customIcons) do add(key) end
    for key in pairs(iconAliases) do add(key) end
    for prefix,pack in pairs(iconPacks) do for key in pairs(pack) do add(prefix..":"..key) end end
    table.sort(out);return out
end
function Library:ResetIcons()
    customIcons,iconAliases,iconPacks,iconResolver={},{},{},nil
    defaultIcon="circle-help";refreshIcons()
end
local function pick(v) if type(v)=="function" then return v() end return v end
local function keycode(value)
    if typeof(value)=="EnumItem" and tostring(value):match("^Enum%.KeyCode%.") then return value end
    if type(value)=="string" then
        local ok,result=pcall(function() return Enum.KeyCode[value] end)
        if ok then return result end
    end
    return nil
end
local function encode(value)
    if typeof(value)=="EnumItem" then return value.Name end
    if typeof(value)=="Color3" then return "#"..value:ToHex():upper() end
    return value
end
local function toColor(value)
    if typeof(value)=="Color3" then return value end
    if type(value)=="string" then
        local hex=value:gsub("#","")
        if #hex==6 then
            local ok,result=pcall(Color3.fromHex,hex)
            if ok then return result end
        end
    end
    if type(value)=="table" and tonumber(value[1]) then
        return Color3.fromRGB(tonumber(value[1]),tonumber(value[2]) or 0,tonumber(value[3]) or 0)
    end
    return nil
end
local function cleanName(value)
    local name=tostring(value or ""):gsub("[^%w%-_ ]",""):gsub("^%s+",""):gsub("%s+$","")
    if name=="" then return nil end
    return name:sub(1,32)
end
local function textWidth(value,size,fontFace,limit)
    local ok,bounds=pcall(function() return TextService:GetTextSize(value,size,fontFace,Vector2.new(limit or 1000,1000)) end)
    return ok and bounds or Vector2.new(#value*size*0.5,size)
end
function Window:_connect(signal,callback)
    local c=signal:Connect(callback)
    table.insert(self.Connections,c)
    return c
end
function Window:_call(callback,...)
    if type(callback)~="function" then return end
    local args=table.pack(...)
    task.spawn(function()
        local ok,err=xpcall(function() return callback(table.unpack(args,1,args.n)) end,debug.traceback)
        if not ok then warn("[Hzs-Hub] Callback failed: "..tostring(err)) end
    end)
end
function Window:_click()
    if self.Settings.ClickSounds then self.Sound.TimePosition=0;self.Sound:Play() end
end
function Window:_tween(object,properties,duration,style)
    local t=TweenService:Create(object,TweenInfo.new(self.Settings.Animations and (duration or 0.15) or 0,
        style or Enum.EasingStyle.Quad,Enum.EasingDirection.Out),properties)
    t:Play()
    return t
end
function Window:_hover(object,base,hot,property,target)
    property=property or "BackgroundColor3"
    target=target or object
    object.MouseEnter:Connect(function()
        object:SetAttribute("Hovered",true)
        self:_tween(target,{[property]=pick(hot)},0.12)
    end)
    object.MouseLeave:Connect(function()
        object:SetAttribute("Hovered",false)
        self:_tween(target,{[property]=pick(base)},0.12)
    end)
end
function Window:_hoverGlow(object)
    local s=accentStroke(object,1)
    self:_hover(object,1,0.62,"Transparency",s)
    return s
end
function Window:_mouse()
    local m=UIS:GetMouseLocation()-GuiService:GetGuiInset()
    return m-self.Viewport.AbsolutePosition
end
function Window:_placeTip()
    if not self.Tip or not self.Tip.Visible then return end
    local m=self:_mouse()
    local size=self.Tip.AbsoluteSize
    local bounds=self.Viewport.AbsoluteSize
    local x=math.clamp(m.X+14,4,math.max(4,bounds.X-size.X-4))
    local y=m.Y+20
    if y+size.Y>bounds.Y-4 then y=m.Y-size.Y-10 end
    self.Tip.Position=UDim2.fromOffset(x,y)
end
function Window:_attachTip(object,tip,title)
    if type(tip)~="string" or tip=="" then return end
    if title and title.Parent then
        local mark=icon(title.Parent,"circle-help",13,C.dim)
        mark.AnchorPoint=Vector2.new(0,0.5)
        mark.Visible=self.Settings.Tooltips~=false
        table.insert(self.TipMarks,mark)
        local function place()
            local width=textWidth(title.Text,title.TextSize,title.Font).X
            mark.Position=UDim2.new(0,title.Position.X.Offset+width+6,title.Size.Y.Scale*0.5,title.Position.Y.Offset+title.Size.Y.Offset/2)
        end
        place()
        title:GetPropertyChangedSignal("Text"):Connect(place)
    end
    local token=0
    object.MouseEnter:Connect(function()
        token=token+1
        local mine=token
        task.delay(0.35,function()
            if mine~=token or self.Destroyed or not self.Tip or self.Settings.Tooltips==false then return end
            local width=textWidth(tip,12,F.body,236)
            self.TipText.Text=tip
            self.Tip.Size=UDim2.fromOffset(math.ceil(width.X)+22,math.ceil(width.Y)+15)
            self.Tip.Visible=true
            self.Tip.GroupTransparency=1
            self:_placeTip()
            self:_tween(self.Tip,{GroupTransparency=0},0.14)
        end)
    end)
    object.MouseLeave:Connect(function()
        token=token+1
        if self.Tip then self.Tip.Visible=false end
    end)
end
function Window:Confirm(options)
    options=type(options)=="table" and options or {Content=tostring(options or "")}
    if self.Destroyed then return false end
    if self.ActiveDialog then self.ActiveDialog(false) end
    if not self.Visible then self:SetVisible(true) end
    local danger=options.Danger==true
    local dim=new("TextButton",{Text="",AutoButtonColor=false,BackgroundColor3=C.black,BackgroundTransparency=1,
        Size=UDim2.fromScale(1,1),ZIndex=50},self.Body)
    round(dim,12)
    local card=new("CanvasGroup",{Size=UDim2.fromOffset(340,0),AutomaticSize=Enum.AutomaticSize.Y,
        AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),BackgroundColor3=C.white,
        BorderSizePixel=0,GroupTransparency=1,Active=true},dim)
    cardSkin(card);round(card,14);glowBorder(card,0.4)
    local pop=new("UIScale",{Scale=0.94},card)
    local inner=frame(card,UDim2.new(1,0,0,0));inner.BackgroundTransparency=1;inner.AutomaticSize=Enum.AutomaticSize.Y;inner.ZIndex=1
    pad(inner,18,18,16,16);stack(inner,6)
    local top=frame(inner,UDim2.new(1,0,0,34));top.BackgroundTransparency=1;top.LayoutOrder=1
    local badge=frame(top,UDim2.fromOffset(34,34),danger and C.dangerDim or C.white);round(badge,10)
    if not danger then gradient(badge,C.accentDim,C.pinkDim,135) end
    local glyph=icon(badge,options.Icon or (danger and "triangle-alert" or "circle-help"),18,danger and C.danger or C.accent)
    glyph.AnchorPoint=Vector2.new(0.5,0.5);glyph.Position=UDim2.fromScale(0.5,0.5)
    local title=text(top,tostring(options.Title or "Are you sure?"),UDim2.new(1,-46,1,0));title.Position=UDim2.fromOffset(46,0)
    title.Font=F.bold;title.TextSize=16;title.TextColor3=danger and C.danger or C.text
    local body=text(inner,tostring(options.Content or ""),UDim2.new(1,0,0,0));body.LayoutOrder=2
    body.TextSize=12;body.TextColor3=C.sub;body.TextWrapped=true;body.TextTruncate=Enum.TextTruncate.None
    body.AutomaticSize=Enum.AutomaticSize.Y;body.Visible=body.Text~=""
    local spacer=frame(inner,UDim2.new(1,0,0,6));spacer.BackgroundTransparency=1;spacer.LayoutOrder=3
    local actions=frame(inner,UDim2.new(1,0,0,32));actions.BackgroundTransparency=1;actions.LayoutOrder=4
    new("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Right,
        Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder},actions)
    local cancel=button(actions,tostring(options.CancelText or "Cancel"),UDim2.fromOffset(96,32));cancel.LayoutOrder=1
    self:_hover(cancel,C.row,C.hover)
    local confirm=button(actions,tostring(options.ConfirmText or "Confirm"),UDim2.fromOffset(112,32));confirm.LayoutOrder=2
    confirm.Font=F.bold
    if danger then
        confirm.BackgroundColor3=C.dangerDim;confirm.TextColor3=C.danger
        new("UIStroke",{Color=C.danger,Transparency=0.55,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},confirm)
        self:_hover(confirm,C.dangerDim,rgb(82,46,56))
    else
        confirm.BackgroundColor3=C.white;confirm.TextColor3=C.bg2;accentFill(confirm,0)
        self:_hover(confirm,0,0.12,"BackgroundTransparency")
    end
    local waiting
    local resolved=false
    local keys
    local function finish(value)
        if resolved then return end
        resolved=true
        if keys then keys:Disconnect() end
        if self.ActiveDialog==finish then self.ActiveDialog=nil end
        if not self.Destroyed and dim.Parent then
            self:_tween(dim,{BackgroundTransparency=1},0.16)
            self:_tween(pop,{Scale=0.96},0.16)
            local t=self:_tween(card,{GroupTransparency=1},0.16)
            if self.Settings.Animations then t.Completed:Connect(function() dim:Destroy() end) else dim:Destroy() end
        end
        if options.Callback then self:_call(options.Callback,value) end
        if waiting then task.spawn(waiting,value) end
    end
    self.ActiveDialog=finish
    cancel.Activated:Connect(function() self:_click();finish(false) end)
    confirm.Activated:Connect(function() self:_click();finish(true) end)
    dim.Activated:Connect(function() finish(false) end)
    keys=UIS.InputBegan:Connect(function(input)
        if UIS:GetFocusedTextBox() then return end
        if input.KeyCode==Enum.KeyCode.Escape then finish(false)
        elseif input.KeyCode==Enum.KeyCode.Return or input.KeyCode==Enum.KeyCode.KeypadEnter then finish(true) end
    end)
    table.insert(self.Connections,keys)
    self:_tween(dim,{BackgroundTransparency=0.45},0.18)
    self:_tween(card,{GroupTransparency=0},0.2)
    self:_tween(pop,{Scale=1},0.3,Enum.EasingStyle.Back)
    if not options.Callback then
        waiting=coroutine.running()
        return coroutine.yield()
    end
end
local TOAST_ICONS = {Info="info",Success="circle-check",Warning="triangle-alert",Error="circle-x"}
local TOAST_TYPES = {
    Success={rgb(98,206,140),rgb(110,196,186)},
    Warning={rgb(224,190,84),rgb(222,148,96)}, Error={rgb(222,118,132),rgb(196,108,160)}}
function Window:Notify(message,duration)
    if self.Destroyed then return end
    local o=type(message)=="table" and message or {Content=message,Duration=duration}
    local content=tostring(o.Content or o.Text or "")
    local title=o.Title~=nil and tostring(o.Title) or "Hzs-Hub"
    local colors=TOAST_TYPES[o.Type] or {C.accent,C.accent2}
    duration=tonumber(o.Duration or duration) or self.Settings.NotifyDuration or 3.5
    self.Status.Text=content~="" and content or title
    self.StatusDot.Size=UDim2.fromOffset(12,12)
    self:_tween(self.StatusDot,{Size=UDim2.fromOffset(6,6)},0.5,Enum.EasingStyle.Back)
    if duration<=0 or not self.Toasts then return end
    if self.Settings.Notifications==false and not o.Force then return end
    self.ActiveToasts=self.ActiveToasts or {}
    while #self.ActiveToasts>=4 do self.ActiveToasts[1]() end
    self.ToastCount=(self.ToastCount or 0)+1
    local holder=frame(self.Toasts,UDim2.fromOffset(300,0));holder.BackgroundTransparency=1
    holder.AutomaticSize=Enum.AutomaticSize.Y;holder.LayoutOrder=self.ToastCount;holder.ClipsDescendants=true
    local card=new("CanvasGroup",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,Position=UDim2.fromOffset(46,0),
        BackgroundColor3=C.white,BorderSizePixel=0,GroupTransparency=1},holder)
    cardSkin(card);round(card,12);glowBorder(card,0.55)
    local inner=frame(card,UDim2.new(1,0,0,0));inner.BackgroundTransparency=1;inner.AutomaticSize=Enum.AutomaticSize.Y;inner.ZIndex=1
    pad(inner,12,12,11,14)
    local badge=frame(inner,UDim2.fromOffset(32,32),C.white);round(badge,9)
    gradient(badge,colors[1],colors[2],135,0.78,0.84)
    new("UIStroke",{Color=colors[1],Transparency=0.6,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},badge)
    local glyph=icon(badge,o.Icon or TOAST_ICONS[o.Type] or "info",17,colors[1])
    glyph.AnchorPoint=Vector2.new(0.5,0.5);glyph.Position=UDim2.fromScale(0.5,0.5)
    local head=text(inner,title,UDim2.new(1,-70,0,17));head.Position=UDim2.fromOffset(44,-1)
    head.Font=F.bold;head.TextSize=13;head.TextColor3=C.text
    local age=text(inner,"now",UDim2.fromOffset(40,17));age.AnchorPoint=Vector2.new(1,0);age.Position=UDim2.new(1,0,0,-1)
    age.TextXAlignment=Enum.TextXAlignment.Right;age.TextSize=11;age.TextColor3=C.dim
    local closeGlyph=text(inner,"x",UDim2.fromOffset(16,17));closeGlyph.AnchorPoint=Vector2.new(1,0)
    closeGlyph.Position=UDim2.new(1,0,0,-1);closeGlyph.TextXAlignment=Enum.TextXAlignment.Right
    closeGlyph.TextSize=13;closeGlyph.TextColor3=C.muted;closeGlyph.TextTransparency=1
    local body=text(inner,content,UDim2.new(1,-46,0,0));body.Position=UDim2.fromOffset(44,18)
    body.TextSize=12;body.TextColor3=C.sub;body.TextWrapped=true;body.TextTruncate=Enum.TextTruncate.None
    body.AutomaticSize=Enum.AutomaticSize.Y;body.Visible=content~=""
    if content=="" then head.Position=UDim2.fromOffset(44,7) end
    local track=frame(card,UDim2.new(1,0,0,2),C.line);track.AnchorPoint=Vector2.new(0,1)
    track.Position=UDim2.fromScale(0,1);track.BackgroundTransparency=0.4
    local bar=frame(track,UDim2.fromScale(1,1),C.white);gradient(bar,colors[1],colors[2],0)
    local hit=new("TextButton",{Text="",BackgroundTransparency=1,Size=UDim2.fromScale(1,1),ZIndex=5},card)
    local timer=TweenService:Create(bar,TweenInfo.new(duration,Enum.EasingStyle.Linear),{Size=UDim2.fromScale(0,1)})
    local born=os.clock()
    local done=false
    local function dismiss()
        if done then return end
        done=true
        timer:Cancel()
        local list=self.ActiveToasts or {}
        local at=table.find(list,dismiss)
        if at then table.remove(list,at) end
        if self.Destroyed or not holder.Parent then return end
        self:_tween(card,{Position=UDim2.fromOffset(46,0),GroupTransparency=1},0.2)
        task.delay(self.Settings.Animations and 0.16 or 0,function()
            if not holder.Parent then return end
            local h=holder.AbsoluteSize.Y
            holder.AutomaticSize=Enum.AutomaticSize.None
            holder.Size=UDim2.fromOffset(300,h)
            local shrink=self:_tween(holder,{Size=UDim2.fromOffset(300,0)},0.18)
            shrink.Completed:Wait()
            holder:Destroy()
        end)
    end
    table.insert(self.ActiveToasts,dismiss)
    hit.MouseEnter:Connect(function()
        timer:Pause()
        self:_tween(closeGlyph,{TextTransparency=0},0.12);self:_tween(age,{TextTransparency=1},0.12)
    end)
    hit.MouseLeave:Connect(function()
        if not done then timer:Play() end
        self:_tween(closeGlyph,{TextTransparency=1},0.12);self:_tween(age,{TextTransparency=0},0.12)
    end)
    hit.Activated:Connect(function() self:_click();dismiss() end)
    timer.Completed:Connect(function(state) if state==Enum.PlaybackState.Completed then dismiss() end end)
    task.spawn(function()
        while not done and holder.Parent do
            task.wait(1)
            local t=math.floor(os.clock()-born)
            age.Text=t<5 and "now" or t.."s ago"
        end
    end)
    self:_tween(card,{GroupTransparency=0},0.2)
    self:_tween(card,{Position=UDim2.new()},0.36,Enum.EasingStyle.Back)
    timer:Play()
end
function Window:_fitScale()
    local v=self.Viewport.AbsoluteSize
    if v.X<100 or v.Y<100 then
        local camera=workspace.CurrentCamera
        local size=camera and camera.ViewportSize
        if size and size.X>=100 and size.Y>=100 then
            v=Vector2.new(size.X,size.Y-GuiService:GetGuiInset().Y)
        else
            v=Vector2.new(1280,720)
        end
    end
    return math.min(self.Settings.Scale,math.max(0.35,(v.X-24)/840),math.max(0.35,(v.Y-24)/550))
end
function Window:_scaleTo(target,duration,style)
    if self.ScaleTween then self.ScaleTween:Cancel() end
    self.ScaleTween=self:_tween(self.Scale,{Scale=target},duration,style)
    return self.ScaleTween
end
function Window:_fit()
    if self.ScaleTween then self.ScaleTween:Cancel();self.ScaleTween=nil end
    self.Scale.Scale=self:_fitScale()
    self.Root.Position=UDim2.fromScale(0.5,0.5)
end
function Window:SetVisible(visible)
    if self.Destroyed then return end
    visible=visible==true
    if self.Visible==visible and self.Root.Visible==visible then return end
    self.Visible=visible
    self.Reopen.Visible=not visible
    self:_updateBlur()
    self.VisibleToken=(self.VisibleToken or 0)+1
    local token=self.VisibleToken
    local target=self:_fitScale()
    if visible then
        self.Root.Visible=true
        self.Scale.Scale=target*0.94
        self:_scaleTo(target,0.26,Enum.EasingStyle.Back)
    elseif not self.Settings.Animations then
        self.Root.Visible=false
    else
        local t=self:_scaleTo(target*0.94,0.12)
        t.Completed:Connect(function()
            if self.VisibleToken==token and not self.Visible and not self.Destroyed then
                self.Root.Visible=false
                self.Scale.Scale=self:_fitScale()
            end
        end)
    end
end
function Window:Toggle() self:SetVisible(not self.Visible) end
function Window:_setTheme(name)
    if not THEMES[name] then return end
    self.Settings.Theme=name
    applyTheme(name)
    for _,item in ipairs(self.Tabs) do self:_paintTab(item) end
end
function Window:_updateBlur()
    local want=self.Settings.Blur==true and self.Visible and not self.Destroyed
    if want and not self.BlurEffect then
        pcall(function()
            local blur=Instance.new("BlurEffect")
            blur.Name=self.Id.."Blur";blur.Size=0
            blur.Parent=game:GetService("Lighting")
            self.BlurEffect=blur
        end)
    end
    if self.BlurEffect then
        TweenService:Create(self.BlurEffect,TweenInfo.new(self.Settings.Animations and 0.25 or 0),{Size=want and 14 or 0}):Play()
    end
end
function Window:_applyTooltips()
    local on=self.Settings.Tooltips~=false
    for _,mark in ipairs(self.TipMarks) do mark.Visible=on end
    if not on and self.Tip then self.Tip.Visible=false end
end
function Window:_applyStreamer()
    local card=self.PlayerCard
    if not card then return end
    local player=Players.LocalPlayer
    if self.Settings.Streamer then
        card.Display.Text="Streamer mode";card.Handle.Text="@hidden";card.Avatar.Image=""
    else
        card.Display.Text=player.DisplayName;card.Handle.Text="@"..player.Name
        card.Avatar.Image="rbxthumb://type=AvatarHeadShot&id="..tostring(player.UserId).."&w=48&h=48"
    end
end

function Window:SetToggleKey(value)
    local key=keycode(value)
    assert(key and key~=Enum.KeyCode.Unknown and key~=Enum.KeyCode.Escape,"Invalid toggle key")
    self.Settings.ToggleKey=key.Name
    self.Hint.Text=key.Name
    if self.KeyControl and self.KeyControl.Value~=key then self.KeyControl:Set(key,true) end
end
function Window:GetSettings()
    local copy={}
    for k,v in pairs(self.Settings) do copy[k]=v end
    return copy
end
function Window:ApplySettings(settings)
    if settings.ToggleKey then self:SetToggleKey(settings.ToggleKey) end
    if type(settings.ClickSounds)=="boolean" then self.Settings.ClickSounds=settings.ClickSounds end
    if type(settings.Animations)=="boolean" then self.Settings.Animations=settings.Animations end
    if type(settings.Volume)=="number" then self.Settings.Volume=math.clamp(settings.Volume,0,1) end
    if type(settings.Scale)=="number" then self.Settings.Scale=math.clamp(settings.Scale,0.65,0.95) end
    if type(settings.Theme)=="string" and THEMES[settings.Theme] then self:_setTheme(settings.Theme) end
    for _,key in ipairs({"Blur","Tooltips","Notifications","Streamer","OpenOnLaunch"}) do
        if type(settings[key])=="boolean" then self.Settings[key]=settings[key] end
    end
    if type(settings.NotifyDuration)=="number" then self.Settings.NotifyDuration=math.clamp(settings.NotifyDuration,1,10) end
    self:_updateBlur();self:_applyTooltips();self:_applyStreamer()
    if type(settings.Overlay)=="boolean" then
        self.Settings.Overlay=settings.Overlay
        if self.Overlay then self.Overlay.Visible=settings.Overlay end
    end
    self.Sound.Volume=self.Settings.Volume
    self:_fit()
    if self.SettingsControls then
        for name,control in pairs(self.SettingsControls) do control:Set(self.Settings[name],true) end
    end
    self:_scheduleSave()
end
function Window:_configPath() return self.ConfigFolder.."/"..self.Id..".json" end
function Window:_loadConfig()
    if not self.ConfigEnabled then return end
    local ok,data=pcall(function()
        local path=self:_configPath()
        if not isfile(path) then return nil end
        return HttpService:JSONDecode(readfile(path))
    end)
    if not ok then warn("[Hzs-Hub] Config could not be read: "..tostring(data));return end
    if type(data)~="table" then return end
    if type(data.Flags)=="table" then self.SavedFlags=data.Flags end
    if type(data.Settings)=="table" then self.SavedSettings=data.Settings end
    if type(data.Sections)=="table" then self.SectionStates=data.Sections end
end
function Window:SaveConfig()
    if not self.ConfigEnabled or self.Destroyed then return false end
    local flags={}
    for k,v in pairs(self.SavedFlags) do flags[k]=v end
    for k,v in pairs(self.Flags) do flags[k]=encode(v) end
    local ok,err=pcall(function()
        if type(isfolder)=="function" and type(makefolder)=="function" and not isfolder(self.ConfigFolder) then
            makefolder(self.ConfigFolder)
        end
        writefile(self:_configPath(),HttpService:JSONEncode({Flags=flags,Settings=self:GetSettings(),Sections=self.SectionStates}))
    end)
    if not ok then warn("[Hzs-Hub] Config could not be saved: "..tostring(err)) end
    return ok
end
function Window:_scheduleSave()
    if not self.ConfigEnabled or self.SavePending or self.Destroyed then return end
    self.SavePending=true
    task.delay(0.5,function()
        self.SavePending=false
        if not self.Destroyed then self:SaveConfig() end
    end)
end
function Window:_configDir() return self.ConfigFolder.."/"..self.Id end
function Window:_ensureFolders()
    if type(isfolder)~="function" or type(makefolder)~="function" then return end
    for _,path in ipairs({self.ConfigFolder,self:_configDir()}) do
        if not isfolder(path) then makefolder(path) end
    end
end
function Window:_readIndex()
    local ok,list=pcall(function()
        local path=self:_configDir().."/_index.json"
        if not isfile(path) then return {} end
        return HttpService:JSONDecode(readfile(path))
    end)
    return ok and type(list)=="table" and list or {}
end
function Window:_writeIndex(list)
    pcall(function()
        self:_ensureFolders()
        writefile(self:_configDir().."/_index.json",HttpService:JSONEncode(list))
    end)
end
function Window:ListConfigs()
    if not HAS_FILES then return {} end
    local names,seen={},{}
    local function add(name)
        name=cleanName(name)
        local path=name and self:_configDir().."/"..name..".json"
        if name and not seen[name] and isfile(path) and (type(delfile)=="function" or readfile(path)~="") then
            seen[name]=true;table.insert(names,name)
        end
    end
    if type(listfiles)=="function" then
        pcall(function()
            for _,path in ipairs(listfiles(self:_configDir())) do
                local name=tostring(path):match("([^/\\]+)%.json$")
                if name and name~="_index" then add(name) end
            end
        end)
    end
    for _,name in ipairs(self:_readIndex()) do add(name) end
    table.sort(names,function(a,b) return a:lower()<b:lower() end)
    return names
end
function Window:SaveConfigAs(name)
    name=cleanName(name)
    if not HAS_FILES or not name then return false,"Enter a config name" end
    local flags={}
    for k,v in pairs(self.Flags) do flags[k]=encode(v) end
    local ok,err=pcall(function()
        self:_ensureFolders()
        writefile(self:_configDir().."/"..name..".json",HttpService:JSONEncode({Flags=flags}))
    end)
    if not ok then return false,tostring(err) end
    local index=self:_readIndex()
    if not table.find(index,name) then table.insert(index,name);self:_writeIndex(index) end
    return true
end
function Window:LoadConfig(name)
    name=cleanName(name)
    if not HAS_FILES or not name then return false,"Pick a config first" end
    local ok,data=pcall(function()
        local path=self:_configDir().."/"..name..".json"
        if not isfile(path) then return nil end
        return HttpService:JSONDecode(readfile(path))
    end)
    if not ok or type(data)~="table" or type(data.Flags)~="table" then return false,"Config not found" end
    for flag,value in pairs(data.Flags) do
        local control=self.Controls[flag]
        if control then control:Set(value) end
    end
    return true
end
function Window:DeleteConfig(name)
    name=cleanName(name)
    if not HAS_FILES or not name then return false,"Pick a config first" end
    local path=self:_configDir().."/"..name..".json"
    if type(delfile)=="function" then pcall(function() if isfile(path) then delfile(path) end end)
    else pcall(function() writefile(path,"") end) end
    local index=self:_readIndex()
    local at=table.find(index,name)
    if at then table.remove(index,at);self:_writeIndex(index) end
    return true
end
function Window:GetTab(name) return self.TabByName[name] end
function Window:GetControl(flag) return self.Controls[flag] end
function Window:GetFlag(flag) return self.Flags[flag] end
function Window:Connect(signal,callback) return self:_connect(signal,callback) end
-- Live color table of the current theme (accent changes when the theme changes). For custom popups.
function Window:GetPalette() return C end
function Window:OnDestroy(callback)
    assert(type(callback)=="function","OnDestroy needs a function")
    if self.Destroyed then self:_call(callback);return end
    table.insert(self.DestroyCallbacks,callback)
end
function Tab:GetSection(name)
    for _,section in ipairs(self.Sections) do
        if section.Name==name then return section end
    end
    return nil
end
function Window:_paintTab(item)
    local on=item==self.TargetTab
    local hovered=item.Button:GetAttribute("Hovered")==true
    self:_tween(item.Button,{BackgroundTransparency=(not on and hovered) and 0.35 or 1})
    self:_tween(item.Glow,{BackgroundTransparency=on and 0 or 1})
    self:_tween(item.Indicator,{BackgroundTransparency=on and 0 or 1})
    self:_tween(item.Title,{TextColor3=on and C.text or C.muted})
    self:_tween(item.Icon,{ImageColor3=on and C.accent or C.muted})
end
function Window:SelectTab(target)
    local tab=type(target)=="string" and self.TabByName[target] or target
    assert(tab and tab.Window==self,"Unknown tab")
    self.SettingsAutoSelected=false
    self.TargetTab=tab
    for _,item in ipairs(self.Tabs) do self:_paintTab(item) end
    if self.Switching then return end
    self.Switching=true
    task.spawn(function()
        while not self.Destroyed do
            local nextTab=self.TargetTab
            if self.ActiveTab==nextTab then break end
            if self.ActiveTab then
                self.Transition=self:_tween(self.ActiveTab.Page,{GroupTransparency=1},0.10)
                self.Transition.Completed:Wait()
                if self.Destroyed then return end
                self.ActiveTab.Page.Visible=false
            end
            nextTab=self.TargetTab
            self.ActiveTab=nextTab
            self.PageTitle.Text=nextTab.Name
            nextTab.Page.GroupTransparency=1
            nextTab.Page.Position=UDim2.fromOffset(0,8)
            nextTab.Page.Visible=true
            self.Transition=self:_tween(nextTab.Page,{GroupTransparency=0,Position=UDim2.new()},0.22)
            self.Transition.Completed:Wait()
            if self.TargetTab==nextTab then break end
        end
        self.Switching=false
    end)
end
function Window:_teardown()
    if self.Destroyed then return false end
    if self.ActiveDialog then self.ActiveDialog(false) end
    if self.BlurEffect then pcall(function() self.BlurEffect:Destroy() end);self.BlurEffect=nil end
    if self.SavePending then self:SaveConfig() end
    self.Destroyed=true
    if self.Transition then self.Transition:Cancel() end
    for _,c in ipairs(self.Connections) do c:Disconnect() end
    for _,callback in ipairs(self.DestroyCallbacks) do self:_call(callback) end
    return true
end
function Window:Destroy()
    if self:_teardown() then self.Gui:Destroy() end
end
function Window:CreateTab(options,iconName)
    if type(options)=="string" then options={Name=options,Icon=iconName} end
    options=options or {}
    local name=options.Name or "New tab"
    if self.TabByName[name] then
        warn("[Hzs-Hub] Duplicate tab '"..name.."': returning the existing tab")
        return self.TabByName[name]
    end
    local tab=setmetatable({Name=name,Window=self,Sections={},ColumnCount={0,0}},Tab)
    tab.Button=button(self.Nav,"",UDim2.new(1,0,0,36))
    tab.Button.LayoutOrder=#self.Tabs+1
    tab.Button.BackgroundTransparency=1
    tab.Glow=frame(tab.Button,UDim2.fromScale(1,1),C.white);tab.Glow.BackgroundTransparency=1;round(tab.Glow,8)
    themedGradient(tab.Glow,function() return C.accentDim,C.row end,0,0,0.6)
    tab.Indicator=frame(tab.Button,UDim2.fromOffset(3,18),C.white)
    tab.Indicator.Position=UDim2.fromOffset(0,9);tab.Indicator.BackgroundTransparency=1;round(tab.Indicator,2)
    accentFill(tab.Indicator,90);tab.Indicator.Size=UDim2.fromOffset(3,14);tab.Indicator.Position=UDim2.fromOffset(0,11)
    tab.Icon=icon(tab.Button,options.Icon or self.TabIcon,18,C.muted)
    tab.Icon.Position=UDim2.fromOffset(14,9)
    tab.Title=text(tab.Button,name,UDim2.new(1,-50,1,0))
    tab.Title.Position=UDim2.fromOffset(42,0);tab.Title.TextColor3=C.muted
    self:_hover(tab.Button,1,function() return tab==self.TargetTab and 1 or 0.35 end,"BackgroundTransparency")
    tab.Page=new("CanvasGroup",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,
        GroupTransparency=1,Visible=false},self.Pages)
    local scroll=new("ScrollingFrame",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,
        BorderSizePixel=0,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,
        ScrollBarThickness=3,ScrollBarImageColor3=C.track},tab.Page)
    pad(scroll,2,9,2,10)
    tab.Scroll=scroll
    tab.Columns={}
    for i=1,2 do
        local col=frame(scroll,UDim2.new(0.5,-6,0,0))
        col.BackgroundTransparency=1
        col.AutomaticSize=Enum.AutomaticSize.Y
        col.Position=UDim2.new((i-1)*0.5,(i-1)*6,0,0)
        stack(col,12)
        tab.Columns[i]=col
    end
    table.insert(self.Tabs,tab)
    self.TabByName[name]=tab
    tab.Button.Activated:Connect(function() self:_click();self:SelectTab(tab) end)
    if not self._buildingSettings and (not self.TargetTab or self.SettingsAutoSelected) then self:SelectTab(tab) end
    return tab
end
function Tab:SetIcon(name) setIcon(self.Icon,name) end
function Tab:CreateSection(options)
    if type(options)=="string" then options={Name=options} end
    options=options or {}
    local index=options.Column=="Right" and 2 or options.Column=="Left" and 1
    if not index then index=self.ColumnCount[1]<=self.ColumnCount[2] and 1 or 2 end
    self.ColumnCount[index]=self.ColumnCount[index]+1
    local s=setmetatable({Name=options.Name or "Section",Window=self.Window,Tab=self,Count=0},Section)
    s.Frame=shaded(self.Columns[index],UDim2.new(1,0,0,0),C.card1,C.card2)
    s.Frame.AutomaticSize=Enum.AutomaticSize.Y
    s.Frame.LayoutOrder=self.ColumnCount[index]
    round(s.Frame,10);glowBorder(s.Frame);pad(s.Frame,13,12,10,13);stack(s.Frame,6)
    local head=frame(s.Frame,UDim2.new(1,0,0,24));head.BackgroundTransparency=1;head.LayoutOrder=0
    local titleX=11
    if options.Icon then
        local badge=frame(head,UDim2.fromOffset(22,22),C.white);badge.Position=UDim2.fromOffset(0,1);round(badge,7)
        themedGradient(badge,function() return C.accentDim,C.pinkDim end,135,0.1,0.25)
        local glyph=icon(badge,options.Icon,14,C.accent);glyph.AnchorPoint=Vector2.new(0.5,0.5)
        glyph.Position=UDim2.fromScale(0.5,0.5)
        themed(glyph,function() glyph.ImageColor3=C.accent end)
        titleX=30
    else
        local mark=frame(head,UDim2.fromOffset(3,13),C.white);mark.Position=UDim2.fromOffset(0,6);round(mark,2)
        accentFill(mark,90)
    end
    local title=text(head,options.Name or "Section",UDim2.new(1,-titleX-20,1,0))
    title.Position=UDim2.fromOffset(titleX,0);title.Font=F.bold;title.TextSize=13;title.TextColor3=C.text2
    local chevron=icon(head,"chevron-down",14,C.dim);chevron.AnchorPoint=Vector2.new(1,0.5)
    chevron.Position=UDim2.new(1,0,0.5,0)
    local toggle=new("TextButton",{Text="",BackgroundTransparency=1,Size=UDim2.fromScale(1,1),ZIndex=2},head)
    s.Body=frame(s.Frame,UDim2.new(1,0,0,0));s.Body.BackgroundTransparency=1
    s.Body.AutomaticSize=Enum.AutomaticSize.Y;s.Body.LayoutOrder=1;stack(s.Body,6)
    local w=self.Window
    local key=self.Name.."/"..s.Name
    function s:SetCollapsed(collapsed,quiet)
        collapsed=collapsed==true
        self.Collapsed=collapsed
        self.Body.Visible=not collapsed
        w:_tween(chevron,{Rotation=collapsed and -90 or 0},0.18)
        w.SectionStates[key]=collapsed or nil
        if not quiet then w:_scheduleSave() end
    end
    local saved=w.SectionStates[key]
    s:SetCollapsed(saved==nil and options.Collapsed==true or saved==true,true)
    toggle.MouseEnter:Connect(function() w:_tween(chevron,{ImageColor3=C.text2},0.12);w:_tween(title,{TextColor3=C.text},0.12) end)
    toggle.MouseLeave:Connect(function() w:_tween(chevron,{ImageColor3=C.dim},0.12);w:_tween(title,{TextColor3=C.text2},0.12) end)
    toggle.Activated:Connect(function() w:_click();s:SetCollapsed(not s.Collapsed) end)
    table.insert(self.Sections,s)
    return s
end
function Section:_register(name,row)
    if type(name)~="string" or name=="" then return end
    table.insert(self.Window.Searchable,{Name=name,Row=row,Section=self,Tab=self.Tab})
end
function Section:_row(name,height,skipSearch)
    self.Count=self.Count+1
    local row=frame(self.Body,UDim2.new(1,0,0,height or 34))
    row.BackgroundTransparency=1;row.LayoutOrder=self.Count+1
    local title=text(row,name,UDim2.new(1,-100,0,24))
    title.TextColor3=C.text2
    if not skipSearch then self:_register(name,row) end
    return row,title
end
function Section:_info(name)
    local row,title=self:_row(name,26,true)
    title.Size=UDim2.new(0.42,0,1,0);title.TextSize=12;title.TextColor3=C.muted
    local value=text(row,"-",UDim2.new(0.58,0,1,0));value.Position=UDim2.fromScale(0.42,0)
    value.TextXAlignment=Enum.TextXAlignment.Right;value.TextSize=12;value.Font=F.bold;value.TextColor3=C.text2
    return function(v) value.Text=tostring(v) end
end
local function control(section,options,row,initial,paint,normalize,fireInitial)
    local w=section.Window
    local c={Value=initial,Instance=row}
    local flag=options.Flag
    if flag~=nil then
        flag=tostring(flag)
        if w.Controls[flag] then
            warn("[Hzs-Hub] Duplicate flag '"..flag.."': the newer control replaces the older one")
        end
        w.Controls[flag]=c
        local saved=w.SavedFlags[flag]
        if saved~=nil then
            local value=saved
            if normalize then value=normalize(saved) end
            if value~=nil then initial=value end
        end
        w.Flags[flag]=initial
    end
    function c:Set(value,silent)
        if normalize then
            value=normalize(value)
            if value==nil then return end
        end
        self.Value=value
        if flag then w.Flags[flag]=value end
        paint(value)
        w:_scheduleSave()
        if not silent then w:_call(options.Callback,value) end
    end
    function c:Get() return self.Value end
    function c:SetVisible(visible) row.Visible=visible end
    c:Set(initial,true)
    task.defer(function()
        if w.Destroyed then return end
        if fireInitial==nil or fireInitial(c.Value) then w:_call(options.Callback,c.Value) end
    end)
    return c
end
function Section:CreateLabel(value)
    local options=type(value)=="table" and value or {Text=value}
    local row,title=self:_row("",40)
    title:Destroy()
    local l=text(row,tostring(options.Text or "Label"),UDim2.new(1,0,0,0))
    l.TextSize=12;l.TextColor3=C.sub
    l.TextWrapped=true;l.TextTruncate=Enum.TextTruncate.None;l.AutomaticSize=Enum.AutomaticSize.Y
    row.Size=UDim2.new(1,0,0,12);row.AutomaticSize=Enum.AutomaticSize.Y
    local c={Instance=row}
    function c:Set(v) l.Text=tostring(v) end
    function c:SetVisible(v) row.Visible=v end
    return c
end
function Section:CreateButton(options)
    local w=self.Window
    local row,title=self:_row("",34)
    title:Destroy()
    local b=button(row,options.Name or "Button",UDim2.new(1,0,0,32))
    local label
    if options.Icon then
        b.Text=""
        local content=frame(b,UDim2.fromScale(0,1));content.BackgroundTransparency=1
        content.AutomaticSize=Enum.AutomaticSize.X;content.AnchorPoint=Vector2.new(0.5,0.5)
        content.Position=UDim2.fromScale(0.5,0.5)
        new("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,
            Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder},content)
        local glyph=icon(content,options.Icon,15,C.sub);glyph.LayoutOrder=1
        label=text(content,options.Name or "Button",UDim2.fromScale(0,1));label.LayoutOrder=2
        label.AutomaticSize=Enum.AutomaticSize.X;label.TextColor3=C.text2
        b.MouseEnter:Connect(function() w:_tween(glyph,{ImageColor3=C.text},0.12) end)
        b.MouseLeave:Connect(function() w:_tween(glyph,{ImageColor3=C.sub},0.12) end)
    end
    w:_hover(b,C.row,C.hover)
    w:_hoverGlow(b)
    self:_register(options.Name or "Button",row)
    w:_attachTip(b,options.Tooltip)
    b.Activated:Connect(function()
        w:_click()
        b.BackgroundColor3=C.accentDim
        w:_tween(b,{BackgroundColor3=b:GetAttribute("Hovered") and C.hover or C.row},0.35)
        w:_call(options.Callback)
    end)
    return {Instance=row,Set=function(_,name) if label then label.Text=name else b.Text=name end end,
        SetVisible=function(_,v) row.Visible=v end}
end
function Section:CreateToggle(options)
    local w=self.Window
    local row,title=self:_row(options.Name or "Toggle")
    title.Size=UDim2.new(1,-50,1,0)
    local switch=frame(row,UDim2.fromOffset(38,22),C.track);switch.Position=UDim2.new(1,-38,0,6);round(switch,"full")
    local fill=frame(switch,UDim2.fromScale(1,1),C.white);fill.BackgroundTransparency=1;round(fill,"full");accentFill(fill,0)
    local knob=frame(switch,UDim2.fromOffset(16,16),C.dim);knob.Position=UDim2.fromOffset(3,3);round(knob,"full")
    local hit=new("TextButton",{Text="",BackgroundTransparency=1,Size=UDim2.fromScale(1,1),ZIndex=3},row)
    hit.MouseEnter:Connect(function() w:_tween(title,{TextColor3=C.text},0.12) end)
    hit.MouseLeave:Connect(function() w:_tween(title,{TextColor3=C.text2},0.12) end)
    local c=control(self,options,row,options.CurrentValue==true,function(value)
        w:_tween(fill,{BackgroundTransparency=value and 0 or 1},0.18)
        w:_tween(knob,{Position=UDim2.fromOffset(value and 19 or 3,3),BackgroundColor3=value and C.knob or C.dim},0.22,Enum.EasingStyle.Back)
    end,function(value) return value==true end,function(value) return value==true end)
    hit.Activated:Connect(function() w:_click();c:Set(not c.Value) end)
    w:_attachTip(hit,options.Tooltip,title)
    table.insert(w.Toggles,{Control=c,Name=options.Name or "Toggle",Tab=self.Tab})
    return c
end
local function decimals(n)
    local s=tostring(n)
    if s:find("[eE]") then s=string.format("%.6f",n):gsub("0+$","") end
    local fraction=s:match("%.(%d+)$")
    return math.min(fraction and #fraction or 0,6)
end
function Section:CreateSlider(options)
    local w=self.Window
    assert(type(options.Range)=="table","Slider needs Range = {min, max}")
    local minimum,maximum=tonumber(options.Range[1]),tonumber(options.Range[2])
    assert(minimum and maximum and maximum>minimum,"Slider range must increase")
    local step=tonumber(options.Increment) or 1
    assert(step>0,"Slider increment must be positive")
    local places=math.max(decimals(step),decimals(minimum))
    local format="%."..places.."f"
    local row,title=self:_row(options.Name or "Slider",52)
    w:_attachTip(row,options.Tooltip,title)
    local valueLabel=text(row,"",UDim2.fromOffset(80,24))
    valueLabel.Position=UDim2.new(1,-80,0,0);valueLabel.TextXAlignment=Enum.TextXAlignment.Right
    valueLabel.TextSize=12;valueLabel.TextColor3=C.sub;valueLabel.Font=F.bold
    local hit=new("TextButton",{Text="",BackgroundTransparency=1,Size=UDim2.new(1,0,0,22),
        Position=UDim2.fromOffset(0,27),AutoButtonColor=false},row)
    local track=frame(hit,UDim2.new(1,0,0,6),C.track);track.Position=UDim2.fromOffset(0,8);round(track,"full")
    local fill=frame(track,UDim2.fromScale(0,1),C.white);round(fill,"full");accentFill(fill,0)
    local knob=frame(hit,UDim2.fromOffset(14,14),C.knob);knob.AnchorPoint=Vector2.new(0.5,0.5)
    knob.Position=UDim2.fromScale(0,0.5);round(knob,"full")
    local ring=new("UIStroke",{Thickness=2,Transparency=0.35},knob)
    themed(ring,function() ring.Color=C.accent end)
    hit.MouseEnter:Connect(function()
        w:_tween(track,{BackgroundColor3=C.hover},0.12)
        w:_tween(knob,{Size=UDim2.fromOffset(17,17)},0.18,Enum.EasingStyle.Back)
        w:_tween(ring,{Thickness=3},0.12)
    end)
    hit.MouseLeave:Connect(function()
        w:_tween(track,{BackgroundColor3=C.track},0.12)
        w:_tween(knob,{Size=UDim2.fromOffset(14,14)},0.12)
        w:_tween(ring,{Thickness=2},0.12)
    end)
    local function normalize(v)
        local n=tonumber(v)
        if not n then warn("[Hzs-Hub] Slider value must be a number: "..tostring(v));return nil end
        local snapped=math.clamp(minimum+math.floor((n-minimum)/step+0.5)*step,minimum,maximum)
        return tonumber(string.format(format,snapped))
    end
    local initial=normalize(options.CurrentValue or minimum) or minimum
    local c=control(self,options,row,initial,function(v)
        local ratio=(v-minimum)/(maximum-minimum)
        fill.Size=UDim2.fromScale(ratio,1)
        knob.Position=UDim2.fromScale(ratio,0.5)
        valueLabel.Text=string.format(format,v)..(options.Suffix or "")
    end,normalize)
    local function update(input)
        local ratio=math.clamp((input.Position.X-hit.AbsolutePosition.X)/math.max(1,hit.AbsoluteSize.X),0,1)
        local value=normalize(minimum+ratio*(maximum-minimum))
        if value~=c.Value then c:Set(value) end
    end
    hit.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            w:_click();w.DragSlider={Input=input,Update=update};update(input)
        end
    end)
    return c
end
function Section:CreateDropdown(options)
    local w=self.Window
    assert(type(options.Options)=="table" and #options.Options>0,"Dropdown needs options")
    local multi=options.MultipleOptions==true
    local items={}
    for i,v in ipairs(options.Options) do items[i]=v end
    local row,title=self:_row(options.Name or "Dropdown",62)
    title.Size=UDim2.new(1,-30,0,24)
    w:_attachTip(row,options.Tooltip,title)
    local b=button(row,"",UDim2.new(1,0,0,32));b.Position=UDim2.fromOffset(0,28)
    w:_hover(b,C.row,C.hover)
    local glow=w:_hoverGlow(b)
    local valueText=text(b,"",UDim2.new(1,-38,1,0));valueText.Position=UDim2.fromOffset(11,0);valueText.TextColor3=C.text2
    local chevron=icon(b,"chevron-down",15,C.muted);chevron.AnchorPoint=Vector2.new(0.5,0.5)
    chevron.Position=UDim2.new(1,-18,0.5,0)
    local list=shaded(row,UDim2.new(1,0,0,0),C.card1,C.row);list.Position=UDim2.fromOffset(0,64)
    list.Visible=false;round(list,10);stack(list,2);pad(list,3);glowBorder(list,0.5)
    local expanded=false
    local choices={}
    local c
    local function resize()
        local h=#items*28+math.max(0,#items-1)*2+6
        list.Size=UDim2.new(1,0,0,h)
        row.Size=UDim2.new(1,0,0,expanded and 68+h or 62)
        w:_tween(chevron,{Rotation=expanded and 180 or 0,ImageColor3=expanded and C.accent or C.muted},0.18)
        w:_tween(glow,{Transparency=expanded and 0.5 or (b:GetAttribute("Hovered") and 0.62 or 1)},0.12)
    end
    local function collapse() expanded=false;list.Visible=false;resize() end
    local function normalize(v,quiet)
        if multi then
            if type(v)~="table" then v=v==nil and {} or {v} end
            local out={}
            for _,x in ipairs(v) do
                if table.find(items,x) then
                    if not table.find(out,x) then table.insert(out,x) end
                elseif not quiet then
                    warn("[Hzs-Hub] Unknown dropdown option: "..tostring(x))
                end
            end
            return out
        end
        if v~=nil and table.find(items,v) then return v end
        if not quiet then warn("[Hzs-Hub] Unknown dropdown option: "..tostring(v)) end
        return nil
    end
    local function isOn(value,current)
        if multi then return type(current)=="table" and table.find(current,value)~=nil end
        return current==value
    end
    local function paintChoices(current)
        for _,choice in ipairs(choices) do
            local on=isOn(choice.Value,current)
            choice.Button.BackgroundColor3=on and C.accentDim or C.row
            choice.Button.BackgroundTransparency=on and 0 or 1
            choice.Button.TextColor3=on and C.accent or C.text2
        end
    end
    local function paint(value)
        local label
        if multi then
            local names={}
            for i,x in ipairs(value) do names[i]=tostring(x) end
            label=#names>0 and table.concat(names,", ") or "None"
        else
            label=tostring(value)
        end
        valueText.Text=label
        paintChoices(value)
    end
    local function build()
        for _,choice in ipairs(choices) do choice.Button:Destroy() end
        table.clear(choices)
        for i,value in ipairs(items) do
            local choice=button(list,tostring(value),UDim2.new(1,0,0,28));choice.LayoutOrder=i
            choice.TextXAlignment=Enum.TextXAlignment.Left;choice.TextSize=12;round(choice,7)
            choice.BackgroundTransparency=1
            pad(choice,10,8,0,0)
            w:_hover(choice,function() return c and isOn(value,c.Value) and 0 or 1 end,0,"BackgroundTransparency")
            choice.MouseEnter:Connect(function()
                if not (c and isOn(value,c.Value)) then choice.BackgroundColor3=C.hover end
            end)
            choice.Activated:Connect(function()
                w:_click()
                if multi then
                    local nextValue=table.clone(c.Value)
                    local at=table.find(nextValue,value)
                    if at then table.remove(nextValue,at) else table.insert(nextValue,value) end
                    c:Set(nextValue)
                else
                    c:Set(value);collapse()
                end
            end)
            choices[i]={Value=value,Button=choice}
        end
    end
    build()
    local initial
    if multi then
        initial=normalize(options.CurrentOption)
    else
        initial=options.CurrentOption
        if initial==nil or not table.find(items,initial) then
            if initial~=nil then warn("[Hzs-Hub] Unknown dropdown option: "..tostring(initial)) end
            initial=items[1]
        end
    end
    c=control(self,options,row,initial,paint,normalize)
    themed(list,function() if c then paintChoices(c.Value) end end)
    function c:Refresh(newOptions,current)
        assert(type(newOptions)=="table" and #newOptions>0,"Dropdown needs options")
        local old=self.Value
        table.clear(items)
        for i,v in ipairs(newOptions) do items[i]=v end
        build()
        local value
        if current~=nil then value=normalize(current) end
        if value==nil then
            if multi then value=normalize(old,true)
            else value=table.find(items,old) and old or items[1] end
        end
        local changed
        if multi then
            changed=#value~=#old
            if not changed then
                for i=1,#value do if value[i]~=old[i] then changed=true;break end end
            end
        else
            changed=value~=old
        end
        self:Set(value,not changed)
        resize()
    end
    b.Activated:Connect(function()
        w:_click();expanded=not expanded;list.Visible=expanded
        resize()
    end)
    return c
end
function Section:CreateInput(options)
    local w=self.Window
    local numeric=options.Numeric==true
    local row,title=self:_row(options.Name or "Input",62)
    title.Size=UDim2.new(1,-30,0,24)
    w:_attachTip(row,options.Tooltip,title)
    local box=new("TextBox",{Size=UDim2.new(1,0,0,32),Position=UDim2.fromOffset(0,28),
        BackgroundColor3=C.row,BorderSizePixel=0,TextColor3=C.text,PlaceholderColor3=C.dim,
        PlaceholderText=options.PlaceholderText or "Type here...",Text="",ClearTextOnFocus=false,
        Font=F.body,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left,
        TextTruncate=Enum.TextTruncate.AtEnd},row)
    round(box,8);pad(box,11,10,0,0)
    local focus=accentStroke(box,1)
    w:_hover(box,C.row,C.hover)
    box.Focused:Connect(function() w:_tween(focus,{Transparency=0.3},0.15) end)
    local normalize,initial
    if numeric then
        normalize=function(v)
            local n=tonumber(v)
            if not n then warn("[Hzs-Hub] Input value must be a number: "..tostring(v));return nil end
            return n
        end
        initial=tonumber(options.CurrentValue) or 0
    else
        normalize=function(v) if v==nil then return "" end return tostring(v) end
        initial=normalize(options.CurrentValue)
    end
    local c=control(self,options,row,initial,function(v) box.Text=tostring(v) end,normalize,
        function(v) return v~="" end)
    box.FocusLost:Connect(function()
        w:_tween(focus,{Transparency=1},0.18)
        if numeric then
            local n=tonumber(box.Text)
            if not n then box.Text=tostring(c.Value);return end
            if n~=c.Value then c:Set(n) else box.Text=tostring(c.Value) end
        elseif box.Text~=c.Value then
            c:Set(box.Text)
        end
    end)
    return c
end
function Section:CreateKeybind(options)
    local w=self.Window
    local row,title=self:_row(options.Name or "Keybind")
    title.Size=UDim2.new(1,-100,1,0)
    w:_attachTip(row,options.Tooltip,title)
    local b=button(row,"",UDim2.fromOffset(88,26));b.Position=UDim2.new(1,-88,0,4)
    b.TextSize=12;b.Font=F.bold;round(b,7)
    w:_hover(b,C.row,C.hover)
    local glow=w:_hoverGlow(b)
    local function valid(v)
        local k=keycode(v)
        if k and k~=Enum.KeyCode.Unknown and k~=Enum.KeyCode.Escape then return k end
        return nil
    end
    local initial=valid(options.CurrentKeybind or "RightShift")
    if not initial then
        warn("[Hzs-Hub] Invalid keybind: "..tostring(options.CurrentKeybind))
        initial=Enum.KeyCode.RightShift
    end
    local c=control(self,options,row,initial,function(v)
        b.Text=v.Name;b.TextColor3=C.text2
        glow.Transparency=b:GetAttribute("Hovered") and 0.62 or 1
    end,function(v)
        local k=valid(v)
        if not k then warn("[Hzs-Hub] Invalid key: "..tostring(v)) end
        return k
    end)
    c.Button=b
    b.Activated:Connect(function()
        w:_click()
        local old=w.CaptureKey
        if old and old~=c then old:Set(old.Value,true) end
        w.CaptureKey=c;b.Text="...";b.TextColor3=C.accent;glow.Transparency=0.35
        w:Notify({Title="Rebinding",Content="Press any key. Escape cancels."})
    end)
    if type(options.OnPress)=="function" then
        w:_connect(UIS.InputBegan,function(input)
            if input.UserInputType~=Enum.UserInputType.Keyboard then return end
            if w.Destroyed or w.CaptureKey or input==w.LastCaptureInput or UIS:GetFocusedTextBox() then return end
            if input.KeyCode==c.Value then w:_call(options.OnPress,c.Value) end
        end)
    end
    return c
end
local HUE = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromHSV(0,1,1)),ColorSequenceKeypoint.new(1/6,Color3.fromHSV(1/6,1,1)),
    ColorSequenceKeypoint.new(2/6,Color3.fromHSV(2/6,1,1)),ColorSequenceKeypoint.new(3/6,Color3.fromHSV(3/6,1,1)),
    ColorSequenceKeypoint.new(4/6,Color3.fromHSV(4/6,1,1)),ColorSequenceKeypoint.new(5/6,Color3.fromHSV(5/6,1,1)),
    ColorSequenceKeypoint.new(1,Color3.fromHSV(0.999,1,1))})
function Section:CreateColorPicker(options)
    local w=self.Window
    local row,title=self:_row(options.Name or "Color",34)
    title.Size=UDim2.new(1,-70,0,34)
    w:_attachTip(row,options.Tooltip,title)
    local swatch=button(row,"",UDim2.fromOffset(46,22));swatch.Position=UDim2.new(1,-46,0,6);round(swatch,7)
    new("UIStroke",{Color=C.white,Transparency=0.82,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},swatch)
    local swatchGlow=w:_hoverGlow(swatch)
    local panel=frame(row,UDim2.new(1,0,0,146));panel.Position=UDim2.fromOffset(0,40)
    panel.BackgroundTransparency=1;panel.Visible=false
    local sv=frame(panel,UDim2.new(1,-30,0,110),C.white);round(sv,8)
    local whiteLayer=frame(sv,UDim2.fromScale(1,1),C.white);round(whiteLayer,8)
    gradient(whiteLayer,C.white,C.white,0,0,1)
    local blackLayer=frame(sv,UDim2.fromScale(1,1),C.black);round(blackLayer,8)
    gradient(blackLayer,C.black,C.black,90,1,0)
    local svCursor=frame(sv,UDim2.fromOffset(12,12),C.white);svCursor.AnchorPoint=Vector2.new(0.5,0.5)
    svCursor.ZIndex=3;round(svCursor,"full");new("UIStroke",{Color=C.white,Thickness=2},svCursor)
    local svHit=new("TextButton",{Text="",BackgroundTransparency=1,AutoButtonColor=false,Size=UDim2.fromScale(1,1),ZIndex=4},sv)
    local hue=frame(panel,UDim2.fromOffset(18,110),C.white);hue.Position=UDim2.new(1,-18,0,0);round(hue,6)
    new("UIGradient",{Rotation=90,Color=HUE},hue)
    local hueCursor=frame(hue,UDim2.new(1,6,0,4),C.knob);hueCursor.AnchorPoint=Vector2.new(0.5,0.5);hueCursor.ZIndex=3
    round(hueCursor,2);new("UIStroke",{Color=C.bg2,Thickness=1,Transparency=0.3},hueCursor)
    local hueHit=new("TextButton",{Text="",BackgroundTransparency=1,AutoButtonColor=false,Size=UDim2.fromScale(1,1),ZIndex=4},hue)
    local hexBox=new("TextBox",{Size=UDim2.fromOffset(92,26),Position=UDim2.fromOffset(0,118),BackgroundColor3=C.row,
        BorderSizePixel=0,TextColor3=C.text,Font=F.bold,TextSize=12,ClearTextOnFocus=false,Text=""},panel)
    round(hexBox,7)
    local hexFocus=accentStroke(hexBox,1)
    local rgbText=text(panel,"",UDim2.new(1,-104,0,26));rgbText.Position=UDim2.fromOffset(104,118)
    rgbText.TextSize=11;rgbText.TextColor3=C.muted
    local h,sat,val=0,1,1
    local c
    local expanded=false
    local function paint(color)
        local nh,ns,nv=color:ToHSV()
        if ns>0.001 and nv>0.001 then h=nh end
        sat,val=ns,nv
        swatch.BackgroundColor3=color
        sv.BackgroundColor3=Color3.fromHSV(h,1,1)
        svCursor.Position=UDim2.fromScale(sat,1-val);svCursor.BackgroundColor3=color
        hueCursor.Position=UDim2.fromScale(0.5,h)
        hexBox.Text="#"..color:ToHex():upper()
        rgbText.Text=string.format("R %d   G %d   B %d",math.floor(color.R*255+0.5),math.floor(color.G*255+0.5),math.floor(color.B*255+0.5))
    end
    local function normalize(v)
        local color=toColor(v)
        if not color then warn("[Hzs-Hub] Invalid color: "..tostring(v)) end
        return color
    end
    c=control(self,options,row,toColor(options.Color or options.CurrentValue) or C.accent,paint,normalize)
    local function svUpdate(input)
        local p,size=sv.AbsolutePosition,sv.AbsoluteSize
        sat=math.clamp((input.Position.X-p.X)/math.max(1,size.X),0,1)
        val=1-math.clamp((input.Position.Y-p.Y)/math.max(1,size.Y),0,1)
        c:Set(Color3.fromHSV(h,sat,val))
    end
    local function hueUpdate(input)
        local p,size=hue.AbsolutePosition,hue.AbsoluteSize
        h=math.clamp((input.Position.Y-p.Y)/math.max(1,size.Y),0,0.999)
        c:Set(Color3.fromHSV(h,sat,val))
    end
    for hit,update in pairs({[svHit]=svUpdate,[hueHit]=hueUpdate}) do
        hit.InputBegan:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
                w.DragSlider={Input=input,Update=update};update(input)
            end
        end)
    end
    hexBox.Focused:Connect(function() w:_tween(hexFocus,{Transparency=0.3},0.15) end)
    hexBox.FocusLost:Connect(function()
        w:_tween(hexFocus,{Transparency=1},0.15)
        local color=toColor(hexBox.Text)
        if color then c:Set(color) else paint(c.Value) end
    end)
    swatch.Activated:Connect(function()
        w:_click()
        expanded=not expanded
        panel.Visible=expanded
        row.Size=UDim2.new(1,0,0,expanded and 186 or 34)
        swatchGlow.Transparency=expanded and 0.45 or (swatch:GetAttribute("Hovered") and 0.62 or 1)
    end)
    return c
end
for _,method in ipairs({"CreateLabel","CreateButton","CreateToggle","CreateSlider","CreateDropdown","CreateInput","CreateKeybind","CreateColorPicker"}) do
    Tab[method]=function(self,...)
        if not self.DefaultSection then self.DefaultSection=self:CreateSection("General") end
        return self.DefaultSection[method](self.DefaultSection,...)
    end
end
local function glowSpot(parent,x,y,radius,key,transparency)
    for _,k in ipairs({1,0.82,0.65,0.48,0.3}) do
        local r=radius*k
        local spot=frame(parent,UDim2.fromOffset(r*2,r*2),C.white)
        spot.AnchorPoint=Vector2.new(0.5,0.5);spot.Position=UDim2.fromOffset(x,y)
        spot.BackgroundTransparency=transparency;round(spot,"full")
        themedGradient(spot,function() return C[key],C.accent end,45)
    end
end
local GOOD, OKAY = rgb(98,206,140), rgb(224,190,84)
local DAYS = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"}
local MONTHS = {"January","February","March","April","May","June","July","August","September","October","November","December"}
local DIRECTIONS = {"North","North-east","East","South-east","South","South-west","West","North-west"}
local PHASES = {
    {from=5,to=11,name="Morning",icon="sunrise",title="Good morning, %s",line="Fresh start. Have a great one.",a=rgb(232,178,122),b=rgb(206,132,196)},
    {from=12,to=16,name="Afternoon",icon="sun",title="Good afternoon, %s",line="Have a nice day!",a=rgb(124,170,230),b=rgb(152,134,226)},
    {from=17,to=21,name="Evening",icon="sunset",title="Good evening, %s",line="Hope your evening is a chill one.",a=rgb(206,132,196),b=rgb(152,134,226)},
    {from=22,to=4,name="Night",icon="moon",title="Still up, %s?",line="Late night grind. Don't forget to sleep.",a=rgb(120,122,222),b=rgb(152,134,226)}}
local function phaseFor(hour)
    for _,p in ipairs(PHASES) do
        if p.from<=p.to then
            if hour>=p.from and hour<=p.to then return p end
        elseif hour>=p.from or hour<=p.to then
            return p
        end
    end
    return PHASES[2]
end
local function commas(n)
    local s=tostring(math.floor(n+0.5))
    local out=s:reverse():gsub("(%d%d%d)","%1,"):reverse()
    return (out:gsub("^(-?),","%1"))
end
local function duration(seconds)
    seconds=math.max(0,math.floor(seconds))
    local h,m,s=math.floor(seconds/3600),math.floor(seconds%3600/60),seconds%60
    if h>0 then return string.format("%dh %02dm",h,m) end
    return string.format("%dm %02ds",m,s)
end
function Window:_buildDashboard()
    local player=Players.LocalPlayer
    local started=os.clock()
    local dash=self:CreateTab({Name="Dashboard",Icon="layout-dashboard"})
    dash.Button.LayoutOrder=0
    self.DashboardTab=dash
    local scroll=dash.Scroll
    local hero=shaded(scroll,UDim2.new(1,0,0,110),C.card1,C.card2);round(hero,14);glowBorder(hero,0.5)
    local tint=frame(hero,UDim2.fromScale(1,1),C.white);round(tint,14)
    local tintGradient=gradient(tint,C.accent,C.accent2,0,0.85,0.985)
    local pill=frame(hero,UDim2.fromOffset(0,20),C.white);pill.Position=UDim2.fromOffset(20,17)
    pill.AutomaticSize=Enum.AutomaticSize.X;pill.BackgroundTransparency=0.86;round(pill,"full");pad(pill,9,9,0,0)
    local pillGradient=gradient(pill,C.accent,C.accent2,0)
    new("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,
        Padding=UDim.new(0,5),SortOrder=Enum.SortOrder.LayoutOrder},pill)
    local pillIcon=icon(pill,"sun",12,C.accent);pillIcon.LayoutOrder=1
    local pillText=text(pill,"",UDim2.fromScale(0,1));pillText.AutomaticSize=Enum.AutomaticSize.X
    pillText.Font=F.bold;pillText.TextSize=11;pillText.LayoutOrder=2
    local greeting=text(hero,"",UDim2.new(1,-210,0,30));greeting.Position=UDim2.fromOffset(19,43)
    greeting.Font=F.bold;greeting.TextSize=24;greeting.TextColor3=C.white
    local greetingGradient=gradient(greeting,C.text,C.accent2,0)
    local line=text(hero,"",UDim2.new(1,-210,0,20));line.Position=UDim2.fromOffset(20,74);line.TextColor3=C.sub
    local clock=text(hero,"",UDim2.fromOffset(130,40));clock.AnchorPoint=Vector2.new(1,0)
    clock.Position=UDim2.new(1,-60,0,20);clock.TextXAlignment=Enum.TextXAlignment.Right
    clock.TextYAlignment=Enum.TextYAlignment.Bottom;clock.Font=F.bold;clock.TextSize=34
    local seconds=text(hero,"",UDim2.fromOffset(40,40));seconds.AnchorPoint=Vector2.new(1,0)
    seconds.Position=UDim2.new(1,-19,0,17);seconds.TextYAlignment=Enum.TextYAlignment.Bottom
    seconds.Font=F.bold;seconds.TextSize=16;seconds.TextColor3=C.dim
    local date=text(hero,"",UDim2.fromOffset(240,18));date.AnchorPoint=Vector2.new(1,0)
    date.Position=UDim2.new(1,-20,0,66);date.TextXAlignment=Enum.TextXAlignment.Right;date.TextSize=12;date.TextColor3=C.muted
    local grid=frame(scroll,UDim2.new(1,0,0,138));grid.BackgroundTransparency=1;grid.Position=UDim2.fromOffset(0,122)
    new("UIGridLayout",{CellSize=UDim2.new(0.25,-8,0,64),CellPadding=UDim2.fromOffset(10,10),
        SortOrder=Enum.SortOrder.LayoutOrder},grid)
    local function tile(name,order,glyphName)
        local t=shaded(grid,UDim2.new(),C.card1,C.card2);t.LayoutOrder=order;round(t,12);glowBorder(t,0.5)
        local glyph=icon(t,glyphName,13,C.muted);glyph.Position=UDim2.fromOffset(13,12)
        local l=text(t,name,UDim2.new(1,-52,0,16));l.Position=UDim2.fromOffset(31,11);l.TextSize=11;l.TextColor3=C.muted
        local v=text(t,"-",UDim2.new(1,-24,0,26));v.Position=UDim2.fromOffset(13,28);v.TextSize=19;v.Font=F.bold
        local dot=frame(t,UDim2.fromOffset(7,7),C.accent);dot.Position=UDim2.new(1,-20,0,16);round(dot,"full");dot.Visible=false
        return function(value,color)
            v.Text=tostring(value)
            if color then dot.Visible=true;dot.BackgroundColor3=color end
        end
    end
    local setPing,setFps,setPlayers,setSession=tile("Ping",1,"wifi"),tile("FPS",2,"gauge"),tile("Players",3,"users"),tile("Session",4,"timer")
    local setUptime,setAge,setRegion,setDevice=tile("Server uptime",5,"server"),tile("Account age",6,"calendar"),tile("Region",7,"globe"),tile("Device",8,"monitor")
    for _,col in ipairs(dash.Columns) do col.Position=col.Position+UDim2.fromOffset(0,272) end
    local character=dash:CreateSection({Name="Character",Column="Left",Icon="person-standing"})
    local setPosition,setSpeed,setState=character:_info("Position"),character:_info("Speed"),character:_info("State")
    local setFacing,setDistance,setHealth=character:_info("Facing"),character:_info("Distance walked"),character:_info("Health")
    local server=dash:CreateSection({Name="Server",Column="Right",Icon="server"})
    local setGame,setPlace,setJob,setType=server:_info("Game"),server:_info("Place ID"),server:_info("Server ID"),server:_info("Server type")
    setPlace(game.PlaceId)
    setJob(game.JobId~="" and game.JobId:sub(1,8).."..." or "Studio")
    if game.PrivateServerId~="" then setType(game.PrivateServerOwnerId~=0 and "Private" or "Reserved") else setType("Public") end
    if type(identifyexecutor)=="function" then
        local ok,name=pcall(identifyexecutor)
        if ok and name then server:_info("Executor")(name) end
    end
    if type(setclipboard)=="function" and game.JobId~="" then
        server:CreateButton({Name="Copy server ID",Icon="copy",Tooltip="Copies the full server ID to your clipboard.",Callback=function()
            setclipboard(game.JobId);self:Notify({Title="Copied",Content="Server ID is in your clipboard.",Type="Success"})
        end})
    end
    server:CreateButton({Name="Rejoin server",Icon="refresh-cw",Tooltip="Leaves and joins this server again.",Callback=function()
        if not self:Confirm({Title="Rejoin server?",Content="You'll leave and come back to this server. Unsaved game progress may be lost.",ConfirmText="Rejoin"}) then return end
        self:Notify({Title="Rejoining",Content="Hold on, teleporting you back in."})
        local ok,err=pcall(function()
            if #Players:GetPlayers()<=1 then TeleportService:Teleport(game.PlaceId,player)
            else TeleportService:TeleportToPlaceInstance(game.PlaceId,game.JobId,player) end
        end)
        if not ok then self:Notify({Title="Rejoin failed",Content=tostring(err),Type="Error",Duration=5}) end
    end})
    setGame("Loading...")
    task.spawn(function()
        local ok,info=pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
        if not self.Destroyed then setGame(ok and info and info.Name or "Unknown") end
    end)
    local regionCode="..."
    setRegion("...")
    task.spawn(function()
        local ok,code=pcall(function() return LocalizationService:GetCountryRegionForPlayerAsync(player) end)
        if not self.Destroyed then regionCode=ok and code or "Unknown";setRegion(self.Settings.Streamer and "Hidden" or regionCode) end
    end)
    setAge(commas(player.AccountAge).." days")
    setDevice(UIS.TouchEnabled and not UIS.KeyboardEnabled and "Mobile" or UIS.GamepadEnabled and not UIS.KeyboardEnabled and "Console" or "PC")
    local phase
    local frames,fpsClock,fps,tick=0,os.clock(),60,0
    local lastPosition,walked=nil,0
    local function refresh()
        local t=os.date("*t")
        local p=phaseFor(t.hour)
        if p~=phase then
            phase=p
            tintGradient.Color=ColorSequence.new(p.a,p.b)
            pillGradient.Color=ColorSequence.new(p.a,p.b)
            greetingGradient.Color=ColorSequence.new(C.text,p.a)
            pillText.TextColor3=p.a
            pillText.Text=p.name
            setIcon(pillIcon,p.icon);pillIcon.ImageColor3=p.a
            line.Text=p.line
        end
        greeting.Text=string.format(p.title,self.Settings.Streamer and "friend" or player.DisplayName)
        clock.Text=string.format("%02d:%02d",t.hour,t.min)
        seconds.Text=string.format(":%02d",t.sec)
        date.Text=DAYS[t.wday]..", "..t.day.." "..MONTHS[t.month].." "..t.year
        local okPing,ping=pcall(function() return player:GetNetworkPing()*1000 end)
        if okPing then setPing(math.floor(ping).." ms",ping<80 and GOOD or ping<160 and OKAY or C.danger) else setPing("-") end
        setFps(math.floor(fps+0.5),fps>=55 and GOOD or fps>=30 and OKAY or C.danger)
        setPlayers(#Players:GetPlayers().." / "..Players.MaxPlayers)
        setRegion(self.Settings.Streamer and "Hidden" or regionCode)
        setSession(duration(os.clock()-started))
        setUptime(duration(workspace.DistributedGameTime))
        setDistance(commas(walked).." studs")
        local char=player.Character
        local root=char and char:FindFirstChild("HumanoidRootPart")
        local humanoid=char and char:FindFirstChildOfClass("Humanoid")
        if root then
            local pos=root.Position
            setPosition(string.format("%.0f, %.0f, %.0f",pos.X,pos.Y,pos.Z))
            local v=root.AssemblyLinearVelocity
            local speed=Vector3.new(v.X,0,v.Z).Magnitude
            setSpeed(string.format("%.1f st/s",speed))
            if humanoid then
                local state=humanoid:GetState()
                local names={[Enum.HumanoidStateType.Jumping]="Jumping",[Enum.HumanoidStateType.Freefall]="Falling",
                    [Enum.HumanoidStateType.Swimming]="Swimming",[Enum.HumanoidStateType.Climbing]="Climbing",
                    [Enum.HumanoidStateType.Seated]="Seated",[Enum.HumanoidStateType.Dead]="Dead"}
                setState(names[state] or (speed>0.5 and (speed>humanoid.WalkSpeed+2 and "Running" or "Walking") or "Idle"))
                setHealth(string.format("%d / %d",math.floor(humanoid.Health+0.5),math.floor(humanoid.MaxHealth+0.5)))
            end
        else
            setPosition("-");setSpeed("-");setState("No character");setHealth("-")
        end
        local camera=workspace.CurrentCamera
        if camera then
            local look=camera.CFrame.LookVector
            local heading=math.deg(math.atan2(look.X,-look.Z))%360
            setFacing(DIRECTIONS[math.floor((heading+22.5)/45)%8+1])
        end
    end
    self:_connect(RunService.RenderStepped,function(dt)
        frames=frames+1
        local now=os.clock()
        if now-fpsClock>=0.5 then fps=frames/(now-fpsClock);frames=0;fpsClock=now end
        tick=tick+dt
        if tick<0.25 then return end
        tick=0
        local char=player.Character
        local root=char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local p=root.Position
            if lastPosition then
                local d=Vector3.new(p.X-lastPosition.X,0,p.Z-lastPosition.Z).Magnitude
                if d<40 then walked=walked+d end
            end
            lastPosition=p
        else
            lastPosition=nil
        end
        if self.Visible and self.ActiveTab==dash and not self.Destroyed then refresh() end
    end)
    refresh()
    return dash
end
local function hexOf(color) return "#"..color:ToHex() end
function Window:_buildOverlay()
    local player=Players.LocalPlayer

    -- Compact FPS and ping bar, using the library's themed card background.
    local overlay=shaded(self.Viewport,UDim2.fromOffset(224,18),C.card1,C.card2)
    overlay.Name="HzsHubFPSBar"
    overlay.AnchorPoint=Vector2.new(0.5,0)
    overlay.Position=UDim2.new(0.5,0,0,5)
    overlay.Active=false
    overlay.ZIndex=4
    overlay.BackgroundTransparency=0.06
    overlay.ClipsDescendants=true
    overlay.Visible=self.Settings.Overlay~=false
    round(overlay,6)
    glowBorder(overlay,0.68)
    self.Overlay=overlay

    -- H badge on the FPS bar.
    local fpsBadge=shaded(overlay,UDim2.fromOffset(14,14),C.accentDim,C.pinkDim,45)
    fpsBadge.Name="HzsHubFPSBadge"
    fpsBadge.Position=UDim2.fromOffset(3,2)
    fpsBadge.ZIndex=5
    round(fpsBadge,4)
    accentStroke(fpsBadge,0.55)
    local fpsBadgeLetter=text(fpsBadge,"H",UDim2.fromScale(1,1))
    fpsBadgeLetter.Font=F.bold
    fpsBadgeLetter.TextSize=9
    fpsBadgeLetter.TextColor3=C.white
    fpsBadgeLetter.TextXAlignment=Enum.TextXAlignment.Center
    fpsBadgeLetter.TextYAlignment=Enum.TextYAlignment.Center
    fpsBadgeLetter.ZIndex=6
    themedGradient(fpsBadgeLetter,function() return C.text,C.accent2 end,0)

    local name=text(overlay,"Hzs-Hub",UDim2.fromOffset(43,18))
    name.Position=UDim2.fromOffset(21,0)
    name.Font=F.bold
    name.TextSize=8
    name.TextColor3=C.white
    name.TextYAlignment=Enum.TextYAlignment.Center
    name.ZIndex=5
    themedGradient(name,function() return C.text,C.accent end,0)

    local stats=text(overlay,"",UDim2.new(1,-116,1,0))
    stats.Position=UDim2.fromOffset(68,0)
    stats.TextSize=8
    stats.TextColor3=C.sub
    stats.RichText=true
    stats.TextXAlignment=Enum.TextXAlignment.Center
    stats.TextYAlignment=Enum.TextYAlignment.Center
    stats.ZIndex=5

    local clock=text(overlay,"",UDim2.fromOffset(38,18))
    clock.AnchorPoint=Vector2.new(1,0)
    clock.Position=UDim2.new(1,-7,0,0)
    clock.TextXAlignment=Enum.TextXAlignment.Right
    clock.TextYAlignment=Enum.TextYAlignment.Center
    clock.TextSize=8
    clock.TextColor3=C.muted
    clock.ZIndex=5

    local function placeReopen()
        local reopen=self.Reopen
        if not reopen or not reopen.Parent then return end
        local overlayPos=overlay.AbsolutePosition-self.Viewport.AbsolutePosition
        local overlaySize=overlay.AbsoluteSize
        reopen.AnchorPoint=Vector2.new(0.5,0)
        reopen.Position=UDim2.fromOffset(
            overlayPos.X+overlaySize.X/2,
            overlayPos.Y+overlaySize.Y+3
        )
    end
    self:_connect(overlay:GetPropertyChangedSignal("AbsoluteSize"),placeReopen)
    self:_connect(overlay:GetPropertyChangedSignal("AbsolutePosition"),placeReopen)
    self:_connect(self.Viewport:GetPropertyChangedSignal("AbsoluteSize"),placeReopen)
    task.defer(placeReopen)

    local function update(fps)
        if not overlay.Visible then return end
        local t=os.date("*t")
        clock.Text=string.format("%02d:%02d",t.hour,t.min)
        local good,okay,bad=hexOf(rgb(98,206,140)),hexOf(rgb(224,190,84)),hexOf(C.danger)
        local fpsColor=fps>=55 and good or fps>=30 and okay or bad
        local okPing,ping=pcall(function() return player:GetNetworkPing()*1000 end)
        local pingValue="-"
        local pingColor=hexOf(C.dim)
        if okPing then
            pingValue=tostring(math.floor(ping+0.5))
            pingColor=ping<80 and good or ping<160 and okay or bad
        end
        stats.Text=string.format(
            '<font color="%s">%d FPS</font>  <font color="%s">·</font>  <font color="%s">%s ms</font>',
            fpsColor,math.floor(fps+0.5),hexOf(C.dim),pingColor,pingValue
        )
    end

    local frames,fpsClock,fps,elapsed=0,os.clock(),60,1
    self:_connect(RunService.RenderStepped,function(dt)
        frames=frames+1
        local now=os.clock()
        if now-fpsClock>=0.5 then
            fps=frames/(now-fpsClock)
            frames=0
            fpsClock=now
            self.FPS=fps
        end
        elapsed=elapsed+dt
        if elapsed>=0.5 then
            elapsed=0
            update(fps)
        end
    end)
end
local function guiParent(requested,playerGui)
    if typeof(requested)=="Instance" then return requested end
    if type(gethui)=="function" then
        local ok,container=pcall(gethui)
        if ok and typeof(container)=="Instance" then return container end
    end
    local ok,core=pcall(function()
        local service=game:GetService("CoreGui")
        local probe=Instance.new("Folder")
        probe.Parent=service
        probe:Destroy()
        return service
    end)
    if ok and core then return core end
    return playerGui
end
function Library:CreateWindow(options)
    options=options or {}
    local player=Players.LocalPlayer
    assert(player,"Hzs-Hub requires a Roblox client context")
    local playerGui=player:WaitForChild("PlayerGui")
    local guiId=options.Id or "Hzs-Hub"
    assert(type(guiId)=="string" and #guiId>0,"Window Id must be a non-empty string")
    local parent=guiParent(options.Parent,playerGui)
    for _,container in ipairs({parent,playerGui}) do
        local old=container:FindFirstChild(guiId)
        if old then old:Destroy() end
    end
    local w=setmetatable({Connections={},DestroyCallbacks={},Tabs={},TabByName={},Flags={},Controls={},
        SavedFlags={},Searchable={},Toggles={},SectionStates={},TipMarks={},Visible=true,Id=guiId,
        ConfigEnabled=HAS_FILES and options.SaveConfig~=false,
        ConfigFolder=tostring(options.ConfigFolder or "Hzs-Hub"),
        TabIcon=options.TabIcon or "layout-grid",
        Settings={ToggleKey="RightShift",ClickSounds=true,Volume=0.45,Animations=true,Scale=0.88,Theme="Violet",Overlay=true,
            Blur=false,Tooltips=true,Notifications=true,NotifyDuration=3.5,Streamer=false,OpenOnLaunch=true}},Window)
    w.LogoId=options.Logo or LOGO
    w:_loadConfig()
    w.Gui=new("ScreenGui",{Name=guiId,ResetOnSpawn=false,DisplayOrder=30,Enabled=true,IgnoreGuiInset=true,
        ZIndexBehavior=Enum.ZIndexBehavior.Sibling},nil)
    if type(syn)=="table" and type(syn.protect_gui)=="function" then pcall(syn.protect_gui,w.Gui) end
    w.Gui.Parent=parent
    w.Viewport=frame(w.Gui,UDim2.fromScale(1,1));w.Viewport.BackgroundTransparency=1
    w.Root=frame(w.Viewport,UDim2.fromOffset(840,550));w.Root.BackgroundTransparency=1
    w.Root.AnchorPoint=Vector2.new(0.5,0.5);w.Root.Position=UDim2.fromScale(0.5,0.5)
    w.Scale=new("UIScale",{Scale=1},w.Root)
    for _,layer in ipairs({{20,12,0.93},{11,8,0.87},{4,4,0.78}}) do
        local s=frame(w.Root,UDim2.new(1,layer[1]*2,1,layer[1]*2),C.black)
        s.Position=UDim2.fromOffset(-layer[1],-layer[1]+layer[2]);s.BackgroundTransparency=layer[3]
        round(s,12+layer[1])
    end
    for _,layer in ipairs({{16,0.96},{8,0.93}}) do
        local aura=frame(w.Root,UDim2.new(1,layer[1]*2,1,layer[1]*2),C.white)
        aura.Position=UDim2.fromOffset(-layer[1],-layer[1]);aura.BackgroundTransparency=layer[2]
        round(aura,12+layer[1]);themedGradient(aura,function() return C.accent,C.accent2 end,30)
    end
    local body=shaded(w.Root,UDim2.fromScale(1,1),C.bg1,C.bg2,115)
    w.Body=body
    round(body,12);glowBorder(body,0.5)
    w.Sound=new("Sound",{SoundId="rbxassetid://"..tostring(options.ClickSound or CLICK_SOUND),Volume=0.45},w.Gui)
    w.Toasts=frame(w.Viewport,UDim2.fromOffset(300,420))
    w.Toasts.BackgroundTransparency=1;w.Toasts.AnchorPoint=Vector2.new(1,1)
    w.Toasts.Position=UDim2.new(1,-16,1,-16);w.Toasts.ZIndex=5
    new("UIListLayout",{Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder,
        VerticalAlignment=Enum.VerticalAlignment.Bottom,HorizontalAlignment=Enum.HorizontalAlignment.Right},w.Toasts)
    w.Tip=new("CanvasGroup",{Size=UDim2.fromOffset(100,30),BackgroundColor3=C.white,BorderSizePixel=0,Visible=false,
        ZIndex=60,GroupTransparency=1},w.Viewport)
    cardSkin(w.Tip);round(w.Tip,8);glowBorder(w.Tip,0.5)
    w.TipText=text(w.Tip,"",UDim2.new(1,-22,1,-15));w.TipText.Position=UDim2.fromOffset(11,7)
    w.TipText.TextSize=12;w.TipText.TextColor3=C.text;w.TipText.TextWrapped=true;w.TipText.ZIndex=2
    w.TipText.TextTruncate=Enum.TextTruncate.None;w.TipText.TextYAlignment=Enum.TextYAlignment.Top
    local backdrop=frame(body,UDim2.fromScale(1,1));backdrop.BackgroundTransparency=1;backdrop.ClipsDescendants=true
    glowSpot(backdrop,610,-24,210,"accent",0.984)
    glowSpot(backdrop,470,600,170,"accent2",0.99)
    local side=shaded(body,UDim2.new(0,196,1,0),C.side1,C.side2);round(side,12)
    local seam=shaded(body,UDim2.new(0,14,1,0),C.side1,C.side2);seam.Position=UDim2.fromOffset(182,0)
    local divider=frame(body,UDim2.new(0,1,1,0),C.line);divider.Position=UDim2.fromOffset(196,0)
    -- Clean sidebar header: no logo tile, H mark, image, badge or circular icon.
    local brand=text(side,"Hzs-Hub",UDim2.fromOffset(164,22))
    brand.Position=UDim2.fromOffset(16,23);brand.TextSize=16;brand.Font=F.bold;brand.TextColor3=C.white
    themedGradient(brand,function() return C.text,C.accent end,0)
    local subtitle=text(side,"workspace",UDim2.fromOffset(164,16))
    subtitle.Position=UDim2.fromOffset(16,44);subtitle.TextSize=11;subtitle.TextColor3=C.muted
    local sideRule=frame(side,UDim2.fromOffset(164,1),C.white);sideRule.Position=UDim2.fromOffset(16,71)
    themedGradient(sideRule,function() return C.accent,C.line end,0,0.6,0.45)
    w.Nav=new("ScrollingFrame",{Position=UDim2.fromOffset(10,83),Size=UDim2.new(1,-20,1,-149),
        BackgroundTransparency=1,BorderSizePixel=0,CanvasSize=UDim2.new(),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=2,ScrollBarImageColor3=C.track},side)
    stack(w.Nav,4)
    local chip=shaded(side,UDim2.new(1,-20,0,46),C.card1,C.card2);chip.Position=UDim2.new(0,10,1,-56)
    round(chip,11);glowBorder(chip,0.5)
    local avatar=new("ImageLabel",{Size=UDim2.fromOffset(30,30),Position=UDim2.fromOffset(8,8),
        BackgroundColor3=C.row,BorderSizePixel=0,
        Image="rbxthumb://type=AvatarHeadShot&id="..tostring(player.UserId).."&w=48&h=48"},chip)
    round(avatar,"full");accentStroke(avatar,0.55)
    local online=frame(chip,UDim2.fromOffset(8,8),C.online);online.Position=UDim2.fromOffset(31,31);round(online,"full")
    new("UIStroke",{Color=C.card2,Thickness=2},online)
    local display=text(chip,player.DisplayName,UDim2.new(1,-56,0,16));display.Position=UDim2.fromOffset(47,7)
    display.Font=F.bold;display.TextSize=12
    local handle=text(chip,"@"..player.Name,UDim2.new(1,-56,0,14));handle.Position=UDim2.fromOffset(47,24)
    handle.TextSize=11;handle.TextColor3=C.muted
    w.PlayerCard={Display=display,Handle=handle,Avatar=avatar}
    local header=frame(body,UDim2.new(1,-210,0,56),C.bg1);header.Position=UDim2.fromOffset(210,0)
    header.BackgroundTransparency=1;header.Active=true
    w.PageTitle=text(header,"",UDim2.new(1,-290,1,0));w.PageTitle.Position=UDim2.fromOffset(4,1)
    w.PageTitle.TextSize=18;w.PageTitle.Font=F.bold;w.PageTitle.TextColor3=C.text
    w.PageTitle.Active=false
    local minimize=button(header,"",UDim2.fromOffset(26,26));minimize.Position=UDim2.new(1,-62,0,15)
    minimize.BackgroundTransparency=1
    local minimizeGlyph=icon(minimize,"minus",15,C.muted);minimizeGlyph.AnchorPoint=Vector2.new(0.5,0.5)
    minimizeGlyph.Position=UDim2.fromScale(0.5,0.5)
    local close=button(header,"",UDim2.fromOffset(26,26));close.Position=UDim2.new(1,-30,0,15)
    close.BackgroundColor3=C.dangerDim;close.BackgroundTransparency=1
    local closeGlyph=icon(close,"x",15,C.muted);closeGlyph.AnchorPoint=Vector2.new(0.5,0.5)
    closeGlyph.Position=UDim2.fromScale(0.5,0.5)
    w:_hover(minimize,1,0,"BackgroundTransparency");w:_hover(minimize,C.muted,C.text,"ImageColor3",minimizeGlyph)
    w:_hover(close,1,0,"BackgroundTransparency");w:_hover(close,C.muted,C.danger,"ImageColor3",closeGlyph)
    local searchBox=new("TextBox",{Size=UDim2.fromOffset(196,28),Position=UDim2.new(1,-268,0,14),BackgroundColor3=C.row,
        BackgroundTransparency=0.25,BorderSizePixel=0,Text="",PlaceholderText="Search features",PlaceholderColor3=C.dim,
        TextColor3=C.text,Font=F.body,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,
        TextTruncate=Enum.TextTruncate.AtEnd},header)
    round(searchBox,8);pad(searchBox,28,10,0,0)
    w.SearchBox=searchBox
    local searchFocus=accentStroke(searchBox,1)
    w:_hover(searchBox,0.25,0.05,"BackgroundTransparency")
    local lens=icon(header,"search",14,C.muted);lens.Position=UDim2.new(1,-259,0,21)
    searchBox.Focused:Connect(function() w:_tween(lens,{ImageColor3=C.accent},0.15) end)
    searchBox.FocusLost:Connect(function() w:_tween(lens,{ImageColor3=C.muted},0.15) end)
    local rule=frame(body,UDim2.new(1,-228,0,1),C.white);rule.Position=UDim2.fromOffset(214,56)
    themedGradient(rule,function() return C.accent,C.line end,0,0.55,0.4)
    w.Pages=frame(body,UDim2.new(1,-228,1,-104));w.Pages.Position=UDim2.fromOffset(214,68)
    w.Pages.BackgroundTransparency=1
    local results=shaded(body,UDim2.fromOffset(268,0),C.card1,C.card2);results.AnchorPoint=Vector2.new(1,0)
    results.Position=UDim2.fromOffset(768,46);results.AutomaticSize=Enum.AutomaticSize.Y;results.Visible=false
    results.ZIndex=40;round(results,10);glowBorder(results,0.4);pad(results,4);stack(results,2)
    local resultItems,matches,resultsHovered={}, {},false
    results.MouseEnter:Connect(function() resultsHovered=true end)
    results.MouseLeave:Connect(function()
        resultsHovered=false
        if not searchBox:IsFocused() then results.Visible=false end
    end)
    local function goTo(entry)
        searchBox.Text="";results.Visible=false
        w:SelectTab(entry.Tab)
        if entry.Section.Collapsed then entry.Section:SetCollapsed(false) end
        task.spawn(function()
            local started=os.clock()
            while w.ActiveTab~=entry.Tab and os.clock()-started<1 do task.wait() end
            task.wait(0.05)
            if w.Destroyed or not entry.Row.Parent then return end
            local scroll=entry.Tab.Scroll
            local scale=math.max(w.Scale.Scale,0.01)
            local offset=(entry.Row.AbsolutePosition.Y-scroll.AbsolutePosition.Y)/scale+scroll.CanvasPosition.Y-24
            w:_tween(scroll,{CanvasPosition=Vector2.new(0,math.max(0,offset))},0.3)
            if not entry.Row:FindFirstChild("SearchCorner") then
                new("UICorner",{Name="SearchCorner",CornerRadius=UDim.new(0,7)},entry.Row)
            end
            entry.Row.BackgroundColor3=C.accentDim;entry.Row.BackgroundTransparency=0.1
            TweenService:Create(entry.Row,TweenInfo.new(1.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{BackgroundTransparency=1}):Play()
        end)
    end
    local function refreshResults()
        local query=searchBox.Text:lower():gsub("^%s+",""):gsub("%s+$","")
        for _,item in ipairs(resultItems) do item:Destroy() end
        table.clear(resultItems);table.clear(matches)
        if query=="" then results.Visible=false;return end
        local later={}
        for _,entry in ipairs(w.Searchable) do
            if entry.Row.Parent then
                local at=entry.Name:lower():find(query,1,true)
                if at==1 then table.insert(matches,entry) elseif at then table.insert(later,entry) end
            end
        end
        for _,entry in ipairs(later) do table.insert(matches,entry) end
        if #matches==0 then
            local empty=text(results,"Nothing matches \""..searchBox.Text.."\"",UDim2.new(1,0,0,32))
            pad(empty,10,10,0,0);empty.TextSize=12;empty.TextColor3=C.muted
            table.insert(resultItems,empty)
        end
        for i=1,math.min(6,#matches) do
            local entry=matches[i]
            local item=button(results,"",UDim2.new(1,0,0,38));item.LayoutOrder=i;round(item,7)
            item.BackgroundColor3=C.hover;item.BackgroundTransparency=i==1 and 0.35 or 1
            local name=text(item,entry.Name,UDim2.new(1,-20,0,16));name.Position=UDim2.fromOffset(10,4)
            name.Font=F.bold;name.TextSize=12;name.TextColor3=C.text
            local path=text(item,entry.Tab.Name.."  /  "..entry.Section.Name,UDim2.new(1,-20,0,14))
            path.Position=UDim2.fromOffset(10,20);path.TextSize=11;path.TextColor3=C.muted
            w:_hover(item,i==1 and 0.35 or 1,0,"BackgroundTransparency")
            item.Activated:Connect(function() w:_click();goTo(entry) end)
            table.insert(resultItems,item)
        end
        if #matches>6 then
            local more=text(results,"+"..(#matches-6).." more, keep typing",UDim2.new(1,0,0,22));more.LayoutOrder=99
            pad(more,10,10,0,0);more.TextSize=11;more.TextColor3=C.dim
            table.insert(resultItems,more)
        end
        results.Visible=true
    end
    searchBox:GetPropertyChangedSignal("Text"):Connect(refreshResults)
    searchBox.Focused:Connect(function() w:_tween(searchFocus,{Transparency=0.3},0.15);refreshResults() end)
    searchBox.FocusLost:Connect(function(enter)
        w:_tween(searchFocus,{Transparency=1},0.15)
        if enter and matches[1] then goTo(matches[1]);return end
        task.delay(0.25,function()
            if not searchBox:IsFocused() and not resultsHovered then results.Visible=false end
        end)
    end)
    w.StatusDot=frame(body,UDim2.fromOffset(6,6),C.white);w.StatusDot.AnchorPoint=Vector2.new(0.5,0.5)
    w.StatusDot.Position=UDim2.fromOffset(219,533);round(w.StatusDot,"full");accentFill(w.StatusDot,45)
    w.Status=text(body,"Ready",UDim2.new(0.5,-30,0,24))
    w.Status.Position=UDim2.fromOffset(230,521);w.Status.TextSize=11;w.Status.TextColor3=C.muted
    local toggleHint=text(body,"to toggle",UDim2.fromOffset(52,24));toggleHint.Position=UDim2.new(1,-66,0,521)
    toggleHint.TextXAlignment=Enum.TextXAlignment.Right;toggleHint.TextSize=11;toggleHint.TextColor3=C.dim
    local keycap=frame(body,UDim2.fromOffset(0,18),C.row);keycap.AnchorPoint=Vector2.new(1,0)
    keycap.Position=UDim2.new(1,-71,0,524);keycap.AutomaticSize=Enum.AutomaticSize.X;round(keycap,5);border(keycap,0.2)
    pad(keycap,6,6,0,0)
    w.Hint=text(keycap,"",UDim2.fromScale(0,1));w.Hint.AutomaticSize=Enum.AutomaticSize.X
    w.Hint.TextSize=11;w.Hint.Font=F.bold;w.Hint.TextColor3=C.sub
    -- Reopen button mirrors the FPS bar, in a smaller card with the same H badge.
    w.Reopen=new("TextButton",{
        Name="HzsHubReopenButton",
        Text="",
        Size=UDim2.fromOffset(132,20),
        BackgroundColor3=C.white,
        BackgroundTransparency=0.06,
        BorderSizePixel=0,
        AutoButtonColor=false,
        Selectable=false,
        ZIndex=5,
        ClipsDescendants=true,
    },w.Viewport)
    gradient(w.Reopen,C.card1,C.card2,115)
    round(w.Reopen,6)
    glowBorder(w.Reopen,0.68)

    local reopenBadge=shaded(w.Reopen,UDim2.fromOffset(14,14),C.accentDim,C.pinkDim,45)
    reopenBadge.Name="HzsHubReopenBadge"
    reopenBadge.Position=UDim2.fromOffset(4,3)
    reopenBadge.ZIndex=6
    round(reopenBadge,4)
    accentStroke(reopenBadge,0.55)
    local reopenLetter=text(reopenBadge,"H",UDim2.fromScale(1,1))
    reopenLetter.Font=F.bold
    reopenLetter.TextSize=9
    reopenLetter.TextColor3=C.white
    reopenLetter.TextXAlignment=Enum.TextXAlignment.Center
    reopenLetter.TextYAlignment=Enum.TextYAlignment.Center
    reopenLetter.ZIndex=7
    themedGradient(reopenLetter,function() return C.text,C.accent2 end,0)

    local reopenLabel=text(w.Reopen,"Hzs-Hub",UDim2.new(1,-43,1,0))
    reopenLabel.Position=UDim2.fromOffset(23,0)
    reopenLabel.Font=F.bold
    reopenLabel.TextSize=9
    reopenLabel.TextColor3=C.white
    reopenLabel.TextYAlignment=Enum.TextYAlignment.Center
    reopenLabel.ZIndex=6
    themedGradient(reopenLabel,function() return C.text,C.accent end,0)

    local reopenArrow=icon(w.Reopen,"chevron-up",10,C.accent)
    reopenArrow.AnchorPoint=Vector2.new(1,0.5)
    reopenArrow.Position=UDim2.new(1,-7,0.5,0)
    reopenArrow.ZIndex=7

    w.Reopen.AnchorPoint=Vector2.new(0.5,0)
    w.Reopen.Position=UDim2.new(0.5,0,0,30)
    w.Reopen.MouseEnter:Connect(function()
        TweenService:Create(w.Reopen,TweenInfo.new(0.14),{BackgroundTransparency=0}):Play()
    end)
    w.Reopen.MouseLeave:Connect(function()
        TweenService:Create(w.Reopen,TweenInfo.new(0.14),{BackgroundTransparency=0.06}):Play()
    end)
    w.Reopen.Visible=false
    close.Activated:Connect(function()
        w:_click()
        w:Confirm({Title="Close Hzs-Hub?",ConfirmText="Close",Danger=true,
            Content="The menu and everything running from it stops until you run the script again. Use - if you just want to hide it.",
            Callback=function(confirmed) if confirmed then w:Destroy() end end})
    end)
    minimize.Activated:Connect(function() w:_click();w:SetVisible(false) end)
    w.Reopen.Activated:Connect(function() w:_click();w:SetVisible(true) end)
    w:_connect(w.Viewport:GetPropertyChangedSignal("AbsoluteSize"),function() w:_fit() end)
    w:_connect(UIS.InputBegan,function(input)
        if input.UserInputType~=Enum.UserInputType.Keyboard then return end
        if UIS:GetFocusedTextBox() then return end
        if w.CaptureKey then
            local c=w.CaptureKey
            if input.KeyCode==Enum.KeyCode.Unknown then return end
            w.CaptureKey=nil
            w.LastCaptureInput=input
            if input.KeyCode==Enum.KeyCode.Escape then c:Set(c.Value,true);w:Notify({Title="Rebind cancelled",Content="Kept "..c.Value.Name..".",Type="Warning"})
            else c:Set(input.KeyCode);w:Notify({Title="Key updated",Content="Now bound to "..input.KeyCode.Name..".",Type="Success"}) end
            return
        end
        if input.KeyCode==Enum.KeyCode.F and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl)) then
            if not w.Visible then w:SetVisible(true) end
            task.defer(function() searchBox:CaptureFocus() end)
            return
        end
        if input.KeyCode.Name==w.Settings.ToggleKey then w:_click();w:Toggle() end
    end)
    w:_connect(header.InputBegan,function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            w.DragWindow={Input=input,Start=input.Position,Center=w.Root.AbsolutePosition+w.Root.AbsoluteSize/2}
        end
    end)
    w:_connect(UIS.InputChanged,function(input)
        if input.UserInputType==Enum.UserInputType.MouseMovement then w:_placeTip() end
        local slider=w.DragSlider
        if slider and w.Visible then
            local touch=slider.Input.UserInputType==Enum.UserInputType.Touch
            if (touch and input==slider.Input) or (not touch and input.UserInputType==Enum.UserInputType.MouseMovement) then slider.Update(input) end
        end
        local drag=w.DragWindow
        if not drag or not w.Visible then return end
        local touch=drag.Input.UserInputType==Enum.UserInputType.Touch
        if (touch and input~=drag.Input) or (not touch and input.UserInputType~=Enum.UserInputType.MouseMovement) then return end
        local delta=input.Position-drag.Start
        local half=w.Root.AbsoluteSize/2;local origin=w.Viewport.AbsolutePosition;local bounds=w.Viewport.AbsoluteSize
        local x=math.clamp(drag.Center.X+delta.X-origin.X,half.X,math.max(half.X,bounds.X-half.X))
        local y=math.clamp(drag.Center.Y+delta.Y-origin.Y,half.Y,math.max(half.Y,bounds.Y-half.Y))
        w.Root.Position=UDim2.fromOffset(x,y)
    end)
    w:_connect(UIS.InputEnded,function(input)
        if w.DragSlider and input==w.DragSlider.Input then w.DragSlider=nil end
        if w.DragWindow and input==w.DragWindow.Input then w.DragWindow=nil end
    end)
    w.Gui.Destroying:Connect(function() w:_teardown() end)
    w:SetToggleKey("RightShift");w:_fit()
    w._buildingSettings=true
    local settings=w:CreateTab({Name="Settings",Icon="settings"})
    w._buildingSettings=nil
    settings.Button.LayoutOrder=100000
    w.SettingsTab=settings
    task.defer(function()
        if w.Destroyed or w.TargetTab then return end
        w:SelectTab(settings)
        w.SettingsAutoSelected=true
    end)
    local controls={}
    w.SettingsControls=controls
    local DEFAULTS={ToggleKey="RightShift",ClickSounds=true,Volume=0.45,Animations=true,Scale=0.88,Theme="Violet",Overlay=true,
        Blur=false,Tooltips=true,Notifications=true,NotifyDuration=3.5,Streamer=false,OpenOnLaunch=true}
    local input=settings:CreateSection({Name="Controls",Column="Left",Icon="keyboard"})
    w.KeyControl=input:CreateKeybind({Name="Toggle menu",CurrentKeybind="RightShift",
        Tooltip="Key that shows and hides the menu.",Callback=function(key) w:SetToggleKey(key) end})
    controls.OpenOnLaunch=input:CreateToggle({Name="Open on launch",CurrentValue=true,
        Tooltip="Off: the menu starts hidden and only the Hzs-Hub button shows.",
        Callback=function(v) w.Settings.OpenOnLaunch=v;w:_scheduleSave() end})
    input:CreateLabel("Click the key to rebind it. Escape cancels. Ctrl+F jumps to search.")
    input:CreateButton({Name="Center window",Icon="locate",Tooltip="Puts the menu back in the middle of the screen.",
        Callback=function() w:_fit() end})
    input:CreateButton({Name="Reset overlay position",Icon="move",Tooltip="Moves the overlay back to the top center of the screen.",
        Callback=function()
            if w.Overlay then w.Overlay.AnchorPoint=Vector2.new(0.5,0);w.Overlay.Position=UDim2.new(0.5,0,0,0) end
        end})
    local alerts=settings:CreateSection({Name="Notifications",Column="Left",Icon="bell"})
    controls.Notifications=alerts:CreateToggle({Name="Show notifications",CurrentValue=true,
        Tooltip="Off: messages only go to the status line at the bottom. Confirm windows still show.",
        Callback=function(v) w.Settings.Notifications=v;w:_scheduleSave() end})
    controls.NotifyDuration=alerts:CreateSlider({Name="Time on screen",Range={1,10},Increment=0.5,CurrentValue=3.5,Suffix=" s",
        Tooltip="How long a notification stays before it fades.",
        Callback=function(v) w.Settings.NotifyDuration=v;w:_scheduleSave() end})
    alerts:CreateButton({Name="Send test notification",Icon="bell-ring",Tooltip="Shows a sample so you can see the timing.",
        Callback=function() w:Notify({Title="Test notification",Content="This is how alerts will look and how long they stay.",Force=true}) end})
    local audio=settings:CreateSection({Name="Audio",Column="Left",Icon="volume-2"})
    controls.ClickSounds=audio:CreateToggle({Name="Click sounds",CurrentValue=true,
        Tooltip="Soft click when you press buttons and toggles.",Callback=function(v) w.Settings.ClickSounds=v end})
    controls.Volume=audio:CreateSlider({Name="Volume",Range={0,1},Increment=0.05,CurrentValue=0.45,
        Callback=function(v) w.Settings.Volume=v;w.Sound.Volume=v end})
    local appearance=settings:CreateSection({Name="Appearance",Column="Right",Icon="palette"})
    local themeOptions={}
    for i,name in ipairs(THEME_ORDER) do themeOptions[i]=name end
    controls.Theme=appearance:CreateDropdown({Name="Theme",Options=themeOptions,CurrentOption="Violet",
        Tooltip="Accent colors for the whole menu.",
        Callback=function(v) w:_setTheme(v);w:_scheduleSave() end})
    controls.Scale=appearance:CreateSlider({Name="UI scale",Range={0.65,0.95},Increment=0.05,CurrentValue=0.88,
        Tooltip="Makes the whole menu bigger or smaller.",Callback=function(v) w.Settings.Scale=v;w:_fit() end})
    controls.Animations=appearance:CreateToggle({Name="Smooth transitions",CurrentValue=true,
        Tooltip="Turn off for instant, animation-free UI.",Callback=function(v) w.Settings.Animations=v end})
    controls.Blur=appearance:CreateToggle({Name="Blur game behind menu",CurrentValue=false,
        Tooltip="Softly blurs the game while the menu is open.",
        Callback=function(v) w.Settings.Blur=v;w:_updateBlur();w:_scheduleSave() end})
    controls.Tooltips=appearance:CreateToggle({Name="Tooltips",CurrentValue=true,
        Tooltip="Hints like this one when you hover a setting.",
        Callback=function(v) w.Settings.Tooltips=v;w:_applyTooltips();w:_scheduleSave() end})
    controls.Overlay=appearance:CreateToggle({Name="Overlay",CurrentValue=true,
        Tooltip="Thin horizontal bar with FPS, ping and the clock.",
        Callback=function(v) w.Settings.Overlay=v;if w.Overlay then w.Overlay.Visible=v end;w:_scheduleSave() end})
    appearance:CreateButton({Name="Reset UI settings",Icon="rotate-ccw",Tooltip="Everything on this tab goes back to default.",Callback=function()
        w:Confirm({Title="Reset UI settings?",Content="All appearance options on this tab go back to default. Your feature settings and configs stay.",
            ConfirmText="Reset",Callback=function(confirmed)
                if not confirmed then return end
                w:ApplySettings(DEFAULTS)
                w:Notify({Title="Settings reset",Content="UI settings are back to default.",Type="Success"})
            end})
    end})
    local privacy=settings:CreateSection({Name="Privacy",Column="Right",Icon="eye-off"})
    controls.Streamer=privacy:CreateToggle({Name="Streamer mode",CurrentValue=false,
        Tooltip="Hides your name, avatar and region inside the menu.",
        Callback=function(v) w.Settings.Streamer=v;w:_applyStreamer();w:_scheduleSave() end})
    privacy:CreateLabel("Handy for recording or streaming. Your Roblox name stays hidden on the dashboard and the player card.")
    local configs=settings:CreateSection({Name="Configs",Column="Right",Icon="folder-open"})
    if HAS_FILES then
        local EMPTY="No configs yet"
        local nameInput=configs:CreateInput({Name="Config name",PlaceholderText="Farm, PvP, Chill...",
            Tooltip="Letters, numbers, spaces, - and _. Up to 32 characters."})
        local function list()
            local names=w:ListConfigs()
            if #names==0 then return {EMPTY} end
            return names
        end
        local picker=configs:CreateDropdown({Name="Saved configs",Options=list(),Tooltip="Pick a config to load or delete.",
            Callback=function(v) if v~=EMPTY then nameInput:Set(v,true) end end})
        local function refresh(select)
            local names=list()
            picker:Refresh(names,select and table.find(names,select) and select or nil)
        end
        local function chosen()
            local typed=cleanName(nameInput:Get())
            if typed then return typed end
            local picked=picker:Get()
            if picked~=EMPTY then return picked end
            return nil
        end
        configs:CreateButton({Name="Save config",Icon="save",Tooltip="Saves every setting that has a Flag under this name.",Callback=function()
            local name=cleanName(nameInput:Get())
            if not name then w:Notify({Title="No name yet",Content="Type a config name first.",Type="Warning"});return end
            local function save()
                local ok,err=w:SaveConfigAs(name)
                if ok then
                    refresh(name)
                    w:Notify({Title="Config saved",Content="\""..name.."\" is ready to load any time.",Type="Success"})
                else
                    w:Notify({Title="Save failed",Content=tostring(err),Type="Error",Duration=5})
                end
            end
            if table.find(w:ListConfigs(),name) then
                w:Confirm({Title="Overwrite config?",Content="\""..name.."\" already exists. Replace it with your current settings?",
                    ConfirmText="Overwrite",Callback=function(confirmed) if confirmed then save() end end})
            else
                save()
            end
        end})
        configs:CreateButton({Name="Load config",Icon="download",Tooltip="Applies the picked config right away.",Callback=function()
            local name=chosen()
            if not name then w:Notify({Title="Nothing picked",Content="Choose or type a config first.",Type="Warning"});return end
            local ok,err=w:LoadConfig(name)
            if ok then w:Notify({Title="Config loaded",Content="Switched to \""..name.."\".",Type="Success"})
            else w:Notify({Title="Load failed",Content=tostring(err),Type="Error",Duration=5}) end
        end})
        configs:CreateButton({Name="Delete config",Icon="trash-2",Tooltip="Removes the picked config file.",Callback=function()
            local name=chosen()
            if not name then w:Notify({Title="Nothing picked",Content="Choose or type a config first.",Type="Warning"});return end
            w:Confirm({Title="Delete config?",Content="\""..name.."\" will be gone for good.",ConfirmText="Delete",Danger=true,
                Callback=function(confirmed)
                    if not confirmed then return end
                    w:DeleteConfig(name);nameInput:Set("",true);refresh()
                    w:Notify({Title="Config deleted",Content="\""..name.."\" was removed.",Type="Success"})
                end})
        end})
    else
        configs:CreateLabel("Configs need an executor with file access (writefile and readfile).")
    end
    if options.Dashboard~=false then
        w._buildingSettings=true
        w:_buildDashboard()
        w._buildingSettings=nil
        w:SelectTab(w.DashboardTab)
    end
    if options.Settings then w:ApplySettings(options.Settings) end
    if w.SavedSettings then
        local ok,err=pcall(function() w:ApplySettings(w.SavedSettings) end)
        if not ok then warn("[Hzs-Hub] Saved UI settings were ignored: "..tostring(err)) end
    end
    w:_buildOverlay()
    local target=w:_fitScale()
    w.Scale.Scale=target*0.92
    w:_scaleTo(target,0.34,Enum.EasingStyle.Back)
    task.defer(function()
        if w.Destroyed then return end
        local real=w:_fitScale()
        if math.abs(real-target)>0.01 then w:_fit() end
    end)
    if w.Settings.OpenOnLaunch==false then
        w.Visible=false;w.Root.Visible=false;w.Reopen.Visible=true
    end
    w:_applyStreamer();w:_applyTooltips();w:_updateBlur()
    return w
end
-- KEY SYSTEM ------------------------------------------------------------------
-- Panda Auth (PUSL-V4) + a styled key login window.
local KeyProviders = {}
-- Panda Auth PUSL-V4: the official library from secure.pandauth.com, loaded once and configured per service
do
    local lib, configuredFor
    local function pusl(service)
        if not lib then
            local ok, loaded = pcall(function() return loadstring(game:HttpGet("https://secure.pandauth.com/pv4/lib"))() end)
            if not ok or type(loaded) ~= "table" or type(loaded.configure) ~= "function" then
                return nil, "Panda library failed to load", true
            end
            lib = loaded
        end
        if configuredFor ~= service then
            local ok, err = pcall(lib.configure, {serviceId = service})
            if not ok then return nil, "Panda setup failed: " .. tostring(err), true end
            configuredFor = service
        end
        return lib
    end
    KeyProviders.Panda = {
        Validate = function(service, key)
            local panda, err = pusl(service)
            if not panda then return false, err, true end
            local ok, result = pcall(panda.validate, key)
            if not ok then return false, "Key check failed: " .. tostring(result), true end
            if type(result) ~= "table" then return false, "Unexpected answer from Panda", true end
            if result.success then
                return true, {Premium = result.isPremium == true, Key = key,
                    Expires = result.expiresAt or result.expires_on or result.expiresOn or result.expires,
                    Message = result.message}
            end
            local reason = result.message or result.error or result.reason or "This key is not valid"
            return false, tostring(reason)
        end,
        GetKeyLink = function(service)
            local panda = pusl(service)
            if not panda or type(panda.getKeyUrl) ~= "function" then return nil end
            local ok, link = pcall(panda.getKeyUrl)
            return ok and link or nil
        end,
    }
end

-- only spaces and line breaks at the edges are removed; spaces inside a key are part of it
local function trimKey(value) return (tostring(value):gsub("^%s+", ""):gsub("%s+$", "")) end
local function keyPath(folder, id) return folder .. "/" .. id .. ".key" end
local function readSavedKey(folder, id)
    if not HAS_FILES then return nil end
    local ok, value = pcall(function() return isfile(keyPath(folder, id)) and readfile(keyPath(folder, id)) or nil end)
    local key = ok and type(value) == "string" and trimKey(value) or ""
    return key ~= "" and key or nil
end
local function saveKey(folder, id, key)
    if not HAS_FILES then return end
    pcall(function()
        if type(isfolder) == "function" and not isfolder(folder) then makefolder(folder) end
        writefile(keyPath(folder, id), key)
    end)
end
function Library:ForgetKey(id, folder)
    if not HAS_FILES then return end
    pcall(function()
        local path = keyPath(folder or "Hzs-Hub", id or "key")
        if isfile(path) then
            if type(delfile) == "function" then delfile(path) else writefile(path, "") end
        end
    end)
end

-- Library:KeySystem(options) shows the key window and waits.
-- Returns true, info (Premium, Expires, Key) when the key is accepted, or false if the window was closed.
-- options: Service (Panda service id), Provider ("Panda", default), Validate(key) / GetKeyLink() for custom checks,
--          Discord (invite link; adds a "copy invite" button for people who have no key), Title, Subtitle, Note, Logo, SaveKey (true), Id ("key"), Folder ("Hzs-Hub"), Parent
function Library:KeySystem(options)
    options = options or {}
    local provider = KeyProviders[options.Provider or "Panda"]
    local service = options.Service
    local validate = options.Validate or function(key)
        if not provider then return false, "Unknown key provider" end
        if type(service) ~= "string" or service == "" or service:find("^your") then
            return false, "Set your Panda service id in the script"
        end
        return provider.Validate(service, key)
    end
    local getLink = options.GetKeyLink or function() return provider and service and provider.GetKeyLink(service) or nil end
    local folder, id = options.Folder or "Hzs-Hub", options.Id or "key"
    local remember = options.SaveKey ~= false

    -- a saved key that still works skips the window entirely
    local saved = remember and readSavedKey(folder, id)
    if saved then
        local ok, info, transient = validate(saved)
        if ok then return true, info end
        -- the key is erased only when it was refused; a Panda or network problem keeps it for the next launch
        if not transient then Library:ForgetKey(id, folder) end
    end

    local player = Players.LocalPlayer
    local gui = new("ScreenGui", {Name = "Hzs-HubKey", ResetOnSpawn = false, DisplayOrder = 40, IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, nil)
    if type(syn) == "table" and type(syn.protect_gui) == "function" then pcall(syn.protect_gui, gui) end
    gui.Parent = guiParent(options.Parent, player:WaitForChild("PlayerGui"))

    local shade = frame(gui, UDim2.fromScale(1, 1), C.black);shade.BackgroundTransparency = 1
    local holder = frame(gui, UDim2.fromOffset(392, 0), C.white);holder.BackgroundTransparency = 1
    holder.AnchorPoint = Vector2.new(0.5, 0.5);holder.Position = UDim2.fromScale(0.5, 0.52);holder.AutomaticSize = Enum.AutomaticSize.Y
    local scale = new("UIScale", {Scale = 0.92}, holder)
    local function fit()
        local camera = workspace.CurrentCamera
        local v = camera and camera.ViewportSize or Vector2.new(1280, 720)
        return math.clamp(math.min((v.X - 24) / 392, (v.Y - 24) / 340), 0.5, 1)
    end
    local card = new("CanvasGroup", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = C.white,
        BorderSizePixel = 0, GroupTransparency = 1}, holder)
    local skin = shaded(card, UDim2.fromScale(1, 1), C.bg1, C.bg2, 115);skin.ZIndex = 0;card.BackgroundTransparency = 1
    round(card, 14);glowBorder(card, 0.45)
    glowSpot(card, 300, -60, 150, "accent", 0.982)
    local inner = frame(card, UDim2.new(1, 0, 0, 0));inner.BackgroundTransparency = 1;inner.AutomaticSize = Enum.AutomaticSize.Y;inner.ZIndex = 1
    pad(inner, 22, 22, 20, 18);stack(inner, 10)

    -- header: logo, title, close
    local head = frame(inner, UDim2.new(1, 0, 0, 44));head.BackgroundTransparency = 1;head.LayoutOrder = 1;head.Active = true
    local badge = frame(head, UDim2.fromOffset(42, 42), C.white);round(badge, 11)
    themedGradient(badge, function() return C.accentDim, C.pinkDim end, 135);accentStroke(badge, 0.55)
    local letter = text(badge, "H", UDim2.fromScale(1, 1));letter.TextSize = 20;letter.Font = F.bold
    letter.TextXAlignment = Enum.TextXAlignment.Center;letter.TextColor3 = C.white;accentFill(letter, 90)
    local logo = image(badge, options.Logo or LOGO, UDim2.fromScale(1, 1));logo.ZIndex = 2
    logo:GetPropertyChangedSignal("IsLoaded"):Connect(function() letter.Visible = not logo.IsLoaded end)
    letter.Visible = not logo.IsLoaded
    local title = text(head, tostring(options.Title or "Hzs-Hub"), UDim2.new(1, -96, 0, 22));title.Position = UDim2.fromOffset(54, 2)
    title.Font = F.bold;title.TextSize = 17;title.TextColor3 = C.white
    themedGradient(title, function() return C.text, C.accent end, 0)
    local subtitle = text(head, tostring(options.Subtitle or "Enter your key to continue"), UDim2.new(1, -96, 0, 16))
    subtitle.Position = UDim2.fromOffset(54, 24);subtitle.TextSize = 12;subtitle.TextColor3 = C.muted
    local close = button(head, "", UDim2.fromOffset(26, 26));close.AnchorPoint = Vector2.new(1, 0);close.Position = UDim2.new(1, 2, 0, 0)
    close.BackgroundColor3 = C.dangerDim;close.BackgroundTransparency = 1
    local closeGlyph = icon(close, "x", 15, C.muted);closeGlyph.AnchorPoint = Vector2.new(0.5, 0.5);closeGlyph.Position = UDim2.fromScale(0.5, 0.5)
    close.MouseEnter:Connect(function() close.BackgroundTransparency = 0;closeGlyph.ImageColor3 = C.danger end)
    close.MouseLeave:Connect(function() close.BackgroundTransparency = 1;closeGlyph.ImageColor3 = C.muted end)

    local rule = frame(inner, UDim2.new(1, 0, 0, 1), C.white);rule.LayoutOrder = 2
    themedGradient(rule, function() return C.accent, C.line end, 0, 0.55, 0.4)

    -- key input
    local field = frame(inner, UDim2.new(1, 0, 0, 40), C.row);field.LayoutOrder = 3;round(field, 9)
    local fieldStroke = border(field, 0.25)
    local keyGlyph = icon(field, "key-round", 15, C.muted);keyGlyph.Position = UDim2.fromOffset(12, 12)
    local box = new("TextBox", {Size = UDim2.new(1, -78, 1, 0), Position = UDim2.fromOffset(36, 0), BackgroundTransparency = 1,
        Text = "", PlaceholderText = "Paste your key here", PlaceholderColor3 = C.dim, TextColor3 = C.text, Font = F.body, TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, TextTruncate = Enum.TextTruncate.AtEnd}, field)
    local paste = button(field, "", UDim2.fromOffset(30, 30));paste.AnchorPoint = Vector2.new(1, 0.5);paste.Position = UDim2.new(1, -5, 0.5, 0)
    paste.BackgroundTransparency = 1
    local pasteGlyph = icon(paste, "clipboard-paste", 15, C.muted);pasteGlyph.AnchorPoint = Vector2.new(0.5, 0.5);pasteGlyph.Position = UDim2.fromScale(0.5, 0.5)
    paste.Visible = type(getclipboard) == "function"
    box.Focused:Connect(function() fieldStroke.Color = C.accent;fieldStroke.Transparency = 0;keyGlyph.ImageColor3 = C.accent end)
    box.FocusLost:Connect(function() fieldStroke.Color = C.line;fieldStroke.Transparency = 0.25;keyGlyph.ImageColor3 = C.muted end)

    -- status line
    local statusRow = frame(inner, UDim2.new(1, 0, 0, 16));statusRow.BackgroundTransparency = 1;statusRow.LayoutOrder = 4
    local statusDot = frame(statusRow, UDim2.fromOffset(6, 6), C.dim);statusDot.Position = UDim2.fromOffset(2, 5);round(statusDot, "full")
    local status = text(statusRow, options.Note or "Get a key, then paste it above.", UDim2.new(1, -14, 1, 0))
    status.Position = UDim2.fromOffset(14, 0);status.TextSize = 12;status.TextColor3 = C.sub
    local function setStatus(message, kind)
        status.Text = message
        local color = kind == "error" and C.danger or kind == "ok" and C.online or kind == "busy" and C.accent or C.dim
        statusDot.BackgroundColor3 = color
        status.TextColor3 = kind == "error" and C.danger or kind == "ok" and C.online or C.sub
    end

    -- buttons
    local actions = frame(inner, UDim2.new(1, 0, 0, 38));actions.BackgroundTransparency = 1;actions.LayoutOrder = 5
    local getKey = button(actions, "", UDim2.new(0.5, -5, 1, 0));getKey.BackgroundColor3 = C.row
    local checkKey = button(actions, "", UDim2.new(0.5, -5, 1, 0));checkKey.Position = UDim2.new(0.5, 5, 0, 0)
    checkKey.BackgroundColor3 = C.white;accentFill(checkKey, 0)
    local function labelled(b, glyphName, value, color)
        local content = frame(b, UDim2.fromScale(0, 1));content.BackgroundTransparency = 1;content.AutomaticSize = Enum.AutomaticSize.X
        content.AnchorPoint = Vector2.new(0.5, 0.5);content.Position = UDim2.fromScale(0.5, 0.5)
        new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder}, content)
        local glyph = icon(content, glyphName, 15, color);glyph.LayoutOrder = 1
        local l = text(content, value, UDim2.fromScale(0, 1));l.LayoutOrder = 2;l.AutomaticSize = Enum.AutomaticSize.X
        l.Font = F.bold;l.TextColor3 = color
        return l, glyph
    end
    local getLabel = labelled(getKey, "link", "Get key", C.text2)
    local checkLabel, checkGlyph = labelled(checkKey, "log-in", "Check key", C.white)
    getKey.MouseEnter:Connect(function() getKey.BackgroundColor3 = C.hover end)
    getKey.MouseLeave:Connect(function() getKey.BackgroundColor3 = C.row end)
    local checkHover = new("UIStroke", {Color = C.white, Transparency = 1, Thickness = 1.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, checkKey)
    checkKey.MouseEnter:Connect(function() checkHover.Transparency = 0.6 end)
    checkKey.MouseLeave:Connect(function() checkHover.Transparency = 1 end)

    -- Discord invite: for someone who has no key and does not know where to get one
    local discordLink = options.Discord
    if type(discordLink) == "string" and discordLink ~= "" then
        local discordBtn = button(inner, "", UDim2.new(1, 0, 0, 36));discordBtn.LayoutOrder = 6;discordBtn.BackgroundColor3 = C.row
        round(discordBtn, 9);border(discordBtn, 0.35)
        local discordLabel = labelled(discordBtn, "message-circle", "No key yet? Copy the Discord invite", C.text2)
        discordBtn.MouseEnter:Connect(function() discordBtn.BackgroundColor3 = C.hover end)
        discordBtn.MouseLeave:Connect(function() discordBtn.BackgroundColor3 = C.row end)
        discordBtn.Activated:Connect(function()
            if type(setclipboard) == "function" then
                pcall(setclipboard, discordLink)
                setStatus("Discord invite copied. Open it in your browser to buy a key.", "ok")
                discordLabel.Text = "Invite copied"
                task.delay(2.5, function() if discordLabel.Parent then discordLabel.Text = "No key yet? Copy the Discord invite" end end)
            else
                box.Text = discordLink
                setStatus("Your executor cannot copy. The Discord invite is in the field.", "error")
            end
        end)
    end

    local footer = text(inner, remember and "Your key is remembered on this device." or "", UDim2.new(1, 0, 0, 14))
    footer.LayoutOrder = 7;footer.TextSize = 11;footer.TextColor3 = C.dim;footer.TextXAlignment = Enum.TextXAlignment.Center
    footer.Visible = remember and HAS_FILES

    -- drag by the header
    local keyConns = {}
    do
        local dragging, startMouse, startPos
        head.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging, startMouse, startPos = true, input.Position, holder.Position
            end
        end)
        table.insert(keyConns, UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = (input.Position - startMouse) / math.max(scale.Scale, 0.01)
                holder.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
            end
        end))
        table.insert(keyConns, UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
        end))
    end

    -- open animation
    TweenService:Create(shade, TweenInfo.new(0.25), {BackgroundTransparency = 0.55}):Play()
    TweenService:Create(card, TweenInfo.new(0.25), {GroupTransparency = 0}):Play()
    TweenService:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Scale = fit()}):Play()
    TweenService:Create(holder, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Position = UDim2.fromScale(0.5, 0.5)}):Play()

    local result, resultInfo, finished = false, nil, false
    local busy = false
    local function finish(ok, info)
        if finished then return end
        finished, result, resultInfo = true, ok, info
        for _, connection in ipairs(keyConns) do connection:Disconnect() end
        TweenService:Create(shade, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TweenService:Create(card, TweenInfo.new(0.2), {GroupTransparency = 1}):Play()
        TweenService:Create(scale, TweenInfo.new(0.2), {Scale = scale.Scale * 0.94}):Play()
        task.delay(0.22, function() gui:Destroy() end)
    end
    local function shake()
        local base = holder.Position
        for _, dx in ipairs({-9, 8, -6, 4, -2, 0}) do
            holder.Position = base + UDim2.fromOffset(dx, 0)
            task.wait(0.035)
        end
        holder.Position = base
    end

    getKey.Activated:Connect(function()
        if busy then return end
        busy = true
        setStatus("Making your key link...", "busy")
        task.spawn(function()
            local link = getLink()
            busy = false
            if not link then setStatus("No key link is set for this script.", "error") return end
            if type(setclipboard) == "function" then
                pcall(setclipboard, link)
                setStatus("Key link copied. Open it in your browser.", "ok")
                getLabel.Text = "Link copied"
                task.delay(2.5, function() if getLabel.Parent then getLabel.Text = "Get key" end end)
            else
                box.Text = link
                setStatus("Your executor cannot copy. The link is in the field.", "error")
            end
        end)
    end)
    paste.Activated:Connect(function()
        local ok, value = pcall(getclipboard)
        if ok and type(value) == "string" then box.Text = trimKey(value) end
    end)

    local function check()
        if busy or finished then return end
        local key = trimKey(box.Text)
        if key == "" then
            setStatus("Paste your key first.", "error")
            task.spawn(shake)
            return
        end
        busy = true
        checkLabel.Text = "Checking..."
        setStatus("Checking your key...", "busy")
        local spin = TweenService:Create(checkGlyph, TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Rotation = 360})
        spin:Play()
        task.spawn(function()
            local ok, info = validate(key)
            spin:Cancel();checkGlyph.Rotation = 0
            busy = false
            if finished then return end
            if ok then
                info = type(info) == "table" and info or {}
                info.Key = info.Key or key
                if remember then saveKey(folder, id, key) end
                local extra = info.Premium and "Premium key" or "Key accepted"
                if info.Expires then extra = extra .. ", expires " .. tostring(info.Expires) end
                checkLabel.Text = "Welcome"
                setStatus(extra, "ok")
                task.wait(0.7)
                finish(true, info)
            else
                checkLabel.Text = "Check key"
                setStatus(tostring(info or "Invalid key"), "error")
                task.spawn(shake)
            end
        end)
    end
    checkKey.Activated:Connect(check)
    box.FocusLost:Connect(function(enter) if enter then check() end end)
    close.Activated:Connect(function() finish(false, nil) end)

    while not finished do task.wait(0.05) end
    return result, resultInfo
end
return Library
