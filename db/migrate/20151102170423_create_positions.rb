class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.date :expires_at
      t.decimal :salary
      t.text :contacts

      t.timestamps null: false
    end
  end
end
