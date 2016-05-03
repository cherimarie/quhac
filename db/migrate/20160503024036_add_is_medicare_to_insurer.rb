class AddIsMedicareToInsurer < ActiveRecord::Migration
  def change
    add_column :insurers, :is_medicare, :boolean
  end
end
