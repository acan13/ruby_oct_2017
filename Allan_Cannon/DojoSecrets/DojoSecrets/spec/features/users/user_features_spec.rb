require 'rails_helper'
feature 'User features ' do
  before do
    # calling factory girl create method
    @user = create(:user)
  end
  feature "user sign-up" do
    before(:each) do
      visit "/users/new"
    end
    scenario 'visits sign-up page' do
      expect(page).to have_field('user[first_name]')
      expect(page).to have_field('user[last_name]')
      expect(page).to have_field('user[email]')
      expect(page).to have_field('user[password]')
      expect(page).to have_field('user[password_confirmation]')
    end
    scenario "with blank inputs, redirects back to sign in and shows validations" do
      click_button 'Join'
      expect(current_path).to eq('/users/new')
      expect(page).to have_text("can't be blank")
    end
    scenario "with proper inputs, create user and redirects to login page" do
      fill_in 'user[email]', with: 'curry@warriors.com'
      fill_in 'user[first_name]', with: 'Steph'
      fill_in 'user[last_name]', with: 'Curry'
      fill_in 'user[password]', with:  'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Join'
      expect(current_path).to eq("/sessions/new")
    end
  end
  feature "user dashboard" do
    before do
      log_in
    end
    scenario "displays user information" do
      expect(page).to have_text("#{@user.first_name}")
      expect(page).to have_button('Edit Profile')
    end
  end
end
