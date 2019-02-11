class Test < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :questions
  belongs_to :category
  belongs_to :author, class_name: "User"

  def self.pick_by_category(title)
    Test.joins(:category).where("categories.title = ?", title).pluck(:title).sort.reverse
  end
end
