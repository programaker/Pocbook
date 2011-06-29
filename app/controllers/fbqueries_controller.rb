class FbqueriesController < ApplicationController
  def index
    @query = params[:query]
  end

  def create
    if params[:query]
      @query = CGI.unescape params[:query]
      @result = rest_graph.fql @query
    end
  end
end
