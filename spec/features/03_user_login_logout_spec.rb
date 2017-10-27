require "rails_helper"

feature "User Log In", %{
  As a registered and unauthenticated user
  I want to login
  To be an authenticated user & access my account

  Acceptance Criteria:
  [ ] User must submit an email address
  [ ] User must submit their password
  [ ] Email address submitted must be in the database (Users table)
  [ ] Password submitted must match the hashed password digest in database (Users table)

} do

  scenario "user can access log in page" do
    visit root_path
    click_link 'Log In'
    expect(page).to have_current_path("/login")
    expect(page).to have_content("Cancel")
  end

  scenario "Unregistered user attempts to login" do
    # [ ] Error message of reasons for failure to login
    # [ ] User remains on login page
    # [ ] User remains unauthenticated

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "joe_schmoe@email.com"
    fill_in "Password", with: "supersecret"
    click_button "Log In"

    expect(page).to have_content("That email is not registered")
    expect(page).to have_current_path("/login")
  end

  scenario "Registered user enters incorrect passwod" do
    # [ ] Error message of reasons for failure to login
    # [ ] User remains on login page
    # [ ] User remains unauthenticated

    user = User.create!(email: "duchess@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "duchess@example.gov"
    fill_in "Password", with: "incorrect"
    click_button "Log In"

    expect(page).to have_content("Invalid email/password combination")
    expect(page).to have_current_path("/login")
  end


  scenario "Login successful" do
    # [ ] Confirmation message that my account has been logged into
    # [ ] User is directed to user page
    # [ ] Login button is no longer available
    # [ ] Logout button is available

    user = User.create!(email: "duchess@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "duchess@example.gov"
    fill_in "Password", with: "sploosh1"
    click_button "Log In"

    expect(page).to have_content("You have successfully logged in")
    expect(page).to have_current_path("/users/#{user.id}")
  end
end

feature "User Log Out", %{
  As an authenticated user
  I want to logout
  To be unauthenticated

  Acceptance Criteria:
  [ ] Confirmation message that identity has been forgotten on machine I'm using
  [ ] User is no longer authenticated
  [ ] No more logout button
  [ ] Login button should be back

} do

  scenario "user successfully logout" do
    user = User.create!(email: "duchess@example.gov",
                        password: "sploosh1",
                        password_confirmation: "sploosh1",
                        first_name: "Sterling",
                        last_name: "Archer")

    visit root_path
    click_link 'Log In'
    fill_in "Email",    with: "duchess@example.gov"
    fill_in "Password", with: "sploosh1"
    click_button "Log In"
    expect(page).to have_content("You have successfully logged in")
    expect(page).to have_current_path("/users/#{user.id}")

    click_link 'Log Out'

    expect(page).to have_current_path("/")
    expect(page).to have_content("You have successfully logged out")
    expect(page).to have_link("Log In")
    expect(page).to have_link("Sign Up")
    expect(page).to_not have_link("Log Out")
  end

end
