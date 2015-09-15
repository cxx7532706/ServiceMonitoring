class FeedbacksController < InheritedResources::Base

  def new
  	@survey = Survey.find_by(id=>params[:survey])
  	@questions = @survey.questions
  end

  private

    def feedback_params
      params.require(:feedback).permit(:reference_number, :survey)
    end
end