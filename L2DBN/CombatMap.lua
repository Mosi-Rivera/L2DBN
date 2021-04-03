local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or "";
local Class         = require(_PACKAGE..'/Class');
local CombatMap = Class{};

function CombatMap:init(config)
    self.board          = {};
    self.width          = config.width;
    self.height         = config.height;
    self.tileWidth      = config.tileWidth;
    self.tileHeight     = config.tileHeight;
    self.scene          = config.scene;
    self.tile_padding   = config.padding;
    local CombatTile    = config.CombatTile;

    for i = 1, self.width * self.height do
        table.insert(self.board,CombatTile(
            self,
            (i - 1) % width + 1,
            (i - 1) / width + 1
        ));
    end
end

function CombatMap:render()
    for i = 1, #self.board do
        self.board[i]:render();
    end
end

function CombatMap:update(dt)
    for i = 1, #self.board do
        self.board[i]:update(dt);
    end
end

return CombatMap;