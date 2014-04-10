class Chapter < ActiveRecord::Base
  include Common

  belongs_to :trip
  has_one :user, through: :trip

  has_many :posts, dependent: :delete_all
  has_many :post_attachments, through: :posts

  has_many :inspirations, as: :inspirable

  #Drag and drop, chapter numbering
  acts_as_list scope: :trip

	validates :title, presence: true

end