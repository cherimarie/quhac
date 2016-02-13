class SearchesController < ApplicationController
  def new
    @providers = Provider.search(params[:search])

    redirect_to providers_path
  end
end