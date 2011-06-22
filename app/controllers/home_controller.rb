class HomeController < ApplicationController
  def index
    
  end

  def index_via_post
    render :action => 'index'
  end
end
