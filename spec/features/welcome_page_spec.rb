require 'rails_helper'

feature 'my welcome page' do
    scenario 'visit root page' do
      visit('/')

      expect(page).to have_content("Welcome to the HouseHunter App!")
      within(".nav-desktop") do
        expect(page).to have_content("Sign Up")
        expect(page).to have_content("Log In")
      end
    end
end
