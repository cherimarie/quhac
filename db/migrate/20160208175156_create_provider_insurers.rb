class CreateProviderInsurers < ActiveRecord::Migration
  def change
    create_table :provider_insurers do |t|
      t.integer :provider_id, null: false
      t.integer :insurer_id, null: false

      t.timestamps
    end
  end
end
