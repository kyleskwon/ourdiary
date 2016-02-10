class PlanPolicy < ApplicationPolicy
  def show?
    premium_user? && user.all_planspremium_user?.include?(record)
  end

end
