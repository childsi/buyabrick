class PagesController < ApplicationController

  def index
    @wall = Wall.new
  end
end
