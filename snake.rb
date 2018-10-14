require 'gosu'

# Player class
class Snake
  attr_reader :x, :y, :ate

  def initialize(size = 20)
    @SIZE = size
    @color = Gosu::Color::WHITE
    @speed = 3
    @direction = 'right'
    @ate = 0

    @x = @y = 400
    @vel_x = @vel_y = 0
    @body = [{ x: @x, y: @y }]
  end

  def draw
    @body.each { |pos| Gosu.draw_rect(pos[:x], pos[:y], @SIZE, @SIZE, @color) }
  end

  def grow
    @snake.ate += 1
    pos = { x: @x + @SIZE, y: @y + @SIZE }
    @body.push(pos)
  end

  def turn(direction)
    @direction = direction
    @angle = -90 if direction == 'left'
    @angle = 0 if direction == 'up'
    @angle = 90 if direction == 'right'
    @angle = 180 if direction == 'down'

    @vel_x = Gosu.offset_x(@angle, @speed)
    @vel_y = Gosu.offset_y(@angle, @speed)
  end

  def move
    @body.each do |pos|
      pos[:x] += @vel_x
      pos[:y] += @vel_y
      pos[:x] %= 800
      pos[:y] %= 800
    end
  end

  def accelerate
    # OR += TO VEL COORD.
    @speed += 0.1
  end

  def eats?(food) # not accurate at detecting edges!!
    (@x..(@x + @SIZE)).cover?(food.x || food.x + @SIZE) && \
      (@y..(@y + @SIZE)).cover?(food.y || food.y + @SIZE)
  end
end
