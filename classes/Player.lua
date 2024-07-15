Player = Class{
    init = function ()
        Signal.register('move', function(direction)
            if direction == 'left' then
                Player.acceleration = Player.acceleration - Player.acceleration_step
                Player.velocity.x = math.max(Player.velocity.x + Player.acceleration, -Player.max_velocity)
            elseif direction == 'right' then
                Player.acceleration = Player.acceleration - Player.acceleration_step
                Player.velocity.x = math.min(Player.velocity.x - Player.acceleration, Player.max_velocity)
            end
        end)
        Signal.register('jump', function()
            if Player.isOnGround then
                Player.isJumping = true
                Player.isOnGround = false
            end
        end)
    end,
    speed_modifier = 30,
    
    velocity = Vector.zero,
    max_velocity = 100,

    acceleration = 0,
    acceleration_step = 0.2,
    max_acceleration = 10,

    drag = 10,

    position = Vector.new(100, 100),

    ground = 600,
    jumpPower = 70,
    gravity = 500,

    isJumping = false,
    isOnGround = false
}

function Player:update(dt)
    if Player.isJumping then
        Player.velocity.y = Player.velocity.y - Player.jumpPower
        Player.isJumping = false
    end

    if Player.position.y == Player.ground then
        Player.isOnGround = true
    end

    Player.velocity.y = Player.velocity.y + (Player.gravity * dt)

    Player.velocity = Player.velocity * (1 - math.min(dt * Player.drag, 1))
    Player.acceleration = Player.acceleration * 0.66
    
    Player.position.x = Player.position.x + (Player.velocity.x * Player.speed_modifier * dt)
    Player.position.y = math.min(Player.position.y + (Player.velocity.y * Player.speed_modifier * dt), Player.ground)
end

function Player:draw()
    love.graphics.rectangle("fill", self.position.x, self.position.y, 50, 50)
end