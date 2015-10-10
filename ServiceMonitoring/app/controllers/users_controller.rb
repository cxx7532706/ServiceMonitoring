class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # respond_to :html

  def index
    # @users = User.all
    # respond_with(@users)
  end

  def show
    # respond_with(@user)
  end

  def new
    @user = User.new
    @is_admin = false
  end

  def new_admin
    @user = User.new
    @is_admin = true
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    @user.save ?
        redirect_to(root_path, notice: 'Registration successful!') :
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
end
