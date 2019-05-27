class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :daily_rate
      t.date :start_date
      t.date :end_date
      t.string :status

      t.timestamps
    end
  end
end
