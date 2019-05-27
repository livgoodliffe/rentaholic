class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :photo
      t.integer :daily_rate
      t.references :user, foreign_key: true
      t.string :category

      t.timestamps
    end
  end
end
