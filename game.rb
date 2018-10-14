require 'gosu'
require_relative 'snake'
require_relative 'food'

# Main window for Snake game
class Game < Gosu::Window
  def initialize
    @SCREEN = 800
    super(@SCREEN, @SCREEN)
    self.caption = 'Snake Game'

    @font = Gosu::Font.new(15)
    @snake = Snake.new
    @food = Food.new

    @status = ["SCORE: #{@snake.ate}", true]
  end

  def button_down(id)
    id == Gosu::KB_ESCAPE ? close : super
  end

  def update
    @snake.turn('left') if Gosu.button_down?(Gosu::KB_LEFT) && @snake.dir != 'right'
    @snake.turn('right') if Gosu.button_down?(Gosu::KB_RIGHT) && @snake.dir != 'left'
    @snake.turn('up') if Gosu.button_down?(Gosu::KB_UP) && @snake.dir != 'down'
    @snake.turn('down') if Gosu.button_down?(Gosu::KB_DOWN) && @snake.dir != 'up'

    @status = ["OUCH! YOU BIT YOURSELF! Try again :)", false] if @snake.bites_self?

    if @snake.eats?(@food)
      @food.pop
      @snake.grow
      @snake.accelerate
    end

    @snake.move
  end

  def draw
    if @status[1]
      @font.draw_text(@status[0], 10, 10, 5, 1.0, 1.0, Gosu::Color::GRAY)
      @snake.draw
      @food.draw
    else
      @font.draw_text(@status[0], @SCREEN / 3, @SCREEN / 3, 5, 1.0, 1.0, Gosu::Color::RED)
    end
  end
end

Game.new.show
