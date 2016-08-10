module ApplicationHelper
   def current_diary
    if current_user
      current_user.current_diary
    end
  end

  def is_current_diary
    @diary == current_diary
  end
end
