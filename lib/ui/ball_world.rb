require 'gosu'
require_relative 'circle'

class BallWorld < Gosu::Window
  BOX_WIDTH = 640
  BOX_HEIGHT = 480

  BALLS = []

  def initialize(balls = BALLS)
    super(BOX_WIDTH, BOX_HEIGHT, false)
    @balls = balls
  end

  def update
    @balls.each(&:update)
  end

  def draw
    @balls.each { |ball| draw_ball(ball) }
  end

  def draw_ball(ball)
    ball_img = Gosu::Image.new(self, Circle.new(ball.radius), false)
    ball_img.draw(ball.topleft.x, ball.topleft.y, 0)
  end
end