class SurveysController < ApplicationController
  before_action :check_signed_in
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, except: [:index, :show, :generate_url]

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
    @survey.version = "1"
    @survey.enable_flg = "1"

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
      if params[:id] == '1'
        if @survey.update(survey_params)
          format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
          format.json { render :show, status: :ok, location: @survey }
        else
          format.html { render :edit }
          format.json { render json: @survey.errors, status: :unprocessable_entity }
        end
      else
        Survey.where(name: params[:survey][:name]).each do |survey2|
          survey2.enable_flg = "0"
          survey2.save
        end
        survey1 = Survey.where(name: params[:survey][:name]).order(version: :desc).first
        @survey = Survey.new(survey_params_update)
        @survey.version = survey1.version.to_i + 1
        @survey.enable_flg = "1"
        if @survey.save
          format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
          format.json { render :show, status: :ok, location: @survey }
        else
          format.html { render :edit }
          format.json { render json: @survey.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    if @survey.id == 1
      redirect_to surveys_url, alert: 'General Survey cannot be destroyed'
    else
      @survey.destroy
      respond_to do |format|
        format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def generate_url
    @generate_url = request.protocol + request.raw_host_with_port + "/feedbacks/new?survey=" + params[:id]
    @survey = Survey.find(params[:id])
  end

  def excel
    @survey = Survey.find(params[:id])
    respond_to do |format|
    format.xls {
      send_data(xls_content_for(@survey),
                :type => "text/excel; charset=utf-8; header=present",
                :filename => "Report_Survey(#{@survey.name})_#{Time.now.strftime("%Y%m%d")}.xls")
    }
    format.html  {redirect_to surveys_url}
    end
  end

  def pdf
    @survey = Survey.find(params[:id])
    @answers = Answer.all
    respond_to do |format|
      format.pdf {
        filename = "Report_Survey(#{@survey.name})_#{Time.now.strftime("%Y%m%d")}.pdf"
        write = Prawn::Document.new(:page_size => 'A4', :page_layout => :portrait)
        write.font "Helvetica"

        write.draw_text "The Report of #{@survey.name}", :at => [0,750], :size => 22, :style => :bold
        write.draw_text "Provided by: #{@survey.provider_name}", :at => [0,700], :size =>16
        write.draw_text "Version: #{@survey.version}", :at => [0,680], :size =>16
        write.draw_text "Language: #{@survey.language_avaliable}", :at => [0,660], :size =>16
        write.draw_text "Created time: #{@survey.created_at.to_s}", :at => [0,640], :size =>16

        line = 615
        number = 0
        @survey.questions.each do |question|
          line -= 15
          number += 1
          if question.q_type == '1'
            type = "Single Answer Multiple Choices"
          elsif question.q_type == '2'
            type = "Multiple Answers Multiple Choices"
          elsif question.q_type == '3'
            type = "Text"
          end
          write.draw_text "#{number.to_s}. #{question.title}(#{type})", :at => [0,line], :size =>12

          option_number = 0;
          question.question_options.each do |option|
            option_number += 1
            answer_number = 0
            @answers.each do |answer|
              if option.id == answer.content.to_i
                answer_number += 1
              end
            end
            line -= 15
            write.draw_text "#{option_number.to_s}) #{option.option} (#{answer_number.to_s} people answered)", :at => [15,line], :size =>12
          end

          if question.q_type == '3'
            option_number = 0
            @answers.each do |answer|
              if answer.question_id == question.id
                line -= 15
                option_number += 1
                write.draw_text "#{option_number.to_s}) #{answer.content}", :at => [15,line], :size =>12
              end
            end
          end

        end

        write.render_file("tmp/#{filename}")

        send_file "tmp/#{filename}", :type => 'application.pdf', :disposition => 'attachment'
      }
      format.html {redirect_to surveys_url}
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
      params.require(:survey).permit(:name, :reference_number, :version, :enable_flg, :provider_name, :language_avaliable,
        questions_attributes:
        [:id, :q_type, :title, :_destroy,
          question_options_attributes:
            [:id, :option, :_destroy]
        ])
    end

    # for update
    def survey_params_update
      params.require(:survey).permit(:name, :reference_number, :version, :enable_flg, :provider_name, :language_avaliable,
        questions_attributes:
        [:q_type, :title, :_destroy,
          question_options_attributes:
            [:option, :_destroy]
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
