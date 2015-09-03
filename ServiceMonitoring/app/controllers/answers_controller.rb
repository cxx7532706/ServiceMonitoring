class AnswersController < InheritedResources::Base


  private

    def answer_params
      params.require(:answer).permit(:survey_id, :question_id, :client_ref, :content)
    end

end

