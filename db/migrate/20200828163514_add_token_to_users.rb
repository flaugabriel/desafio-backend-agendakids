class AddTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :token, :string, default: -> { 'gen_random_uuid()' }
    add_index :users, :token, unique: true
  end
end
