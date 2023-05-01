class RemoveIconFromGroup < ActiveRecord::Migration[7.0]
  def change
    remove_column :groups, :icon
  end
end