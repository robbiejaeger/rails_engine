class ApplicationController < ActionController::API

  def query_params
    request.query_parameters
  end
end
