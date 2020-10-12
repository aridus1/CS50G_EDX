--[[
    GD50
    Legend of Zelda
    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.carried = def.carried
    self.projectile = def.projectile
    self.destroyed = def.destroyed
    self.room = def.room

    -- default empty collision callback
    self.onCollide = function() end
end

function GameObject:update(dt)
    if self.range ~= null and self.range > 0 then
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt

        for k, entity in pairs(self.room.entities) do
            if self:collides(entity) then
                entity:damage(1)
                gSounds['hit-enemy']:play()
                self.range = null
                self.destroyed = true
                do return end
            end
        end

        local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE
        if self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE
            or self.x + self.width >= VIRTUAL_WIDTH - TILE_SIZE * 2
            or self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.height / 2
            or self.y + self.height >=  VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE
            then
            gSounds['hit-enemy']:play()
            self.range = null
            self.destroyed = true
            do return end
        end

        if(math.sqrt(math.pow(self.initialThrownX - self.x, 2) + math.pow(self.initialThrownY - self.y, 2))) > self.range then
            gSounds['hit-enemy']:play()
            self.range = null
            self.destroyed = true
        end
    end
end

function GameObject:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
        self.y + self.height < target.y or self.y > target.y + target.height)
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    if(self.states ~= null) then
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
            self.x + adjacentOffsetX, self.y + adjacentOffsetY)
    else
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame],
            self.x + adjacentOffsetX, self.y + adjacentOffsetY)
    end
end

function GameObject:fire(dx, dy, range)
    self.dx = dx
    self.dy = dy
    self.range = range
    self.initialThrownX = self.x
    self.initialThrownY = self.y
    end