class Memory < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  has_attached_file :avatar, styles: { medium: "400x400>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates_length_of :title, :minimum => 3
  validates_length_of :address, :minimum => 3
  default_scope { order('date ASC') }

  after_create :upgrade_account, if: :account_upgradable?

  # def previous_memory
  #   self.class.first(:conditions => ["title < ?", title], :order => "title desc")
  # end
  #
  # def next_memory
  #   self.class.first(:conditions => ["title > ?", title], :order => "title asc")
  # end

  #   <!-- <%= link_to("Previous", @memory.previous_memory) if @memory.previous_memory %> -->
  #   <!-- <%= link_to("Next", @memory.next_memory) if @memory.next_memory %> -->

  MEMORY_COUNT_FOR_UPGRADE = 25  #Memory::MEMORY_COUNT_FOR_UPGRADE

  private

  def account_upgradable?
    user.total_memories_count >= MEMORY_COUNT_FOR_UPGRADE
  end

  def upgrade_account
    user.premium! unless user.admin?
    user.partner.premium! unless user.partner.admin?
  end
end
