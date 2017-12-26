class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
