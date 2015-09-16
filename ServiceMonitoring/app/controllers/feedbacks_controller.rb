class FeedbacksController < InheritedResources::Base

  def new
  	@feedback = Feedback.new
  	@survey = Survey.find(params[:survey])
  	@questions = @survey.questions
  end

  private

    def feedback_params
      params.require(:feedback).permit(:reference_number, :survey)
    end
end