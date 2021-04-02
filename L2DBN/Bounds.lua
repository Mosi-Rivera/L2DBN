local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or "";
local Class         = require(_PACKAGE..'/Class');
local Bounds = Class{};

function Bounds:init(originX,originY,w,h)
    self.w = w;
    self.h = h;
    self:setOrigin(originX,originY);
end

function Bounds:setSize(w,h)
    self.w = w;
    self.h = h;
end

function Bounds:setOrigin(originX,originY)
    self.left   = -(self.w * originX);
    self.right  = self.w + self.left;
    self.top    = -(self.h * originY);
    self.bottom = self.h + self.top;
end

return Bounds;