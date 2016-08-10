class DiariesController < ApplicationController

  before_action :set_diary!, except: [:create, :index, :new]

  def create
    diary = current_user.make_current_diary
    redirect_to diary_path(diary)
  end

  def show
    @entry = Entry.new
    @project = @entry.build_project
  end

  def submit
    @diary.submit
    redirect_to diary_path(params[:id])
  end

  def index
    if params[:user_id]
      @diaries = User.find(params[:user_id]).diaries
    else
      @diaries = Diary.all
    end
  end

  private 

  def set_diary!
    @diary = Diary.find(params[:id])
  end
  
end
