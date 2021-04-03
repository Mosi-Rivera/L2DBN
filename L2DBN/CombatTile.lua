local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or "";
local Class         = require(_PACKAGE..'/Class');
local CombatTile    = Class{};
local setColor      = love.graphics.setColor;
local rectangle     = love.graphics.rectangle;

local tile_states = {
    normal = 'normal',
}

local function invalidMove()
    return;
end

function CombatTile:init(parent,x,y)
    self.parent = parent;
    self.index = (y - 1) * self.parent.width + x;
    self.x = x;
    self.y = y;
    self.occupying = nil;
    self.state = tile_states.normal;
    self.state_timer = 0;
    self.color = {1,0,0,1};

    if self.x == 1 then
        self.moveLeft = invalidMove;
    elseif self.x == self.parent.width then
        self.moveRight = invalidMove;
    end

    if self.y == 1 then
        self.moveUp = invalidMove;
    elseif self.y == self.parent.height then 
        self.moveDown = invalidMove
    end
end

function CombatTile:setState(state,ms)
    self.state = state;
    self.state_timer = ms or 0;
end

function CombatTile:removeOccupying()
    self.occupying.tile = nil;
    self.occupying = nil;
end

function CombatTile:setOccupying(obj)
    if not self:isOccupied() then
        self.occupying = obj;
        obj.tile = self;
        return true;
    end
    return false;
end

function CombatTile:isOccupied()
    return not self.occupying == nil;
end

function CombatTile:move(n)
    local board = self.parent.board;
    local move_to = board[self.index + n];
    if not move_to:getOccupying() then
        local occupying = self.occupying;
        self:removeOccupying();
        move_to:setOccupying(occupying);
        return true;
    end
    return false;
end

function CombatTile:moveLeft()
    self:move(-1);
end

function CombatTile:moveRight()
    self:move(1);
end

function CombatTile:moveUp()
    self:move(-self.parent.width);
end

function CombatTile:moveDown()
    self:move(self.parent.width);
end

function CombatTile:update(dt)
    self.state_timer = self.state_timer - dt;
    if self.state_timer <= 0 then
        self.state_timer = tile_states.normal;
    end
    local occupying = self.occupying;
    if occupying then
        occupying:update(dt);
    end
end

function CombatTile:render()
    local parent        = self.parent;
    local start_x       = parent.start_x;
    local start_y       = parent.start_y;
    local tileWidth     = parent.tileWidth;
    local tileHeight    = parent.tileHeight;
    local padding       = parent.tile_padding;
    setColor(unpack(self.color));
    rectangle(
        'fill',
        start_x + (tileWidth * (self.x - 1)) + padding,
        start_y + (tileHeight * (self.x - 1)) + padding,
        tileWidth,
        tileHeight
    );
    local occupying = self.occupying;
    if occupying then
        occupying:render();
    end
end

return CombatTile;