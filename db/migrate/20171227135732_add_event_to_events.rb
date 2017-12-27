class AddEventToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :event, :string
  end
end
