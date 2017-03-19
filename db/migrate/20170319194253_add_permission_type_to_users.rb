class AddPermissionTypeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :permission, :string, default: "end_user"
  end
end
