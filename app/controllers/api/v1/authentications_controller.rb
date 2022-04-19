module Api
  module V1
    class AuthenticationsController < ApplicationController
    rescue_from ActionController::ParameterMissing, with: :parameter_missing

      def create
        params.require(:username)
        params.require(:password)
        render json: { token: "1234"}, status: :created
      end

      private

      def parameter_missing(error)
        render json: { error: error.original_message }, status: :unprocessable_entity
      end
    end
  end
end