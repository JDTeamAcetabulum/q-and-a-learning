class Answer < ApplicationRecord
  belongs_to :question, optional: true
  has_and_belongs_to_many :users

  validates :content, presence: true
end
