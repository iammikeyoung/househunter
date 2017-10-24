require 'rails_helper'

feature "User Sign Up", %{
  As a prospective user
  I want to create an account
  To be a registered & authenticated user

  Acceptance Criteria:
  [ ] A valid email address must be submitted
  [ ] A valid password must be submitted x2
  [ ] The two password submissions must match each other

  [ ] If requirements are not met,
      [ ] user is not saved to the database (not registered or authenticated)
      [ ] user is given error message
  [ ] If requirements are met,
      [ ] Prospective user's info is saved to the database (registered)
      [ ] User is logged in (authenticated)
      [ ] User is directed to user page
} do

  scenario "user on welcome page can access sign up page" do
    visit root_path
    click_link 'Sign Up'
    expect(page).to have_current_path("/users/new")
    expect(page).to have_content('First Name')
    expect(page).to have_content('Last Name')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password (8 characters minimum)')
    expect(page).to have_content('Confirmation')
    # expect(page).to have_content('Profile Picture')
  end

  scenario "user provides invalid email & password information" do
    visit root_path
    click_link 'Sign Up'
    click_button 'Create Account'

    expect(page).to have_content("errors prohibited this user from being saved:")
    # expect(page).to have_content("First Name can't be blank")
    # expect(page).to have_content("Last Name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario "password fields do not match & email format incorrect" do
    visit root_path
    click_on "Sign Up"

    fill_in "First Name",     with: "Joe"
    fill_in "Last Name",      with: "Shmoe"
    fill_in "Email",          with: "name@emailcom"
    fill_in "Password",       with: "supersecret"
    fill_in "Confirmation",   with: "different"
    click_on "Create Account"

    expect(page).to have_content "Email is invalid"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario "email is already registered" do
    existing_user = User.create(
      first_name: "Joe",
      last_name: "Schmoe",
      email: "joe@email.com",
      password: "passwordsecret",
      password_confirmation: "passwordsecret"
    )

    visit root_path
    click_on "Sign Up"

    fill_in "First Name", with: existing_user.first_name
    fill_in "Last Name", with: existing_user.last_name
    fill_in "Email", with: existing_user.email
    fill_in "Password", with: existing_user.password
    fill_in "Confirmation", with: existing_user.password
    click_on "Create Account"

    expect(page).to have_content "Email has already been taken"
  end

  scenario "user provides valid and required information" do
    visit root_path
    click_link 'Sign Up'

    fill_in 'First Name', with: 'Arya'
    fill_in 'Last Name', with: 'Stark'
    fill_in 'Email', with: 'arya@winterfell.com'
    fill_in 'Password', with: 'HouseStark4Ever'
    fill_in 'Confirmation', with: 'HouseStark4Ever'
    click_button 'Create Account'

    expect(page).to have_content("You have signed up successfully.")
    expect(page).to have_content("User's Homepage")
    expect(page).to have_content("Welcome Arya! You have signed up successfully.")
  end


end
