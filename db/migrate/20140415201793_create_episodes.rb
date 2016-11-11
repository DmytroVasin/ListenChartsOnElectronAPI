class CreateEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :episodes do |t|
      t.integer :station_id
      t.boolean :in_top, default: true, null: false

      t.string  :artist
      t.string  :title
      t.integer :place
      t.integer :previous_place

      t.integer :sc_id
      t.string  :sc_title
      t.integer :sc_duration
      t.string  :sc_stream_url
      t.string  :sc_image_url
      t.string  :sc_download_url

      t.timestamps
    end
  end
end
