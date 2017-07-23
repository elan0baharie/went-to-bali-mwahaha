class AddColToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :priviledge, :string
  end
end
