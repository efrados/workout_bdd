require "rails_helper"

RSpec.feature "Creating exercise" do
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    login_as(@john)
  end

  scenario 'with valid inputs' do
    visit '/'

    click_link "My Lounge"
    click_link "New Workout"

    expect(page).to have_link("Back")

    fill_in "Duration", with: 70
    fill_in "Workout Details", with: "Weight lifting"
    fill_in "Activity Date", with: "2021/04/16"

    click_button "Create Exercise"

    expect(page).to have_content("Exercise has been created")
    
    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@john,exercise))
    expect(exercise.user.id).to eq(@john.id)
  end

  scenario 'with invalid inputs' do
    visit '/'
    click_link "My Lounge"
    click_link "New Workout"

    click_button "Create Exercise"

    expect(page).to have_content("Exercise has not been created")
    expect(page).to have_content("Duration in min is not a number")
    expect(page).to have_content("Workout details can't be blank")
    expect(page).to have_content("Activity date can't be blank")
    
  end
end