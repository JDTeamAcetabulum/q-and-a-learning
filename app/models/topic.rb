class Topic < ApplicationRecord
  has_many :topictaggings
  has_many :questions, through: :topictaggings
end
