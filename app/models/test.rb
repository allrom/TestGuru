class Test < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :questions
  belongs_to :category
  belongs_to :author, class_name: "User"

  validates :title, presence: true,
                    uniqueness: { scope: :level }

  validates :level, numericality: { greater_than_or_equal_to: 0 }

  scope :pick_by_category, -> title {
    joins(:category)
      .where("categories.title = ?", title)
      .order(title: :desc)
      .pluck(:title)
  }

  scope :simple, -> { where(:level => 0..1) }
  scope :moderate, -> { where(:level => 2..4) }
  scope :complex, -> { where(:level => 5..Float::INFINITY) }

  scope :test_by_level, -> level { where(level: level) }
end
