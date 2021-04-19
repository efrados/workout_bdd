require "rails_helper"

RSpec.feature "Destroying exercise" do

  before do
    @john = User.create!(email: "john@example.com", password: "password", first_name: "john", last_name: "doe")
    login_as(@john)
    @e1 = @john.exercises.create(duration_in_min: 10,
                                  workout: "My body building activity",
                                  workout_date: Date.yesterday)
  end

  scenario "with valid data" do
    visit "/"
    click_link "My Lounge"
    find("#destroy_#{@john.id}_#{@e1.id}").click

    expect(page).to have_content("Exercise has been deleted")
    
    expect(page).not_to have_content(10)
    expect(page).not_to have_content("My body building activity")
    expect(page).not_to have_content(Date.yesterday)

  end

end