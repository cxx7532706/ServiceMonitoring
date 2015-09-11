class QuestionByLanguagesController < InheritedResources::Base

  private

    def question_by_language_params
      params.require(:question_by_language).permit(:language, :title, :options, :created_at, :updated_at, :question_id)
    end
end

