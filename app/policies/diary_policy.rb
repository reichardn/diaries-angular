class DiaryPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end  

  def index?
    record.try(:user) == user
  end

end