class FbQueryControllerController < ApplicationController
  include RestGraph::RailsUtil
  before_filter :setup

  def index
    if params[:query]
      query = CGI.unescape params[:query]
      @result = rest_graph.fql query
    end
  end
private
  def setup
    rest_graph_setup(
      :app_id => '219508714739118',
      :canvas => 'Pocbuque',
      :auto_authorize_scope => 'email',
      :secret => '00355ed7f4190c450e4b0d8e5a700084'
    )
  end
end
