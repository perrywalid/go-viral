class ApplicationController < ActionController::API
  include Graphiti::Rails::Responders
  before_action :authenticate_user!
end
