class CreateClinic < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :zip, null: false
      t.string :phone, null: false
      t.string :website
    end
  end
end
