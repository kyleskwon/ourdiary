class ItemPolicy < ApplicationPolicy
  def show?
    premium_user? && user.all_items.include?(record)
  end
end
