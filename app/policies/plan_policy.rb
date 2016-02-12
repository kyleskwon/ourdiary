class PlanPolicy < ApplicationPolicy
  def show?
    premium_user? && user.all_plans.include?(record)
  end
end
