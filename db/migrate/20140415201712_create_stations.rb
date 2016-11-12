class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.string :name
      t.text :url
      t.integer :place

      t.timestamps
    end
  end
end
