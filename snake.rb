require 'gosu'
require_relative 'block'

# Player class
class Snake
  attr_reader :x, :y, :ate, :dir

  def initialize(screen = 800)
    @SCREEN = screen
    @SIZE = 20
    @color = Gosu::Color::WHITE
    @ate = 0
    @speed = 3

    @vx = @vy = 0
    @dir = ''
    @body = [Block.new(@SCREEN / 2, @SCREEN / 2)]
  end

  def draw
    @body.each { |block| Gosu.draw_rect(block.x, block.y, @SIZE, @SIZE, @color, 10) }
  end

  def grow
    @ate += 1
    d = @body.last.dir
    x, y = @body[-1].x + @SIZE, @body[-1].y if d == 'left'
    x, y = @body[-1].x, @body[-1].y + @SIZE if d == 'up'
    x, y = @body[-1].x - @SIZE, @body[-1].y if d == 'right'
    x, y = @body[-1].x, @body[-1].y - @SIZE if d == 'down'
    @body.push(Block.new(x, y, d))
  end

  def turn(dir)
    @dir = dir unless @ate.zero?

    @vx, @vy = -@speed, 0 if dir == 'left'
    @vx, @vy = 0, -@speed if dir == 'up'
    @vx, @vy = @speed, 0 if dir == 'right'
    @vx, @vy = 0, @speed if dir == 'down'
  end

  def move
    x = @x + @vx
    y = @y + @vy
    x %= @SCREEN
    y %= @SCREEN

    @body.unshift(Block.new(x, y, @dir))
    @body.pop
  end

  def accelerate
    # OR += TO VEL COORD.
    @speed += 0.1 if (@ate % 5).zero?
  end

  def eats?(food)
    @x, @y = @body.first.x, @body.first.y
    ((@x...(@x + @SIZE)).cover?(food.x) || (@x...(@x + @SIZE)).cover?(food.x + @SIZE)) \
    && ((@y...(@y + @SIZE)).cover?(food.y) || (@y...(@y + @SIZE)).cover?(food.y + @SIZE))
  end

  def bites_self?
    @body[1...-1].any? { |part| @body.last.x == part.x && @body.last.y == part.y }
  end
end
