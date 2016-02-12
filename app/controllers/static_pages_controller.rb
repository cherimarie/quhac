class StaticPagesController < ApplicationController

  def about
  end

  def contact
  end

  def submit_contact
    puts params[:email]
    puts params[:name]
    puts params[:comments]
    flash[:notice] = "Thanks #{params[:name]}!"
    redirect_to root_path
  end
end
