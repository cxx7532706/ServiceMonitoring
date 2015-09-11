class QuestionByLanguagesController < ApplicationController
  before_action :set_question_by_language, only: [:show, :edit, :update, :destroy]

  # GET /question_by_languages
  # GET /question_by_languages.json
  def index
    @question_by_languages = QuestionByLanguage.all
  end

  # GET /question_by_languages/1
  # GET /question_by_languages/1.json
  def show
  end

  # GET /question_by_languages/new
  def new
    @question_by_language = QuestionByLanguage.new
  end

  # GET /question_by_languages/1/edit
  def edit
  end

  # POST /question_by_languages
  # POST /question_by_languages.json
  def create
    @question_by_language = QuestionByLanguage.new(question_by_language_params)

    respond_to do |format|
      if @question_by_language.save
        format.html { redirect_to @question_by_language, notice: 'Question by language was successfully created.' }
        format.json { render :show, status: :created, location: @question_by_language }
      else
        format.html { render :new }
        format.json { render json: @question_by_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_by_languages/1
  # PATCH/PUT /question_by_languages/1.json
  def update
    respond_to do |format|
      if @question_by_language.update(question_by_language_params)
        format.html { redirect_to @question_by_language, notice: 'Question by language was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_by_language }
      else
        format.html { render :edit }
        format.json { render json: @question_by_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_by_languages/1
  # DELETE /question_by_languages/1.json
  def destroy
    @question_by_language.destroy
    respond_to do |format|
      format.html { redirect_to question_by_languages_url, notice: 'Question by language was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_by_language
      @question_by_language = QuestionByLanguage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_by_language_params
      params.require(:question_by_language).permit(:language, :title, :options, :created_at, :updated_at)
    end
end
