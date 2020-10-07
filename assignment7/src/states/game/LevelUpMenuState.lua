--[[
    GD50
    Pokemon

    Author: Advait Nambiar
    gm2advait@gmail.com
]]

LevelUpMenuState = Class{__includes = BaseState}

function LevelUpMenuState:init(pokemon, stats, onClose)

    --Adv: Select pokemon
    self.pokemon = pokemon
    
    --Adv: fetch the updates on each stats
    self.HPIncrease = stats.HPIncrease
    self.attackIncrease = stats.attackIncrease
    self.defenseIncrease = stats.defenseIncrease
    self.speedIncrease = stats.speedIncrease

    --Adv: get old stats; i.e. difference between new and the update
    self.previousHP = self.pokemon.HP - self.HPIncrease
    self.previousAttack = self.pokemon.attack - self.attackIncrease
    self.previousDefense = self.pokemon.defense - self.defenseIncrease
    self.previousSpeed = self.pokemon.speed - self.speedIncrease

    
    self.onClose = onClose or function() end


    self.statsMenu = Menu{
        x = 0,
        y = VIRTUAL_HEIGHT - 64,
        width = VIRTUAL_WIDTH,
        height = 64,
        showCursor = false,
        font = gFonts['large'],
        items = {
            {
                text = 'HP: ' .. self.previousHP .. ' -> '  .. self.pokemon.HP,
                onSelect = function()
                    self:close()
                end
            },
            {
                text = 'Attack: ' .. self.previousAttack .. ' -> '  .. self.pokemon.attack,
                onSelect = function()
                    self:close()
                end
            },
            {
                text = 'Defense: ' .. self.previousDefense .. ' -> ' .. self.pokemon.defense,
                onSelect = function()
                    self:close()
                end
            },
            {
                text = 'Speed: ' .. self.previousSpeed .. ' -> '  .. self.pokemon.speed,
                onSelect = function()
                    self:close()
                end
            }
        }
    }
end

function LevelUpMenuState:close()
    gStateStack:pop()
    self.onClose()
end

function LevelUpMenuState:update(dt)
    self.statsMenu:update(dt)
end

function LevelUpMenuState:render()
    self.statsMenu:render()
end