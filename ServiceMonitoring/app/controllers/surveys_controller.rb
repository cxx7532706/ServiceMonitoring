class SurveysController < ApplicationController
  before_action :check_signed_in
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, except: [:index]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.all
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
    1.times do
      question = @survey.questions.build
      4.times { question.question_options.build }
    end
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def excel
    @survey = Survey.find(params[:id])
    respond_to do |format|  
    format.xls {   
      send_data(xls_content_for(@survey),  
                :type => "text/excel; charset=utf-8; header=present",  
                :filename => "Report_Survey(#{@survey.name})_#{Time.now.strftime("%Y%m%d")}.xls")  
    }  
    format.html  {redirect_to surveys_url, notice: "Report export successful!"}
    end  
  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:id, :name, :reference_number, :version, :enable_flg, :provider_name, :language_avaliable, :format,
        questions_attributes: 
        [:id, :q_type, :title, :_destroy, 
          question_options_attributes: 
            [:id, :option, :_destroy]
        ])
    end

    def check_signed_in
      redirect_to root_path, alert: 'You need to sign in.' unless user_signed_in?
    end

    def check_admin
      redirect_to root_path, alert: 'Permission denied.' unless user_is_admin?
    end

    def xls_content_for(obj)
      xls_report = StringIO.new  
      book = Spreadsheet::Workbook.new  
      @answers = Answer.all
      sheet1 = book.create_worksheet :name => "Survey"  
        
      blue = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 10  
      sheet1.row(0).default_format = blue  
      
      sheet1.row(0).concat %w{Question Type Answers}  
      count_row = 1  
      obj.questions.each do |question|  
        sheet1[count_row,0] = question.title
        if question.q_type == '1' 
          sheet1[count_row,1] = "Single Answer Mutiple Choises" 
        elsif question.q_type == '2' 
          sheet1[count_row,1] = "Mutiple Answers Mutiple CHoises"
        elsif question.q_type == '3' 
          sheet1[count_row,1] = "Text"
        end
        option_number = 1;
        question.question_options.each do |option|
          option_number += 1
          answer_number = 0
          @answers.each do |answer|
            if option.id == answer.content.to_i
              answer_number += 1
            end
          end
          sheet1[count_row,option_number] = "#{option.option}(#{answer_number.to_s})"
        end
        option_number = 1;
        if question.q_type == '3'
          @answers.each do |answer|
            if answer.question_id == question.id
              option_number += 1
              sheet1[count_row,option_number] = answer.content
            end
          end
        end
        count_row += 1
      end
      
      book.write xls_report  
      xls_report.string  
    end

  end
