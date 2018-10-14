require 'gosu'

class Snake
  attr_reader :x, :y
  attr_writer :ate
  def initialize
    @SIZE = 20
    @x = @y = 400
    @vel_x = @vel_y = @angle = 0
    @ate = 1
  end

  def turn(direction)
    case direction
    when "left"
      @angle = -90
    when "up"
      @angle = 0
    when "right"
      @angle = 90
    when "down"
      @angle = 180
    end
    @vel_x = Gosu.offset_x(@angle, 3)
    @vel_y = Gosu.offset_y(@angle, 3)
  end

  # def accelerate # accelerate if snake eats a red block, WORKS B/C += TO COORD.
    # @vel_x += Gosu.offset_x(@angle, 0.5) # .offset_x(theta, diagonal dist travelled)
    # @vel_y += Gosu.offset_y(@angle, 0.5) # positive = down
  # end

  def move
    @x += @vel_x
    @y += @vel_y
    # @x %= 800 # SO DOESN'T EXCEED WINDOW BORDER
    # @y %= 800
    # @vel_x *= 0.5
    # @vel_y *= 0.5
  end

  def draw
    Gosu.draw_rect(@x, @y, @SIZE, @SIZE, Gosu::Color::WHITE)
  end

end
