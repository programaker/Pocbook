class FbqueriesController < ApplicationController
  def index
    # esta requisição é apenas para gerar aquele redirect de autorização
    # ele, por sua vez, vai gerar um POST com a mesma url do form, com os mesmos parametros
    # esse POST vai cair na action create e aí sim vai exibir os resultados na página!
    # a requisição só pode ser feita se o parametro estiver presente, pra não estragar o 'back' na pagina de resultados
    rest_graph.get('me') if params[:query]
  end

  def create
    if params[:query]
      @query = CGI.unescape params[:query]
      @result = rest_graph.fql @query
    end
  end
end
