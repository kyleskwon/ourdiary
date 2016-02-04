class Item < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  has_attached_file :avatar, styles: { medium: "480x800>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :title, presence: true

  def self.search(query)
      # where(:title, query) -> This would return an exact match of the query
      where("title like ? or caption like ?", "%#{query}%", "%#{query}%")
  end

  default_scope { order('title ASC') }
end
