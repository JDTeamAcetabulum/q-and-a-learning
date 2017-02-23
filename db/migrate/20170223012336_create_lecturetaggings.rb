class CreateLecturetaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :lecturetaggings do |t|
      t.belongs_to :question, foreign_key: true
      t.belongs_to :lecture, foreign_key: true

      t.timestamps
    end
  end
end
