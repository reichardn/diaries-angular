class DiaryPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    user.admin || record.try(:user) == user
  end  

  def index?
    user.admin || record.try(:user) == user
  end

end