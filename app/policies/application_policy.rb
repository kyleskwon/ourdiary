class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    premium_user?
  end

  def show?
    false
  end

  def create?
    premium_user?
  end

  def new?
    premium_user?
  end

  def update?
    show?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def premium_user?
    user && user.premium?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
