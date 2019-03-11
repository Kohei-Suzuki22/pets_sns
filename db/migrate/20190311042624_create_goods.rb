class CreateGoods < ActiveRecord::Migration[5.0]
  def change
    create_table :goods do |t|
      t.references :user, foreign_key: true
      t.references :timeline, foreign_key: true

      t.timestamps
    end
  end
end
