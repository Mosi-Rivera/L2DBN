require('globals');
local DefaultScene = require('scenes/DefaultScene');

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest',1);

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        -- pixelperfect = true
    });

    push:setBorderColor(0, 0, 0, 1);

    sceneManager = L2DBN.SceneManager({
        --ADD SCENE HERE
        DefaultScene
    });

    love.window.setTitle('__L2DBN__');

    love.keyboard.keysPressed = {};
    love.keyboard.keysReleased = {};
end

function love.resize(w, h)
    push:resize(w, h);
end

function love.mouse.wasClicked()
    if love.mouse.pressed then
        return love.mouse.pressed;
    else
        return false;
    end
end

function love.keyboard.wasPressed(key)
    if (love.keyboard.keysPressed[key]) then
        return true
    else
        return false
    end
end

function love.keyboard.wasReleased(key)
    if (love.keyboard.keysReleased[key]) then
        return true
    else
        return false
    end
end

function love.mousepressed(x,y,button,istouch)
    love.mouse.pressed = { --TODO: FIX
        x / push._SCALE.x + push._OFFSET.x ,
        y / push._SCALE.y + push._OFFSET.y,
        button,
        istouch
    };
end

function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.conf(t)
    t.console = true
end

function love.update(dt)
    sceneManager:update(dt)

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
    love.mouse.pressed = nil;
end

function love.draw()
    push:apply('start');
    --
    sceneManager:render()
    --
    push:apply('end');
end

function love.quit()
    if SaveData then
        SaveManager:save(SaveData.save_file, SaveData);
    end
end