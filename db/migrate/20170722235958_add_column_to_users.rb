class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :valid, :string
  end
end
