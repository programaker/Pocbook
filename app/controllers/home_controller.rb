class HomeController < ApplicationController
  def index
    rest_graph.get('me')
  end

  def store_token
    render :action => 'index'
  end
end
