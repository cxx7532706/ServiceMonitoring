class AnswersController < InheritedResources::Base
  before_action :check_signed_in
  before_action :check_admin, except: [:index, :show]

  private

    def answer_params
      params.require(:answer).permit(:survey_id, :question_id, :client_ref, :content)
    end

    def check_signed_in
      redirect_to root_path, alert: 'You need to sign in.' unless user_signed_in?
    end

    def check_admin
      redirect_to root_path, alert: 'Permission denied.' unless user_is_admin?
    end
end

