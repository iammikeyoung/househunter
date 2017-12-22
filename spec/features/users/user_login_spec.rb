require "rails_helper"

feature "User log in" do
  let(:user) { FactoryBot.create(:user) }

  scenario "user enters valid log in data" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end

    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "pass2017"
    click_button "Log In"

    expect(page).to have_content("You have successfully logged in")
  end

  scenario "user enters unregistered log in data" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end

    fill_in "Email",    with: "not_registered@email.com"
    fill_in "Password", with: "pass2017"
    click_button "Log In"

    expect(page).to have_content("That email is not registered")
    expect(page).to have_content("Log In")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
  end

  scenario "registered user enters incorrect password" do
    visit root_path
    within(".nav-desktop") do
      click_link 'Log In'
    end

    fill_in "Email",    with: "#{user.email}"
    fill_in "Password", with: "incorrect"
    click_button "Log In"

    expect(page).to have_content("Invalid email/password combination")
    expect(page).to have_current_path("/login")
  end


end
