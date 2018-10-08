class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  
  before_action :authorize_request
  attr_reader :current_user

  def not_found
    raise ActiveRecord::RecordNotFound, t(:not_found)
  rescue StandardError
    render :json => {"status" => "404", "message" => "Todo with id #{params[:id]} not found"}
    return
  end

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
