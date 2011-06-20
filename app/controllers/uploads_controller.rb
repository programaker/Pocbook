class UploadsController < ApplicationController
  def index
    rest_graph.get('me')
  end

  def create
    @access_token = rest_graph.access_token
  end
end
