
PlayerPickupState = Class{__includes = BaseState}

function PlayerPickupState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
    self.nextState = 'idle'

    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    local direction = self.player.direction
    if direction == 'left' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x - hitboxWidth
        hitboxY = self.player.y + 2
    elseif direction == 'right' then
        hitboxWidth = 8
        hitboxHeight = 16
        hitboxX = self.player.x + self.player.width
        hitboxY = self.player.y + 2
    elseif direction == 'up' then
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.player.x
        hitboxY = self.player.y - hitboxHeight
    else
        hitboxWidth = 16
        hitboxHeight = 8
        hitboxX = self.player.x
        hitboxY = self.player.y + self.player.height
    end

    self.pickupHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
    self.player:changeAnimation('pickup-' .. self.player.direction)
end

function PlayerPickupState:enter()
    gSounds['lift']:stop()
    gSounds['lift']:play()

    self.player.currentAnimation:refresh()
end

function PlayerPickupState:update(dt)
    for k, object in pairs(self.dungeon.currentRoom.objects) do
        if object.type == 'pot' and object.carried == false and object.destroyed ~= true and object:collides(self.pickupHitbox) then
            object.carried = true
            self.nextState = 'carrying'
            self.objectToHold = object
            break
        end
    end

    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        if self.nextState == 'carrying' then
            self.player:changeState('carrying', {
                carryingObject = self.objectToHold
            })
        else
            self.player:changeState('idle')
        end
    end
end

function PlayerPickupState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

    -- debug for player and hurtbox collision rects
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.pickupHitbox.x, self.pickupHitbox.y,
    --     self.pickupHitbox.width, self.pickupHitbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end