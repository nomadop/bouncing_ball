require_relative 'ui/ball_world'
require_relative 'model/ball_factory'

balls = BallFactory.all

ball_world = BallWorld.new(balls)
ball_world.show