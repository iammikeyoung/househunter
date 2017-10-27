require 'rails_helper'

feature "User Updates Account", %{
  As an authenticated user
  I want to update my information
  So that I can keep my profile info correct

  Acceptance Criteria:
  [ ] Update first Name & last Name
  [ ] Update email with valid email address
  [ ] Update password with valid password

} do

  scenario "user enters invalid information"

  scenario "user enters valid information"

end

feature "User Deletes Account", %{
  As an authenticated user
  I want to delete my account
  So that my information is no longer retained by the app

  Acceptance Criteria:
  [ ] User can no longer login with email address & password
  [ ] User deleted from Users table
  [ ] User notes are deleted from Notes table
  [ ] If user is only person associated with Portfolio
    [ ] Delete portfolio & houses in portfolio

} do

  scenario "user successfully deletes account"

end
