module ExceptionHandler
  extend ActiveSupport::Concern
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError,
      with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({message: e.message}, :not_found)
    end
  end

  def four_twenty_two example
    json_response({message: example.message}, :unprocessable_entity)
  end

  def unauthorized_request example
    json_response({message: example.message}, :unauthorized)
  end
end
