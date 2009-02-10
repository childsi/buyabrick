class PagesController < ApplicationController

  def index
    @wall = Brick.wall
  end
end
