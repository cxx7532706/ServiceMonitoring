class QuestionsController < InheritedResources::Base

  private

    def question_params
      params.require(:question).permit(:q_type, :language, :title, :options, :create_date)
    end
end

