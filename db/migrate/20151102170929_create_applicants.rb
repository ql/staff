class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.float :salary
      t.string :status

      t.timestamps null: false
    end
  end
end
