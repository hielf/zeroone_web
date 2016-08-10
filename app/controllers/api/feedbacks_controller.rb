class Api::FeedbacksController < Api::BaseController
  def create
    @feedback = current_user.feedbacks.build(content: params[:content])
    if @feedback.save
      render nothing: true, status: 201
    else
      return api_error(status: 422)
    end
  end
end