require 'rails_helper'
feature 'User Settings features ' do
  before do
    @user = create(:user)
    log_in
  end
  feature "User Settings Dashboard" do
    before(:each) do
      visit "/users/#{@user.id}/edit"
    end
    scenario "visit users edit page" do
      expect(page).to have_field('user[email]')
      expect(page).to have_field('user[first_name]')
      expect(page).to have_field('user[last_name]')
    end
    scenario "inputs filled out correctly" do
      expect(find_field('user[first_name]').value).to eq(@user.first_name)
      expect(find_field('user[last_name]').value).to eq(@user.last_name)
      expect(find_field('user[email]').value).to eq(@user.email)
    end
    scenario "incorrectly updates information" do
      fill_in 'user[first_name]', with: 'Another Name'
      fill_in 'user[last_name]', with: 'Another Last Name'
      fill_in 'user[email]', with: 'incorrect email format'
      click_button 'Update'
      expect(current_path).to eq("/users/#{@user.id}/edit")
      expect(page).to have_text("Email does not appear to be a valid e-mail address")
    end
    scenario "correctly updates information" do
      fill_in 'user[first_name]', with: 'Another Name'
      fill_in 'user[last_name]', with: 'Another Last Name'
      fill_in 'user[email]', with: 'correct@email.com'
      click_button 'Update'
      expect(page).to have_text('Another Name')
    end
    scenario "destroys user and redirects to registration page" do
      click_button 'Delete Account'
      expect(current_path).to eq('/users/new')
      expect(page).to have_no_text('Log Out')
      # Make sure that you're clearing session on destroy
    end
  end
end
