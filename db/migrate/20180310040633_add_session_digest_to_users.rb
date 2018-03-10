class AddSessionDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :session_digest, :string
  end
end
