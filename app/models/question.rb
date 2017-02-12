class Question < ApplicationRecord

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_one :correct_answer, ->{ where(correct: true) }, class_name: "Answer",
          foreign_key: "question_id"

  accepts_nested_attributes_for :answers, :correct_answer
  validates :correct_answer, presence: true

end
