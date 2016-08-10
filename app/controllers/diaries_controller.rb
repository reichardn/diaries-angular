class DiariesController < ApplicationController

  before_action :set_diary!, except: [:create, :index, :new]

  rescue_from Pundit::NotAuthorizedError, with: :diary_not_authorized

  def create
    diary = current_user.make_current_diary
    redirect_to diary_path(diary)
  end

  def show
    authorize @diary
    @entry = Entry.new
    @project = @entry.build_project
  end

  def submit
    @diary.submit
    redirect_to diary_path(params[:id])
  end

  def index
    @diaries = policy_scope(Diary)
  end

  private 

  def set_diary!
    @diary = Diary.find(params[:id])
  end

  def diary_not_authorized
    flash[:alert] = "Access denied."
    redirect_to(root_path)
  end
  
end
