class AddContentToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :content, :string
  end
end
