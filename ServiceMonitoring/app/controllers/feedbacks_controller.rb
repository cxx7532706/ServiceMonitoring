class FeedbacksController < InheritedResources::Base

  def new
  	#Create a new feedback
  	@feedback = Feedback.new
  	#Get the questions for the feedback
  	@survey = Survey.find(params[:survey])
  	@questions = @survey.questions
  end

  private

    def feedback_params
      params.require(:feedback).permit(:reference_number, :survey)
    end
end