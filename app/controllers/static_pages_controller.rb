class StaticPagesController < ApplicationController

  def about
  end

  def contact
  end

  def submit_contact
    if params[:robots_are_dumb].empty?
      ContactMailer.new_contact(name: params[:name], email: params[:email], comments: params[:comments]).deliver
    end
    flash[:notice] = "Thanks #{params[:name]}!"
    redirect_to root_path
  end
end
