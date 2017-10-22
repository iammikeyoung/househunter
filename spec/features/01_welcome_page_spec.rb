require 'rails_helper'

feature 'my welcome page' do
    scenario 'root page route' do
      visit('/')
      expect(page).to have_content("Welcome to the HouseHunter App!")
    end

    scenario 'welcome#index homepage message' do
      visit('/welcome')
      expect(page).to have_content("Welcome to the HouseHunter App!")
      expect(page).to have_content("Sign Up")
      expect(page).to have_content("Log In")
      expect(page).to have_content("Sign up now!")
    end

end
