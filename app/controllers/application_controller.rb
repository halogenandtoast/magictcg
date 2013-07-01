class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  before_filter :require_login
end
