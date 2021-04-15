require "rails_helper" 

RSpec.feature "Listing Articles" do

  scenario "with articles created and user not singed in" do
    visit "/"

    expect(page).to have_link('Home')
    expect(page).to have_link('Athletes Den')
    expect(page).to have_content('Workout Lounge!') 
    expect(page).to have_content('Show off your workout') 
  end

end