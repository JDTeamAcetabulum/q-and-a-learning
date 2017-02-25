class Lecture < ApplicationRecord
  has_many :lecturetaggings
  has_many :questions, through: :lecturetaggings
end
