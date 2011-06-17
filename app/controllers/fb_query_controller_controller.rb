class FbQueryControllerController < ApplicationController
  include RestGraph::RailsUtil

  def index
    if params[:query]
      query = CGI.unescape params[:query]
      @result = rest_graph.fql query
    end
  end
end
