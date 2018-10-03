class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def not_found
    raise ActiveRecord::RecordNotFound, t(:not_found)
  rescue StandardError
    render :json => {"status" => "404", "message" => "Todo with id #{params[:id]} not found"}
    return
  end
end
