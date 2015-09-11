require 'test_helper'

class QuestionByLanguagesControllerTest < ActionController::TestCase
  setup do
    @question_by_language = question_by_languages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_by_languages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_by_language" do
    assert_difference('QuestionByLanguage.count') do
      post :create, question_by_language: { created_at: @question_by_language.created_at, language: @question_by_language.language, options: @question_by_language.options, title: @question_by_language.title, updated_at: @question_by_language.updated_at }
    end

    assert_redirected_to question_by_language_path(assigns(:question_by_language))
  end

  test "should show question_by_language" do
    get :show, id: @question_by_language
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question_by_language
    assert_response :success
  end

  test "should update question_by_language" do
    patch :update, id: @question_by_language, question_by_language: { created_at: @question_by_language.created_at, language: @question_by_language.language, options: @question_by_language.options, title: @question_by_language.title, updated_at: @question_by_language.updated_at }
    assert_redirected_to question_by_language_path(assigns(:question_by_language))
  end

  test "should destroy question_by_language" do
    assert_difference('QuestionByLanguage.count', -1) do
      delete :destroy, id: @question_by_language
    end

    assert_redirected_to question_by_languages_path
  end
end
