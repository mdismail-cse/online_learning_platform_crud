class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.decimal :registration_fee

      t.timestamps
    end
  end
end
