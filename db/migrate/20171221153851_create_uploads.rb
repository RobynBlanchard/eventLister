class CreateUploads < ActiveRecord::Migration[5.1]
  def change
    create_table :uploads do |t|
      t.string :artist
      t.string :url

      t.timestamps
    end
  end
end
