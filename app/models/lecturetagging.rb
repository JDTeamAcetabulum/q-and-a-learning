class Lecturetagging < ApplicationRecord
  belongs_to :question, optional: true
  belongs_to :lecture
end
