class QuestionsController < InheritedResources::Base
	def create
		@survey = Survey.find(params[:survey_id])
    	@question = @survey.questions.create(question_params)
      flash[:success] = "Add one question"
    	redirect_to survey_path(@survey)
  	end

  	def destroy
    	@survey = Survey.find(params[:survey_id])
    	@question = @survey.questions.find(params[:id])
    	@question.destroy
    	redirect_to survey_path(@survey)
  	end
  private

    def question_params
      params.require(:question).permit(:q_type, :survey_id, :created_at, :updated_at, :survey_id)
    end
end

