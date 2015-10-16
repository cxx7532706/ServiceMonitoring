class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_signed_in, :only => [:new, :create]
  before_action :check_admin, :only => [:new, :create]

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
        redirect_to(root_path, notice: 'Creation successful!') :
        redirect_to(:back, alert: @user.errors.full_messages.join(', '))
  end

  def update
    # @user.update(user_params)
    # respond_with(@user)
  end

  def destroy
    # @user.destroy
    # respond_with(@user)
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
