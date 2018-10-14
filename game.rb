require 'gosu'
require_relative 'snake'
require_relative 'food'

class Game < Gosu::Window
  def initialize
    super 800, 800 #, :fullscreen => true
    self.caption = "Snake Game"
    # @bg = Gosu::Image.new("space.png")
    @font = Gosu::Font.new(15)
    @snake = Snake.new
    @food = Food.new
    # @snake.warp(400, 400)
  end

  def update # called 60 times/sec by default
    @snake.turn('left') if Gosu.button_down?(Gosu::KB_LEFT)
    @snake.turn('right') if Gosu.button_down?(Gosu::KB_RIGHT)
    @snake.turn('up') if Gosu.button_down?(Gosu::KB_UP)
    @snake.turn('down') if Gosu.button_down?(Gosu::KB_DOWN)
    # @snake.accelerate if overlaps with food
    @snake.move
  end

  def draw # usually called 60 times/sec, depends o
    @font.draw("SCORE: #{@snake.ate}", 10, 10, 5, 1.0, 1.0, Gosu::Color::GRAY)
    @snake.draw
    @food.draw
    # @background_image.draw(0, 0, 0)
  end

  def button_down(id)
    id == Gosu::KB_ESCAPE ? close : super
  end

  def check
    if (@food.x..@food.x + @SIZE).cover?(@snake.x || @snake.x + @SIZE) || \
       (@food.y..@food.y + @SIZE).cover?(@snake.y || @snake.y + @SIZE)
      @food.pop
      @food.draw
    end
  end

  # def

  # end
end

Game.new.show # .show() does not return until .close()
