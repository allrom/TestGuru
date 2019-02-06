class Test < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :category

  def self.pick_by_category(title)
    Test.joins(:category).where("categories.title = ?", title).pluck(:title).sort.reverse
  end
end
