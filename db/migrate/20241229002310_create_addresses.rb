class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.timestamps

      t.string :street, null: false, limit: 50
      t.string :city, null: false, limit: 50
      t.string :state, null: false, limit: 2

      t.references :user, null: false, foreign_key: true
    end
  end
end
