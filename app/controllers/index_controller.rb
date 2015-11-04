class IndexController < ApplicationController
  def index
  end

  def set_default_response_format
    request.format = :html
  end
end
