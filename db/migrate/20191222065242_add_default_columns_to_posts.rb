class AddDefaultColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :header, :string
    add_column :posts, :content, :text
    add_column :posts, :user_id, :integer
  end
end
