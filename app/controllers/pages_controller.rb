class PagesController < ApplicationController
  def index
    response.headers['Cache-Control'] = 'public, max-age=300'
    @wall = Wall.new
  end
end
