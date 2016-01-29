class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :memories
  has_many :plans
  has_many :items

  before_save { self.email = email.downcase }
  before_save { self.role ||= :member }

  enum role: [:member, :premium, :admin]

  after_create :set_partner

  def partner
    User.find_by(partner_email: self.email)
  end

  def total_memories_count
    partner_memories_count = partner ? partner.memories.count : 0
    memories.count + partner_memories_count
  end

  def all_memories
    partner ? memories + partner.memories : memories
    # if partner
    #   memories + partner.memories
    # else
    #   memories
    # end
  end

  def all_plans
    partner ? plans + partner.plans : plans
  end

  def all_items
    partner ? items + partner.items : items
  end

  private

  def set_partner
    update_attribute(:partner_email, partner.email) if partner
  end
end
