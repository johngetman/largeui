local panel = {}

function panel:Init()
    self.PanelsWide = 0

    self.Left = self:Add("DButton")
    self.Left:Dock(LEFT)
    self.Left:SetWide(16)
    self.Left:SetText("<")

    self.Content = self:Add("Panel")
    self.Content:Dock(FILL)

    self.Content.Content = self.Content:Add("Panel")
    self.Content.Content.PerformLayout = function(panel, w, h)
        if panel:GetWide() >= self.Content:GetWide() then return end

        panel:SetSize(self.Content:GetSize())
    end

    self.Right = self:Add("DButton")
    self.Right:Dock(RIGHT)
    self.Right:SetWide(16)
    self.Right:SetText(">")
    self.Right.DoClick = function(panel, w, h)
        self.Content.Content:SetPos(self.Content.Content:GetX()+1, 0)
    end
end

function panel:AddPanel(panel)
    local wide = panel:GetWide()

    panel:SetParent(self.Content.Content)
    panel:Dock(LEFT)

    self.PanelsWide = self.PanelsWide+wide

    if self.Content.Content:GetWide() < self.PanelsWide+wide then
        self.Content.Content:SetWide(self.Content.Content:GetWide()-self.PanelsWide+wide)
    end
end

LargeUI.Register("BottomChoice", panel)