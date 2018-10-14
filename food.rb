require 'gosu'

class Food
  attr_reader :x, :y
  def initialize(color = Gosu::Color::YELLOW)
    @SIZE = 20
    @POS = 800 / @SIZE
    @eaten = 0
    @color = color
    new_pos
  end

  def new_pos
    @eaten += 1
    @x, @y = rand(@POS) * @SIZE, rand(@POS) * @SIZE
  end

  def draw
    @color = Gosu::Color::AQUA if @eaten > 5
    @color = Gosu::Color::GREEN if @eaten > 8
    Gosu.draw_rect(@x, @y, @SIZE, @SIZE, @color)
  end
end
