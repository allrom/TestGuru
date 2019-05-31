class Test < ApplicationRecord
  ## has_and_belongs_to_many :users
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages
  has_many :questions, dependent: :destroy
  belongs_to :category, optional: true
  belongs_to :author, class_name: "User"

  attribute :minutes
  attribute :seconds

  before_save :before_save_compute_test_seconds, on: %i[create update]

  validates :title, presence: true,
                    uniqueness: { scope: :level }

  validates :level, numericality: { greater_than_or_equal_to: 0 }

  scope :scope_by_category, -> title {
    joins(:category).where("categories.title ILIKE ?", title)
  }

  def self.title_by_category(title)
    scope_by_category(title).order(title: :desc).pluck(:title)
  end

  def self.ids_by_category(title)
    scope_by_category(title).ids
  end

  scope :simple, -> { where(:level => 0..1) }
  scope :moderate, -> { where(:level => 2..4) }
  scope :complex, -> { where(:level => 5..Float::INFINITY) }

  private

  def before_save_compute_test_seconds
    self.expire_in = 60 * minutes.to_i + seconds.to_i if seconds? || minutes?
  end
end
