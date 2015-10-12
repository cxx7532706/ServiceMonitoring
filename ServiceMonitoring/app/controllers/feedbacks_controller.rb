class FeedbacksController < InheritedResources::Base
  before_action :check_signed_in
  before_action :check_admin, :except => [:index, :show]

	def new
  	#Create a new feedback
  	@feedback = Feedback.new
    answer = @feedback.answers.build
  	#Get the questions for the feedback
  	@survey = Survey.find(params[:survey])
  	@questions = @survey.questions
  end

  def create
    @feedback = Feedback.new(feedback_params)



    respond_to do |format|
      if @feedback.save

          @chosen_ops = params[:chosen_ops]
          @answers = @feedback.answers
          @survey = Survey.find(@feedback.survey_id)
          @questions = @survey.questions
          @questions.each do |question|
            if question.q_type == '2'
              question.question_options.each do |option|
                @chosen_ops.each do |chosen_op|
                  if option.id.to_s == chosen_op.to_s
                    @feedback.answers.create(:survey_id => @survey.id, :question_id => question.id, :content => chosen_op)
                  end
                end
              end
            end
          end

        format.html { redirect_to @feedback, notice: 'Feedback was successfully created.' }
        format.json { render json: @feedback, status: :created, location: @feedback }
      else
        format.html { render action: "new" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end



  def update
    @ops = params[:chosen_ops]
    
    
  end


  def show

  @feedback = Feedback.find(params[:id])
	@survey = Survey.find(@feedback.survey_id) 
	@answers = @feedback.answers

  end

  def destroy
  	@feedback = Feedback.find(params[:id])
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to @feedback, notice: 'Feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

    def feedback_params
      params.require(:feedback).permit(:id, :reference_number, :survey_id, :answers_attributes => [:survey_id, :question_id, :content, :all])
    end

    def check_signed_in
      redirect_to root_path, alert: 'You need to sign in.' unless user_signed_in?
    end

    def check_admin
      redirect_to root_path, alert: 'Permission denied.' unless user_is_admin?
    end
end
