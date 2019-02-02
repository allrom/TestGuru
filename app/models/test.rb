class Test < ApplicationRecord
  def self.pick_by_category(category_title)
    category_id = Category.find_by(title: category_title)
    where("category_id = ?", category_id).order('id DESC')
  end
end
