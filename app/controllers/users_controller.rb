class UsersController < ApplicationController

  before_action :set_user!, except: [:create, :index, :new]
  before_action :authenticate_user!, except: [:create, :new]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @users = User.all
  end

  def show
    authorize @user
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to users_path, :notice => "User deleted."
  end
  
  private

  def set_user!
    @user = User.find(params[:id])
  end

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to(root_path)
  end

end