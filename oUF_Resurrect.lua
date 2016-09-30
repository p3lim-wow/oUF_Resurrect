local _, ns = ...
local oUF = ns.oUF or oUF
local elementName = 'oUF Resurrect'
assert(oUF, elementName .. ' was unable to locate oUF install')

local LRI = LibStub('LibResInfo-1.0', true)
assert(LRI, elementName .. ' requires LibResInfo-1.0')

oUF.colors.resurrect = {
	CASTING = {1, 1, 1},
	MASSRES = {1, 1, 1},
	SELFRES = {0.3, 0.3, 1},
	PENDING = {0.3, 1, 0.3},
}

local function Update(self, event, unit)
	if(unit ~= self.unit) then
		return
	end

	local element = self.Resurrect
	if(element.PreUpdate) then
		element:PreUpdate()
	end

	local status, endTime, casterUnit = LRI:UnitHasIncomingRes(unit)
	if(status) then
		local colors = self.colors.resurrect[status]
		element:SetVertexColor(colors[1], colors[2], colors[3])
		element:Show()
	else
		element:Hide()
	end

	if(element.PostUpdate) then
		return element:PostUpdate(status, endTime, casterUnit)
	end
end

local function Path(self, ...)
	return (self.Resurrect.Override or Update)(self, ...)
end

local function ForceUpdate(element)
	local parent = element.__owner
	return Path(parent, 'ForceUpdate', parent.unit)
end

local REGISTERED = {}
local function RegisterCallbacks(element)
	table.insert(REGISTERED, element)

	if(#REGISTERED == 1) then
		LRI.RegisterAllCallbacks(elementName, function(event)
			for index = 1, #oUF.objects do
				local frame = oUF.objects[index]
				if(frame.unit and frame.Resurrect) then
					Path(frame, event, frame.unit)
				end
			end
		end, true)
	end
end

local function UnregisterCallbacks(element)
	table.remove(REGISTERED, element)

	if(#REGISTERED == 0) then
		LRI.UnregisterAllCallbacks(elementName)
	end
end

local function Enable(self)
	local element = self.Resurrect
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		RegisterCallbacks(element)

		if(element:IsObjectType('Texture') and not element:GetTexture()) then
			element:SetTexture([[Interface\RaidFrame\Raid-Icon-Rez]])
		end

		return true
	end
end

local function Disable(self)
	local element = self.Resurrect
	if(element) then
		element:Hide()

		UnregisterCallbacks(element)
	end
end

oUF:AddElement('Resurrect', Path, Enable, Disable)
