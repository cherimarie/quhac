class AddIconToProvider < ActiveRecord::Migration
  def change
    add_column :providers, :icon, :string
  end
end
