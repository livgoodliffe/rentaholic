class CreateControllers < ActiveRecord::Migration[5.2]
  def change
    create_table :controllers do |t|
      t.string :items
      t.string :index
      t.string :show

      t.timestamps
    end
  end
end
