class SearchesController < ApplicationController
  def new
    puts params[:search]

    redirect_to providers_path
  end
end