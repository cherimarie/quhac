class ChangeProvider < ActiveRecord::Migration
  def change
    add_column :providers, :clinic_id, :integer, null: false
    add_column :providers, :email, :string
    add_column :providers, :type, :string
    add_column :providers, :population_expertise, :string
    add_column :providers, :specialization, :string
    add_column :providers, :gender_id, :string
    add_column :providers, :orientation, :string
    add_column :providers, :comprehensive_intake, :boolean
    add_column :providers, :use_pref_name, :boolean
    add_column :providers, :trans_standard_of_care, :string
    add_column :providers, :gender_neutral_rr, :boolean
    add_column :providers, :lgbtq_trained, :boolean
    add_column :providers, :lgbtq_training_details, :text
    add_column :providers, :cultural_trained, :boolean
    add_column :providers, :cultural_training_details, :text
    add_column :providers, :lgbq_incl_strategy, :text
    add_column :providers, :trans_incl_strategy, :text
    add_column :providers, :new_clients, :boolean
    add_column :providers, :community_relationship, :text
    add_column :providers, :additional, :text
    remove_column :providers, :city, :string
  end
end
