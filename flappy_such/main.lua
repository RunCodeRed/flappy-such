function love.load()
    --player values
    player = {}
    player.x = 40
    player.y = 300
    player.width = 64
    player.height = 64
    player.gravity = 300
    player.up = 4000

    --game window
    gameWindow = {}

    --upper pipe values
    upperPipe = {}
    upperPipe.x = 400
    upperPipe.y = love.math.random(-350,-150)
    upperPipe.width = 60
    upperPipe.height = 500
    upperPipe.speed = 250

    --lower pipe values
    lowerPipe = {}
    lowerPipe.x = 400
    lowerPipe.y = love.math.random(450, 650)
    lowerPipe.width = 60
    lowerPipe.height = 500
    lowerPipe.speed = 250

    --score
    scoreBoard = 0

    --game state
    gameOver = false
end



--function for player gravity
function playerGravity(dt)
    player.y = player.y + (player.gravity * dt)
end



--function for drawing pipes
function drawPipes()
    love.graphics.setColor(0, 1, 0) --makes pipe colors green

    --draws the pipes
    love.graphics.rectangle("fill", upperPipe.x, upperPipe.y, upperPipe.width, upperPipe.height)
    love.graphics.rectangle("fill", lowerPipe.x, lowerPipe.y, lowerPipe.width, lowerPipe.height)
end



--function for moving pipes
function movePipes(dt)
    upperPipe.x = upperPipe.x - (upperPipe.speed * dt)
    lowerPipe.x = lowerPipe.x - (lowerPipe.speed * dt)
end



function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1<x2+w2 and
    x2< x1 + w1 and
    y1<y2+h2 and
    y2<y1+h1
end



function love.update(dt)
    --gravity
    playerGravity(dt)

    --moves pipes
    movePipes(dt)

    --player jumping ability
    function love.keypressed()
        if love.keyboard.isDown("space") then
            player.y = player.y - (player.up * dt)
        end
    end

    --checks collision for upper pipes
    if checkCollision(player.x, player.y, player.width, player.height, upperPipe.x, upperPipe.y, upperPipe.width, upperPipe.height) then
        gameOver = true
    end

    --checks collisions on lower pipes
    if checkCollision(player.x, player.y, player.width, player.height, lowerPipe.x, lowerPipe.y, lowerPipe.width, lowerPipe.height) then
        gameOver = true
    end

   --gets game window height and width
    gameWindow.height = love.graphics.getHeight()
    gameWindow.width = love.graphics.getWidth()

    --makes so the player cant leave game window up or down
    player.y = math.min(math.max(0,player.y),gameWindow.height - player.height)
end



function love.draw()
    --draws pipes
    drawPipes()
    if upperPipe.x < -60 and lowerPipe.x < -60 then
        upperPipe.y = love.math.random(-350,-150)
        lowerPipe.y = love.math.random(450, 650)
        upperPipe.x = 400
        lowerPipe.x = 400
        drawPipes()
        scoreBoard = scoreBoard + 1 --score board calculations
    end

    --creates player
    love.graphics.setColor(1, 1, 0) --makes bird color yellow
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

    --draws score board
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(scoreBoard, 30, 30, 0, 10)

    if gameOver == true then --game over screen gg
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0,0, 390, 844)
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("GAME",10, 30, 0, 5)
        love.graphics.print("OVER",10, 150, 0, 5)
        love.graphics.print("LOSER",10, 270, 0, 5)
    end
end
