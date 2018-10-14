require 'gosu'

class Food
  attr_reader :x, :y
  def initialize
    @SIZE = 20
    @POS = 800 / @SIZE
    @color = Gosu::Color::YELLOW
    @eaten = 0
    pop
  end

  def pop
    @eaten += 1
    @x, @y = rand(@POS) * @SIZE, rand(@POS) * @SIZE
  end

  def draw
    @color = Gosu::Color::AQUA if @eaten > 5
    @color = Gosu::Color::GREEN if @eaten > 8
    Gosu.draw_rect(@x, @y, @SIZE, @SIZE, @color)
  end
end
