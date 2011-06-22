class HomeController < ApplicationController
  def index
    
  end

  def index_via_post
    # quando acessamos a app pelo atalho no facebook, ele manda um POST
    # então preciso de outro root_path, porem via post, que também acesse o index
    render :action => 'index'
  end
end
