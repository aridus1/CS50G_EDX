
PlayerCarryingState = Class{__includes = BaseState}

function PlayerCarryingState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon

    self.entity:changeAnimation('pot-walk-' .. self.entity.direction)
end

function PlayerCarryingState:enter(params)
    self.objectHeld = params.carryingObject
    self.entity.currentAnimation:refresh()
end

function PlayerCarryingState:update(dt)
    local doNotMove = false
    if love.keyboard.isDown('left') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('pot-walk-left')
    elseif love.keyboard.isDown('right') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('pot-walk-right')
    elseif love.keyboard.isDown('up') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('pot-walk-up')
    elseif love.keyboard.isDown('down') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('pot-walk-down')
    else
        self.entity:changeAnimation('pot-hold-'.. self.entity.direction)
        doNotMove = true
    end

    if doNotMove == false then
        EntityWalkState.update(self, dt)
    end

    if(self.objectHeld ~= null) then
        self.objectHeld.x = self.entity.x
        self.objectHeld.y = self.entity.y - self.objectHeld.height + 2
    end


    if love.keyboard.wasPressed('e') then
        self.objectHeld.x = self.entity.x
        self.objectHeld.y = self.entity.y

        if(self.entity.direction == 'left') then
            self.objectHeld:fire(-POT_THROW_SPEED, 0, TILE_SIZE * 4)
        elseif(self.entity.direction == 'right') then
            self.objectHeld:fire(POT_THROW_SPEED, 0, TILE_SIZE * 4)
        elseif(self.entity.direction == 'up') then
            self.objectHeld:fire(0, -POT_THROW_SPEED, TILE_SIZE * 4)
        elseif(self.entity.direction == 'down') then
            self.objectHeld:fire(0, POT_THROW_SPEED, TILE_SIZE * 4)
        end
        self.objectHeld.carried = false
        self.objectHeld = nil

        self.entity:changeState('idle')
    end
end

function PlayerCarryingState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end