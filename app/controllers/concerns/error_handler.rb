module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  end

  private

  def render_not_found(exception)
    resource_name = exception.model.to_s.titleize

    render json: { error: "#{resource_name} not found" }, status: :not_found
  end
end
