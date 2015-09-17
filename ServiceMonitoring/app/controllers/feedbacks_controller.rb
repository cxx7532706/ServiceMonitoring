class FeedbacksController < InheritedResources::Base


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
        format.html { redirect_to @feedback, notice: 'Feedback was successfully created.' }
        format.json { render json: @feedback, status: :created, location: @feedback }
      else
        format.html { render action: "new" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def feedback_params
      params.require(:feedback).permit(:reference_number, :survey, :answers_attributes => [:content])
    end
end