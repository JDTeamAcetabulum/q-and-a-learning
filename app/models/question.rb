class Question < ApplicationRecord

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :topictaggings
  has_many :topics, through: :topictaggings, dependent: :destroy
  has_many :lecturetaggings
  has_many :lectures, through: :lecturetaggings, dependent: :destroy
  has_one :correct_answer, ->{ where(correct: true) }, class_name: "Answer",
    foreign_key: "question_id"

  accepts_nested_attributes_for :answers, :correct_answer
  validates :correct_answer, presence: true

  def self.to_csv
    attributes = %w(content correct_answer_content incorrect_answers_content)
    CSV.generate do |csv|
      csv << attributes
      all.each do |question|
        csv << attributes.map{ |attr| question.send(attr) }
      end
    end
  end

  def correct_answer_content
    correct_answer.content
  end

  def incorrect_answers_content
    content = []
    answers.each do |a|
      content << a.content
    end
    content
  end

  def published
    published_at
  end

  def published?
    published_at?
  end

  def all_topics=(names)
    self.topics = names.split(",").map do |name|
      Topic.where(name: name.strip).first_or_create!
    end
  end

  def all_topics
    self.topics.map(&:name).join(", ")
  end

  def all_lectures=(names)
    self.lectures = names.split(",").map do |name|

      Lecture.where(name: name.strip).first_or_create!
    end
  end

  def all_lectures
    self.lectures.map(&:name).join(", ")
  end
end
