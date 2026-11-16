return {
    ConfigUrl = "https://raw.githubusercontent.com/hzsScripts/HzsHub/main/Configs/Config.lua",
    ConfigEnabled = true,
    ConfigFetchInterval = 15,
    ConfigPriority = "URL",

    Owner = {
        [4756036428] = {
            Name = "Nzx",
            Tag = "NZX OWNER Hzs",
            Bio = "Hzs Hub Owner",
        },
    },

    SubOwner = {
        [11599459143] = {
            Name = "Mateus",
            Tag = "MATEUS SUBOWNER Hzs",
            Bio = "Hzs Hub Subowner",
        },
    },

    AdminWhitelist = {},

    AdminTag = {
        Tag = "Hzs ADMIN",
        Bio = "Hzs Hub Admin",
        Color = Color3.fromRGB(80, 170, 255),
    },

    FirebaseWhitelist = {
        Role = "Whitelist",
        Tag = "Hzs Hub Owner",
        Bio = "Hzs Hub Whitelist",
    },

    RemoteTagName = "1RPNam1eTex1t",
    RemoteFolderName = "RE",
    TagFieldName = "RolePlayName",
    BioFieldName = "RolePlayBio",

    Bio = {
        Enabled = true,
    },

    WhitelistConfig = {
        ["Everyone Can Use?"] = false,
    },

    NotificationConfig = {
        Duration = 5,
    },

    AntiTagChange = {
        Enabled = true,
        Text = "YOU CANNOT CHANGE THE NAME!",
    },

    AntiBioChange = {
        Enabled = true,
        Text = "YOU CANNOT CHANGE THE BIO!",
    },

    AntiConfigChange = {
        Enabled = true,
        Text = "YOU CANNOT CHANGE THE CONFIGURATION!\nChanging it may result in a penalty.",
    },

    KickConfig = {
        KickMessage = "Access Denied\n\nYou are not on this script whitelist.\nPlease contact an administrator.",
        Delay = 5,
        DefaultReason = "You were removed from the server by a Hzs Hub moderator.",
        CheckInterval = 1,
        MaxAge = 300,
        EnableLeaderKick = true,
    },

    Load = {
        WaitForGame = true,
        WaitForCharacter = true,
        RemoteTimeout = 60,
    },

    RGB = {
        Enabled = true,
        Speed = 8,
        Saturation = 1,
        Value = 1,
        RainbowObject = true,
    },

    UserTag = {
        Enabled = true,
        Text = "Hzs Hub User",
        Color = Color3.fromRGB(26, 196, 14),
    },

    UserBio = {
        Enabled = true,
        Text = "Hzs Hub On Top",
        Color = Color3.fromRGB(26, 196, 14),
    },

    BillboardTag = {
        Enabled = true,
        FirebaseOwnerText = "Hzs Hub Owner",
        FirebaseOwnerColor = Color3.fromRGB(255, 105, 180),
        UserText = "Hzs Hub User",
        UserColor = Color3.fromRGB(26, 196, 14),
        OwnerColor = Color3.fromRGB(255, 40, 40),
        SubOwnerColor = Color3.fromRGB(255, 165, 0),
        AdminText = "Hzs Hub Admin",
        AdminColor = Color3.fromRGB(80, 170, 255),
        CountSuffix = " | Players Using Hzs Hub",
        CountColor = Color3.fromRGB(50, 255, 50),
        Size = UDim2.new(0, 240, 0, 50),
        StudsOffset = Vector3.new(0, 2.8, 0),
    },

    Warning = {
        Duration = 10,
        Cooldown = 0.1,
        Color = Color3.fromRGB(255, 255, 255),
        Background = Color3.fromRGB(0, 0, 0),
        OverlayTransparency = 0,
        BoxColor = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(255, 255, 255),
        Width = 380,
        Height = 130,
        TextSize = 16,
        SoundId = "rbxassetid://111198694307041",
        SoundVolume = 1,
    },

    Translations = {
        Enabled = true,
        AutoDetect = true,
        Language = "",
        LanguageCode = "",
        ExternalURL = "",
        FallbackLanguage = "ENGLISH",
        LocaleMap = {},
        DynamicTranslation = true,
        DynamicMaxRequests = 600,
        TranslateSingleWords = true,
        DynamicRequestDelay = 0.18,
    },

    Notify = {
        Enabled = true,
        ImageID = "rbxassetid://127843403295538",
        Title = "Access Granted",
        Text = "Welcome, %s!",
        TitleColor = Color3.fromRGB(255, 255, 255),
        StrokeColor = Color3.fromRGB(255, 255, 255),
        BackgroundColor = Color3.fromRGB(15, 15, 15),
        IconHolderColor = Color3.fromRGB(35, 35, 35),
        TextColor = Color3.fromRGB(200, 200, 200),
        Width = 250,
        Height = 78,
        SlideInTime = 0.5,
        SlideOutTime = 0.5,
        DelayBeforeShow = 1,
        DisplayOrder = 999,
        BottomMargin = 15,
        RightMargin = 15,
        TitleTextSize = 13,
        BodyTextSize = 11,
    },
}
