require "rails_helper"

RSpec.feature "Editing exercises" do

  before do
    @john = User.create!(email: "john@example.com", password: "password", first_name: "john", last_name: "doe")
    login_as(@john)
    @e1 = @john.exercises.create(duration_in_min: 10,
                                  workout: "My body building activity",
                                  workout_date: Date.today)
  end

  scenario "with valid data" do
    visit "/"
    click_link "My Lounge"
    find("#edit_#{@john.id}_#{@e1.id}").click

    fill_in "Duration", with: 70
    fill_in "Workout Details", with: "Weight lifting"
    fill_in "Activity Date", with: Date.yesterday

    click_button "Update Exercise"

    expect(page).to have_content("Exercise has been updated")
    
    expect(page).to have_content(70)
    expect(page).not_to have_content(10)

  end

  scenario "with invalid data" do
    visit "/"
    click_link "My Lounge"
    find("#edit_#{@john.id}_#{@e1.id}").click


    fill_in "Workout Details", with: ""

    click_button "Update Exercise"

    expect(page).to have_content("Exercise has not been updated")

  end
end