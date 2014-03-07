class Trip < ActiveRecord::Base

  acts_as_votable

	belongs_to :user
	has_many :chapters, dependent: :delete_all
	has_many :posts, through: :chapters

  validates :title,       presence: true,
                          uniqueness: true
  validates :description, presence: true

  scope :most_recent, -> { order(created_at: :desc)}

  def start_date
    if self.posts.any?
    posts.first.date.to_date.to_formatted_s(:long)
    else
      ""
    end
  end

  def end_date
    if self.posts.any?
    posts.last.date.to_date.to_formatted_s(:long)
    else
      ""
    end
  end

  def number_of_chapters
    chapters.count
  end

end