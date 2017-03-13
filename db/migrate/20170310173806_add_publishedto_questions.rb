class AddPublishedtoQuestions < ActiveRecord::Migration[5.0]
  def change
  	add_column :questions, :published_at, :datetime
  end
end
