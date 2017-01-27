class Question < ApplicationRecord

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_one :correct_answer, class_name: "Answer"

  validates :correct_answer, presence: true

end
