require "rails_helper"

describe "Admin Dashboard", type: :feature do
  before do
    User.create(role: "user", email: "user@example.com", password: "password", password_confirmation: "password")
    User.create(role: "admin", email: "admin@example.com", password: "password", password_confirmation: "password")
    User.create(role: "superadmin", email: "superadmin@example.com", password: "password", password_confirmation: "password")
  end

  it "doesn't allow randos to visit the admin dashboard" do
    visit "/admin"

    expect(page).to have_text("You need to sign in or sign up before continuing.")
  end

  it "doesn't allow users to visit dashboard" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'

    visit "/admin"

    expect(page).to have_text("You are not authorized to access this page.")
  end

  it "allows admins to visit dashboard" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'admin@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'

    visit "/admin"

    expect(page).to have_text("Site Administration")
  end

  it "allows superadmins to visit dashboard" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'superadmin@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'

    visit "/admin"

    expect(page).to have_text("Site Administration")
  end



end