class QuestionsController < InheritedResources::Base


    def question_params
      params.require(:question).permit(:q_type, :language, :title, :options, :create_date)
    end

    def list_answers
    	@question = Question.find(params[:question_id]).title
    	@answers = Answer.where(:question_id => params[:question_id])
    end
end

