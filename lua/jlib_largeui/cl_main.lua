local createFont = surface.CreateFont

/*
    LargeUI - Open-source GUI Library
        which makes it possible to create a UI.
    Coded by johngetman@2022
*/

/*
    Config
*/

LargeUI = {}
LargeUI.Config = {}
LargeUI.Addons = {}

LargeUI.Config.Round = 8
LargeUIRound = LargeUI.Config.Round

LargeUI.Config.Fonts = {
    ["Regular"] = "Roboto",
    ["Bold"] = "Roboto Bold"
}

LargeUI.Config.Themes = {
    [1] = {
        ["Name"] = "Light",

        ["Primary"] = Color(255, 255, 255),
        ["Secondary"] = Color(230, 230, 230),
        ["Tritary"] = Color(200, 200, 200),

        ["Title"] = Color(0, 0, 0),
        ["Description"] = Color(95, 95, 95)
    },

    [2] = {
        ["Name"] = "Dark",

        ["Primary"] = Color(35, 35, 35),
        ["Secondary"] = Color(55, 55, 55),
        ["Tritary"] = Color(75, 75, 75),

        ["Title"] = Color(255, 255, 255),
        ["Description"] = Color(160, 160, 160)
    }
}

LargeUI.Config.DefaultTheme = 2

/*
    Fonts
*/

function LargeUI:Font(size, isbold)
    createFont("LargeUI." .. size .. (isbold and "b" or ""), {
        font = isbold and self.Config.Fonts["Bold"] or self.Config.Fonts["Regular"],
        size = size,
        extended = true,
    })
end

LargeUI:Font(14)
LargeUI:Font(14, true)
LargeUI:Font(16)
LargeUI:Font(16, true)
LargeUI:Font(18)
LargeUI:Font(18, true)
LargeUI:Font(20)
LargeUI:Font(20, true)
LargeUI:Font(24)
LargeUI:Font(24, true)

/*
    Themes & Colors
*/

local ThemeConVar = CreateClientConVar("largeui_theme", LargeUI.Config.DefaultTheme, true, false, nil, 1, #LargeUI.Config.Themes)

cvars.AddChangeCallback("largeui_theme", function()
    hook.Call("LargeUI.UpdateColors")
end)

function LargeUI.GetThemeNumber()
    return ThemeConVar:GetInt()
end

function LargeUI:GetThemeTable()
    return self.Config.Themes[self.GetThemeNumber()]
end

function LargeUI:GetTheme()
    return self:GetThemeTable()["Name"], self.GetThemeNumber()
end

function LargeUI:GetColor(color)
    return self:GetThemeTable()[color]
end

function LargeUI:LoadColors()
    largeui_primary = self:GetColor("Primary")
    largeui_secondary = self:GetColor("Secondary")
    largeui_tritary = self:GetColor("Tritary")
    largeui_title = self:GetColor("Title")
    largeui_desc = self:GetColor("Description")
end

LargeUILoadColors = function()
    LargeUI:LoadColors()
end

LargeUILoadColors()

hook.Add("LargeUI.UpdateColors", "UpdateColors", LargeUILoadColors)

/*
    Panel registration & creation
*/

function LargeUI.New(name, parent)
    return vgui.Create("LargeUI." .. (name or "Frame"), parent)
end

function LargeUI.Register(name, panel, base)
    return derma.DefineControl("LargeUI." .. name, "LargeUI's Element", panel, base or "EditablePanel")
end