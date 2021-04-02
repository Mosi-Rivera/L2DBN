local Scene = L2DBN.Scene;
local Rect  = L2DBN.Rect;
local printf = love.graphics.printf;

local BounceRect = Class{__includes = Rect};

function BounceRect:init()
    Rect.init(
        self,
        math.floor(VIRTUAL_WIDTH / 2),
        math.floor(VIRTUAL_HEIGHT / 2),
        100,
        100,
        0.5,
        0.5
    );
    self.speedX = 50;
    self.speedY = 100;
end

function BounceRect:update(dt)
    local nx = self.x + math.floor(self.speedX * dt);
    local ny = self.y + math.floor(self.speedY * dt);

    if nx + self.right > VIRTUAL_WIDTH then
        self.speedX = -self.speedX;
        nx = VIRTUAL_WIDTH - self.right;
    elseif nx + self.left < 0 then
        self.speedX = -self.speedX;
        nx = -self.left;
    end

    if ny + self.bottom > VIRTUAL_HEIGHT then
        self.speedY = -self.speedY;
        ny = VIRTUAL_HEIGHT - self.bottom;
    elseif ny + self.top < 0 then
        self.speedY = -self.speedY;
        ny = -self.top;
    end

    self.x = nx;
    self.y = ny;
end

local DefaultScene = Class{__includes = Scene};

function DefaultScene:init()
    Scene.init(self);
    self.rect = BounceRect();
end

function DefaultScene:update(dt)
    self.rect:update(dt);
end

function DefaultScene:render()
    self.rect:render();
end

return DefaultScene;