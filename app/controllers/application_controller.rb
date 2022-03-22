class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed

  private

  def record_not_destroyed(exception)
    render :json, { errors: exception.record.errors}, status: :unprocessable_entity
  end
end
