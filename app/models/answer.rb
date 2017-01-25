class Answer < ApplicationRecord

  belongs_to :question

  validates :content, presence: true

  ATTRIBUTES = %I(correct content)
  attr_accessible(*ATTRIBUTES)

  DEFAULTS = {
    correct: false,
    content: ""
  }

  def initialize(opts = {})
    DEFAULTS.
      merge(opts).
      slice(*ATTRIBUTES).
      each { |k,v| instance_variable_set("@#{k}", v) }
  end
end
