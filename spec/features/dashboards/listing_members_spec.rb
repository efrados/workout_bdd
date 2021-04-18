require "rails_helper"

RSpec.feature "Listing Users" do
  before do
    @john = User.create!(first_name: "John",
                        last_name: "Doe",
                        email: "john@example.com",
                        password: "password")
  @sara = User.create!(first_name: "Sara",
                        last_name: "Doe",
                        email: "sara@example.com",
                        password: "password")
    login_as(@john)
  end
  scenario "shows a list of registered of users" do
    visit "/"

    expect(page).to have_content("Listing of Members")
    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@sara.full_name)

  end
end