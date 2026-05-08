local MDT_NPT = MDT_NPT

local Beacon = {}
MDT_NPT.Beacon = Beacon

function Beacon:Show()
  self.frame = self.frame or MDT_NPT.BeaconFrame.create()
  self.frame:Show()
end

function Beacon:Hide()
  if self.frame then self.frame:Hide() end
end

function Beacon:GetFrame()
  self.frame = self.frame or MDT_NPT.BeaconFrame.create()
  return self.frame
end

function Beacon:ApplyAlpha(alpha)
  local db = MDT_NPT:GetDB()
  if alpha == nil then
    alpha = (db and db.beacon and db.beacon.alpha) or 1.0
  end
  if db and db.beacon then db.beacon.alpha = alpha end
  if self.frame then self.frame:SetAlpha(alpha) end
end

local POSITION_DEFAULTS = {
  anchorFrom = "TOP",
  anchorTo = "TOP",
  xoffset = 0,
  yoffset = -50,
  scale = 1.0,
}

function Beacon:ResetPosition()
  local state = MDT_NPT:GetBeaconState()
  if not state then return end
  for k, v in pairs(POSITION_DEFAULTS) do state[k] = v end
  if self.frame then
    self.frame:ClearAllPoints()
    self.frame:SetPoint(state.anchorFrom, UIParent, state.anchorTo, state.xoffset, state.yoffset)
    self.frame:SetScale(state.scale)
  end
end
