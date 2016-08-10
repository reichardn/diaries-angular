class EntriesController < ApplicationController

  before_action :set_entry!, except: [:create, :index, :new]

  def create
    entry = Entry.new(entry_params)
    entry.diary_id = params[:diary_id]
    if !params[:entry][:project_id].blank?
      entry.project_id = params[:entry][:project_id]
    end
    entry.save
    set_errors_message(entry)
    redirect_to diary_path(params[:diary_id])
  end

  def destroy
    id = @entry.diary_id
    @entry.destroy
    redirect_to diary_path(id)
  end

  private 

  def entry_params
    params.require(:entry).permit(:day, :minutes, :project_id, project_attributes: [:name])
  end

  def set_entry!
    @entry = Entry.find(params[:id])
  end

  def set_errors_message(entry)
    if entry.errors.any?
      message = []
      entry.errors.full_messages.each do |msg|
        message << "#{msg}"
      end
      flash[:alert] = message.join(', ')
    end
  end

end
