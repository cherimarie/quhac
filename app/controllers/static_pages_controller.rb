class StaticPagesController < ApplicationController

  def submit_contact
    flash[:notice] = "Thanks friend!"
    redirect_to root_path
  end
end
