class Test < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :category

  def self.pick_by_category(category_title)
    Test.joins(:category).where("categories.title = ?", category_title).order('id DESC')
  end
end
