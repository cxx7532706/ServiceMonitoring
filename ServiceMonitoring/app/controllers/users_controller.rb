class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_signed_in
  before_action :check_admin

  # respond_to :html

  def index
    @users = User.all
    # respond_with(@users)
  end

  def show
    # respond_with(@user)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    @user.save ?
        redirect_to(users_path, success: 'New Advisor Account Created Successfully!') :
        redirect_to(:back, error: @user.errors.full_messages.join(', '))
  end

  def update
     @user.update(user_params)
     @user.save ?
        redirect_to(users_path, success: 'Advisor Account Updated!') :
        redirect_to(:back, error: @user.errors.full_messages.join(', '))
  end

  def destroy
     @user.destroy
     redirect_to(users_path, notice: 'Advisor Deleted!')
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :is_admin)
    end

    def check_signed_in
      redirect_to root_path, alert: 'You need to sign in.' unless user_signed_in?
    end

    def check_admin
      redirect_to root_path, alert: 'Permission denied.' unless user_is_admin?
    end
end
