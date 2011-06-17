class FbqueriesController < ApplicationController
  def index
  end

  def create
    @query = CGI.unescape params[:query]
    @result = rest_graph.fql @query
  end
end
