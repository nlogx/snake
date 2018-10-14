require 'gosu'
require 'prime'

class Food
  attr_reader :x, :y
  def initialize(screen = 800)
    @SCREEN = screen
    @SIZE = 20
    @POS = @SCREEN / @SIZE
    @color = Gosu::Color::YELLOW
    @eaten = 0
    pop
  end

  def pop
    @eaten += 1
    @x, @y = rand(@POS) * @SIZE, rand(@POS) * @SIZE
  end

  def draw
    @eaten.prime? ? @color = Gosu::Color::BLUE : @color = Gosu::Color::YELLOW
    Gosu.draw_rect(@x, @y, @SIZE, @SIZE, @color)
  end
end
