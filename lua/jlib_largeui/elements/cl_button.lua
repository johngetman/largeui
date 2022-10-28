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
    self.DrawColor = color
end

function panel:GetColor()
    return self.DrawColor
end

function panel:OnCursorEntered()
    self:ColorTo(self.EntryColor, 0.15, 0)
end

function panel:OnCursorExited()
    self:ColorTo(self.ExitColor, 0.15, 0)
end

function panel:SetImage( img )
	if not img then
		if IsValid(self.m_Image) then
			self.m_Image:Remove()
		end

		return
	end

	if not IsValid(self.m_Image) then
		self.m_Image = vgui.Create( "DImage", self )
	end

    self.m_Image:SetImageColor(largeui_title)
	self.m_Image:SetImage( img )
	self.m_Image:SetSize(16, 16)
	self:InvalidateLayout()
end

function panel:PerformLayout( w, h )
	if IsValid( self.m_Image ) then
		self.m_Image:SetPos( 12, h/2-8 )
		self:SetTextInset( self.m_Image:GetWide() + 0, 0 )
	end

	DLabel.PerformLayout( self, w, h )
end

function panel:Paint(w, h)
    --draw.RoundedBox(LargeUIRound, 0, 0, w, h, self.DrawColor)

	surface.SetDrawColor(self.DrawColor)
    surface.DrawRect(0, 0, w, h)
end

LargeUI.Register("Button", panel, "DButton")