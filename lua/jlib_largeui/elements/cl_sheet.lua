local panel = {}

local color_blue = Color(59, 167, 255)

function panel:Init()
    local m = self:GetParent().Margin
    self:DockPadding(m, m, m, m)
    self.Selected = nil
    self.Top = self:GetParent().Top
end

function panel:AddPage(title, panel, icon)    
    panel:SetParent(self)
    panel:SetVisible(false)
    
    local page = LargeUI.New("LabelButton", self.Top) --self.Top:Add("DButton")
    page.Panel = panel
    page:SetSelectable(true)
    page:Dock(LEFT)
    page:DockMargin(5, 5, 0, 5)
    page:SetColors(color_blue, largeui_title)
    page:SetWide(120)

    if icon then
        page:SetImage(icon)
    end

    page:SetTextColor(largeui_title)
    page:SetFont("LargeUI.16b")
    page:SetText(title)

    page.DoClick = function(page)
        self:SetSelected(page)
    end

    if not IsValid(self.Selected) then
        self:SetSelected(page)
        page:ColorTo(color_blue, 0.15, 0)
    end
end

function panel:SetSelected(button)
    if IsValid(self.Selected) then
        if self.Selected == button then return end
        self.Selected:SetSelected(false)
        self.Selected.Panel:SetVisible(false)

        self.Selected:ColorTo(self.Selected.ExitColor, 0.15, 0)
    end

    self.Selected = button
    self.Selected:SetSelected(true)
    self.Selected.Panel:SetVisible(true)
end

LargeUI.Register("Pages", panel)