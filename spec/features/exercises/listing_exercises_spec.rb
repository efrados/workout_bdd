require "rails_helper"

RSpec.feature "Listing exercises" do

  before do
    @john = User.create!(email: "john@example.com", password: "password", first_name: "john", last_name: "doe")
    login_as(@john)
    @e1 = @john.exercises.create(duration_in_min: 10,
                                  workout: "My body building activity",
                                  workout_date: Date.today)
    @e2 = @john.exercises.create(duration_in_min: 55,
                                  workout: "Weight Lifting",
                                  workout_date: 2.days.ago)
    @e3 = @john.exercises.create(duration_in_min: 25,
                                  workout: "Skip rope",
                                  workout_date: 9.days.ago)
  end

  scenario "with a logged in user" do
    visit "/"

    click_link "My Lounge"

    expect(page).to have_content(@e1.duration_in_min)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)

    expect(page).to have_content(@e2.duration_in_min)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)

  end

  scenario "without old exercises" do
    visit "/"

    click_link "My Lounge"

    expect(page).not_to have_content(@e3.duration_in_min)
    expect(page).not_to have_content(@e3.workout)
    expect(page).not_to have_content(@e3.workout_date)
  end

  scenario "with logged in user and no exercises created" do
    @e1.destroy
    @e2.destroy

    visit "/"

    click_link "My Lounge"

    expect(page).not_to have_content(@e1.duration_in_min)
    expect(page).not_to have_content(@e1.workout)
    expect(page).not_to have_content(@e1.workout_date)
    expect(page).to have_content("No workouts yet")

  end
end