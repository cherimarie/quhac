class AddMedicaidToInsurer < ActiveRecord::Migration
  def change
    add_column :insurers, :is_medicaid, :boolean
  end
end
