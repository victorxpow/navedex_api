class AddJtiToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :jti, :string,  null: false, default: ""
  end
end
