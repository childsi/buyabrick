desc 'Generate 100 random bricks'
task :generate_bricks => :environment do
  100.times { Brick.create!(BrickForgery.brick_params) }
end