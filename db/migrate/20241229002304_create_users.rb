class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.timestamps

      t.string :name, null: false, limit: 50
      t.string :email, null: false, limit: 50
    end
  end
end
