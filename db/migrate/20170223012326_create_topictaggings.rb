class CreateTopictaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :topictaggings do |t|
      t.belongs_to :question, foreign_key: true
      t.belongs_to :topic, foreign_key: true

      t.timestamps
    end
  end
end
