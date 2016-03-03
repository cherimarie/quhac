RailsAdmin.config do |config|
  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.excluded_models = ["ProviderInsurer"]

  config.model 'User' do
    include_fields :email, :role
    configure :email do
      read_only true
    end
    configure :role do
      help "Set to 'admin' to permit them to update provider and insurer data. Set to 'superadmin' to permit them to make changes to user's roles. Set to anything else to prevent them from accessing the admin dashboard."
    end
  end
end
