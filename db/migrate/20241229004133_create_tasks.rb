class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.timestamps

      t.string :title,      null: false, limit: 100
      t.string :description,  limit: 255
      t.boolean :completed, default: false

      t.references :user, null: false, foreign_key: true
    end
  end
end
