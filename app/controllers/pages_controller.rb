class PagesController < ApplicationController
  def index
    response.headers['Cache-Control'] = 'public, max-age=30'
    @wall = Wall.new
  end
end
