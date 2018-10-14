require 'gosu'

class Food
  attr_reader :x, :y
  def initialize(color = Gosu::Color::YELLOW)
    @SIZE = 20
    @x = rand(39) * @SIZE
    @y = rand(39) * @SIZE
    @color = color
  end

  def pop
    @x += rand(49) * @SIZE % 800
    @y += rand(49) * @SIZE % 800
  end

  def draw
    Gosu.draw_rect(@x, @y, @SIZE, @SIZE, @color)
  end
end
