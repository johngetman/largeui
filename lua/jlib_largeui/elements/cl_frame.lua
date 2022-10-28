local panel = {}

local mat_Close = Material("largeui/close.png")
local top_Size, margin = 65, 30

function panel:Init()
    self.Margin = margin -- Для остальных панелей

    self:SetSize(ScrW(), ScrH())
    self:MakePopup()

    self:SetAlpha(0)
    self:AlphaTo(255, 0.3, 0)
    
    self.Top = self:Add("Panel")
    self.Top:Dock(TOP)
    self.Top:SetTall(top_Size)
    self.Top:DockPadding(margin, 0, margin, 0)
    self.Top.Paint = nil

    self.Top.TitleImage = self.Top:Add("DImage")
    self.Top.TitleImage:SetWide(imgW)
    self.Top.TitleImage:Dock(LEFT)
    self.Top.TitleImage:DockMargin(0, 0, 10, 0)

    self.Top.Close = LargeUI.New("Button", self.Top)
    self.Top.Close:Dock(RIGHT)
    self.Top.Close:DockMargin(5, 5, 5, 5)
    self.Top.Close:SetWide(top_Size-10)
    self.Top.Close:SetText("")
    self.Top.Close:SetColors(largeui_desc, largeui_title)
    self.Top.Close.Paint = nil

    self.Top.Close.DoClick = function()
        self:Close()
    end
    
    self.Top.Close.Paint = function(self, w, h)
        surface.SetDrawColor(self.DrawColor)
        surface.SetMaterial(mat_Close)
        surface.DrawTexturedRect(w/2-12, h/2-12, 24, 24)
    end
end

function panel:SetImage(img, imgW)
    self.Top.TitleImage:SetImage(img)
    self.Top.TitleImage:SetImageColor(largeui_title)
    self.Top.TitleImage:SetWide(imgW)
end

function panel:OnScreenSizeChanged()
    self:SetSize(ScrW(), ScrH())
end

function panel:Close()
    self:AlphaTo(0, 0.3, 0, function()
        self:Remove()
        self:OnClose()
    end)
end

function panel:OnClose()
end

function panel:Paint(w, h)
    surface.SetDrawColor(largeui_primary)
    surface.DrawRect(0, 0, w, h)
end

LargeUI.Register("Frame", panel)

concommand.Add("FrameTest", function()
    local frame = LargeUI.New()
    frame:SetImage("largeui/gunshop.png", 120)

    local page1 = vgui.Create("DPanel")
    page1:Dock(FILL)
    
    frame.Pages = LargeUI.New("Pages", frame)
    frame.Pages:Dock(FILL)
    frame.Pages:AddPage("ГЛАВНАЯ", page1)
    frame.Pages:AddPage("МАГАЗИН",  page1)
    frame.Pages:AddPage("ДОНАТ", page1)
    
    timer.Simple(15, function()
        if IsValid(frame) then
            frame:Close()
        end
    end)
end)
