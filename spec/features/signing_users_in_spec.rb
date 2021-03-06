require "rails_helper"

RSpec.feature "Signing in Users" do

  before do
    @john = User.create!(email: "john@example.com", password: "password", first_name: "john", last_name: "doe")
  end

  scenario "with valid credentials" do
    visit "/"

    click_link "Sign in"
    fill_in "Email", with: @john.email 
    fill_in "Password", with: @john.password 
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.") 
    expect(page).to have_content("#{@john.email}") 
    expect(page).not_to have_link("Sign in") 
    expect(page).not_to have_link("Sign up")
  end
end