class CreateTrains < ActiveRecord::Migration[5.0]
  def change
    create_table :trains do |t|
      t.string :number, index:true #train number
      t.timestamps
    end
  end
end
