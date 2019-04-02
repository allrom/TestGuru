class Gist < ApplicationRecord
	belongs_to :question

	def accept!
		save! if self.present?
	end
end
