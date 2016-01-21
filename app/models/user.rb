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

  private

  def set_partner
    update_attribute(:partner_email, partner.email) if partner
  end
end
