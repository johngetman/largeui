local panel = {}

function panel:Init()
    self:SetColors(largeui_tritary, largeui_primary)
end

function panel:SetColors(color1, color2)
    self.EntryColor = color1
    self.ExitColor = color2

    self:SetColor(color2)
end

function panel:SetColor(color)
    self:SetTextColor(color)
end

function panel:GetColor()
    return self:GetTextColor()
end

function panel:OnCursorEntered()
    if self:IsSelected() then return end
    
    self:ColorTo(self.EntryColor, 0.15, 0)
end

function panel:OnCursorExited()
    if self:IsSelected() then return end

    self:ColorTo(self.ExitColor, 0.15, 0)
end

function panel:Paint(w, h)
end

LargeUI.Register("LabelButton", panel, "DButton")