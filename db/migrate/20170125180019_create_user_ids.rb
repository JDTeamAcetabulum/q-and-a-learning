class CreateUserIds < ActiveRecord::Migration[5.0]
  def change
    create_table :user_ids do |t|
      t.First :username
      t.string :Last
      t.integer :id

      t.timestamps
    end
  end
end
