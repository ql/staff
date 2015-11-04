class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :phone
      t.string :email
      t.decimal :salary
      t.string :status

      t.timestamps null: false
    end
  end
end
