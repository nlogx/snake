require 'gosu'

# Player class
class Snake
  attr_reader :x, :y, :ate, :dir

  def initialize(size = 20)
    @SIZE = size
    @color = Gosu::Color::WHITE
    @ate = 0
    @speed = 3

    @vel_x = 3
    @vel_y = 0
    @dir = ''
    @body = [{ x: 400, y: 400, dir: @dir }]
  end

  def draw
    @body.each { |pos| Gosu.draw_rect(pos[:x], pos[:y], @SIZE, @SIZE, @color, 10) }
  end

  def grow
    @ate += 1
    d = @body.last[:dir]
    pos = { x: @body[-1][:x] + @SIZE, y: @body[-1][:y] } if d == 'left'
    pos = { x: @body[-1][:x], y: @body[-1][:y] + @SIZE } if d == 'up'
    pos = { x: @body[-1][:x] - @SIZE, y: @body[-1][:y] } if d == 'right'
    pos = { x: @body[-1][:x], y: @body[-1][:y] - @SIZE } if d == 'down'
    @body.push(pos)
  end

  def turn(dir)
    @dir = dir unless @ate.zero?

    @vel_x, @vel_y = -@speed, 0 if dir == 'left'
    @vel_x, @vel_y = 0, -@speed if dir == 'up'
    @vel_x, @vel_y = @speed, 0 if dir == 'right'
    @vel_x, @vel_y = 0, @speed if dir == 'down'
  end

  def move
    x = @body.first[:x] + @vel_x
    y = @body.first[:y] + @vel_y
    x %= 800
    y %= 800

    @body.unshift({ x: x, y: y })
    @body.pop
  end

  def accelerate
    # OR += TO VEL COORD.
    @speed += 0.1
  end

  def eats?(food)
    x = @body.first[:x]
    y = @body.first[:y]
    ((x..(x + @SIZE)).cover?(food.x) || (x..(x + @SIZE)).cover?(food.x + @SIZE)) \
    && ((y..(y + @SIZE)).cover?(food.y) || (y..(y + @SIZE)).cover?(food.y + @SIZE))
  end
end
