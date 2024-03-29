class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.string :booking_code, index: true
      t.string :train_id, index: true
      t.string :seat_number, index: true
      t.string :user_id, index: true
      t.string :customer_name
      t.string :customer_phone

      t.timestamps
    end
  end
end
