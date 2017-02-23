class Topictagging < ApplicationRecord
  belongs_to :question, optional: true
  belongs_to :topic
end
