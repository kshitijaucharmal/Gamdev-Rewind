-- Import the Player module


function Ghost(x, y, world)
    local ghost = {}

    -- all players position
    ghost.all_pos = {}
    ghost.posCounter = 0

    ghost.debug = false

    -- Properties
    ghost.width = player.width
    ghost.height = player.height
    ghost.scaleX = (player.width / assets.tileSize) * 2 -- Mirrored horizontally
    ghost.scaleY = 32 / assets.tileSize

    -- flipped
    ghost.flipped = true

    -- Physics setup
    ghost.body = love.physics.newBody(world, x, y, "dynamic")
    ghost.shape = love.physics.newRectangleShape(ghost.width, ghost.height)
    ghost.fixture = love.physics.newFixture(ghost.body, ghost.shape)
    ghost.fixture:setUserData("Ghost")
    ghost.fixture:setFriction(0)
    ghost.body:setFixedRotation(true)
    ghost.fixture:setMask(5)

    -- Speed for automatic movement


    --to store pos of player every frame
    function ghost.storePos(self)
        local playerPos = { player.body:getX(), player.body:getY() }
        table.insert(self.all_pos, playerPos)

        --here posCounter will inc when we store the positions
        self.posCounter = self.posCounter + 1
    end

    --to set pos of player every frame
    function ghost.setPos(self)
        if self.posCounter <= 0 then
            return
        end

        --as here first index is x then y
        ghost.body:setPosition(ghost.all_pos[self.posCounter][1], ghost.all_pos[self.posCounter][2])

        --posCounter will dec as we retrive the positions
        self.posCounter = self.posCounter - 1
    end

    function ghost.draw(self)
        -- position
        x = self.body:getX() - self.width
        y = self.body:getY() - 32 * 0.5

        local scaleX = self.scaleX
        -- Decide orientation
        if self.flipped then
            x = self.body:getX() + self.width
            scaleX = -self.scaleX
        end

        -- Draw Ghost sprite Sprite
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.draw(assets.tileset, assets.ghost, x, y, 0, scaleX, self.scaleY)
        love.graphics.setColor(1, 1, 1)

        -- Draw hitbox
        if self.debug then
            love.graphics.setColor(0, 0, 1)
            love.graphics.circle("line", self.body:getX(), self.body:getY(), self.shape:getRadius())
            love.graphics.setColor(1, 1, 1)
        end
    end

    return ghost
end

return Ghost
