class Plan < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  has_attached_file :avatar, styles: { medium: "480x800>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :title, :date, presence: true

  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  scope :for_user, -> (user) {
    user_ids = [user.id]
    user_ids << user.partner.id if user.partner
    where(user_id: user_ids)
  }

  def self.search(query)
      # where(:title, query) -> This would return an exact match of the query
      where("title like ? or caption like ? or date like ? or address like ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
  end

  default_scope { order('date ASC') }
end
