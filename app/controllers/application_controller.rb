class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_action :set_default_response_format

  def set_default_response_format
    request.format = :json
  end
end
