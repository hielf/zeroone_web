class Admin::FeedbacksController < Admin::BaseController
  def index
    @feedbacks = Feedback.all
  end

  def destroy
    Feedback.find(params["id"]).destroy
    redirect_to admin_feedbacks_url
  end

  def show
    @feedback = Feedback.find(params[:id])
  end
end