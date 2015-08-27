require_relative '../ui/ball_world'

class Bouncing
  MOVEMENT_SPEED = 12
  UP = -1
  DOWN = 1

  def initialize(direction)
     @direction = direction
  end

  def attach_ball(ball)
    @ball = ball
  end

  def update()
    @direction = reverse_direction_if_necessary
    @ball.center_y = move
  end

  private
  def reverse_direction_if_necessary
    moving_too_high || moving_too_low ? switch_direction : @direction
  end

  def switch_direction
    @direction * -1
  end

  def moving_too_low
    @ball.center_y + @ball.radius >= BallWorld::BOX_HEIGHT && moving_down
  end

  def moving_down
    @direction == DOWN
  end

  def moving_too_high
    @ball.center_y - @ball.radius <= 0 && moving_up
  end

  def moving_up
    @direction == UP
  end

  def move
    @ball.center_y + MOVEMENT_SPEED * @direction
  end
end