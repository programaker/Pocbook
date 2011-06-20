class ApplicationController < ActionController::Base
  include RestGraph::RailsUtil
  protect_from_forgery
  before_filter :setup
private
  def setup
    rest_graph_setup(
      :app_id => '219508714739118',
      :canvas => 'Pocbuque',
      :auto_authorize_scope => 'email,user_photos,friends_photos,publish_stream',
      :secret => '00355ed7f4190c450e4b0d8e5a700084'
    )
  end
end
