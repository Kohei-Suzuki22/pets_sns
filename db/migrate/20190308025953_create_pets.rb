class CreatePets < ActiveRecord::Migration[5.0]
  def change
    create_table :pets do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :profile
      t.string :image

      t.timestamps
    end
  end
end
