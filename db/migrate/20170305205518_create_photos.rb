class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.integer :album_id
      t.string :title
      t.text :url
      t.text :thumbnailUrl

      t.timestamps
    end
  end
end
