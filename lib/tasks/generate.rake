desc 'Generate 100 random bricks'
task :generate_bricks => :environment do
  100.times do 
    b = Brick.create(BrickForgery.brick_params)
    p b.errors unless b.valid?
  end
end