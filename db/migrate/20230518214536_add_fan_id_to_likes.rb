class AddFanIdToLikes < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :fan_id, :integer
  end
end
