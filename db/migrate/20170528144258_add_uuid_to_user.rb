class AddUuidToUser < ActiveRecord::Migration[5.0]
  def change
    execute 'CREATE EXTENSION "uuid-ossp" SCHEMA public'
    remove_column :carts, :user_id
    add_column :carts, :user_uuid, :uuid
    add_column :users, :uuid, :uuid, default: "uuid_generate_v4()"
  end
end
