require 'gosu'
require_relative 'snake'
require_relative 'food'

# Main window for Snake game
class Game < Gosu::Window
  def initialize
    super 800, 800
    self.caption = 'Snake Game'
    @font = Gosu::Font.new(15)
    @snake = Snake.new
    @food = Food.new
  end

  def button_down(id)
    id == Gosu::KB_ESCAPE ? close : super
  end

  def update
    @snake.turn('left') if Gosu.button_down?(Gosu::KB_LEFT) && @snake.dir != 'right'
    @snake.turn('right') if Gosu.button_down?(Gosu::KB_RIGHT) && @snake.dir != 'left'
    @snake.turn('up') if Gosu.button_down?(Gosu::KB_UP) && @snake.dir != 'down'
    @snake.turn('down') if Gosu.button_down?(Gosu::KB_DOWN) && @snake.dir != 'up'

    if @snake.eats?(@food)
      @food.pop
      @snake.grow
      @snake.accelerate
    end

    @snake.move
  end

  def draw
    @font.draw_text("SCORE: #{@snake.ate}", 10, 10, 5, 1.0, 1.0, Gosu::Color::GRAY)
    @snake.draw
    @food.draw
  end
end

Game.new.show # .show() does not return until .close()
