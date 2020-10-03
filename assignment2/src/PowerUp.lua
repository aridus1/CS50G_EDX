--[[
    GD50
    Breakout Remake

    -- PowerUp Class --

    Author: Advait Nambiar
    gm2advait@gmail.com

    Represents a powerup that will be generated when the ball
    hits a random brick. It will fall in the world space,and 
    if it lands/ is collected on the paddle, it will have an 
    effect to the game. There are different powerups that will have 
    different effects, and they are chosen at random
]]

PowerUp = Class{}

function PowerUp:init(skin,x,y)
    -- simple positional and dimensional variables
    self.x = x
    self.y = y
    
    self.width = 16
    self.height = 16

    -- this variable is for keeping track of the powerup's 
    -- Y axis, it can move only in one dimension
    self.dy = 32
    self.dx = 0

    if keyValid then
        self.skin = 10
    else
        self.skin = skin
    end

    self.collided = false

    -- this will effectively be the color of our powerup, and we will index
    -- our table of Quads relating to the global block texture using this

    self.visible = true
end

--[[
    function PowerUp:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = 0
    self.dx = 0
    self.dy = 0
end
]]

--[[
    Expects an argument with a bounding box, be that a paddle,
    and returns true if the bounding boxes of this and the argument overlap.
]]
function PowerUp:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end


function PowerUp:update(dt)
    self.y = self.y + self.dy * dt
end



function PowerUp:render()
    -- gTexture is our global texture for all blocks
    -- gPowerUpFrames is a table of quads mapping to each individual ball skin in the texture
    love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin],
        self.x, self.y)
end
