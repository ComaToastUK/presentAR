require 'rails_helper'

feature 'My Files page' do
  context 'user wants to see an index page with a list of files' do
    it 'can see a list of files' do
      visit '/'
      expect(page).to have_content('My Files')
    end
  end
end

feature 'Upload file' do
  context 'user wants to upload a new file' do
    it 'can navigate to the Upload Files page' do
      visit '/'
      sign_in
      first(:link, 'Upload File').click
      expect(page).to have_content('New Asset')
    end

    it 'can select a file for upload from the local machine' do
      visit '/'
      sign_in
      visit '/assets/new'
      fill_in('asset[name]', :with => "Test")
      page.attach_file('asset[uploaded_file]', Rails.root + 'spec/Fixtures/test_image.jpg')
      page.attach_file('asset[image_target]', Rails.root + 'spec/Fixtures/Marker-00.png')
      page.attach_file('asset[model_image]', Rails.root + 'spec/Fixtures/TrumpImg.jpg')
      submit_form
      expect(Asset.first.uploaded_file_file_name).to eq('test_image.jpg')
    end

    it 'can view uploaded file in the root directory' do
      visit '/'
      sign_in
      first(:link, 'Upload File').click
      fill_in 'asset[name]', :with => 'Test Model'
      page.attach_file('asset[uploaded_file]', Rails.root + 'spec/Fixtures/test_image.jpg')
      page.attach_file('asset[image_target]', Rails.root + 'spec/Fixtures/Marker-00.png')
      page.attach_file('asset[model_image]', Rails.root + 'spec/Fixtures/TrumpImg.jpg')
      submit_form
      visit '/'
      expect(page).to have_content('Test Model')
    end

    it 'can view more details of an uploaded file' do
      sign_in
      add_file
      time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      visit '/'
      click_link 'More Details'
      expect(page).to have_content "File type: image/jpeg | Uploaded: #{time}"
    end
  end
end

feature 'Download file' do
  context 'user wants to download a test_image.jpg' do
    it 'can download test_image.jpg' do
      sign_in
      add_file
      visit '/'
      click_link 'More Details'
      click_link 'Download'
      expect(page.response_headers['Content-Type']).to eq 'image/jpeg'
    end
  end
end

feature 'Delete files' do
  context 'user wants to delete test_image.jpg' do
    it 'can destroy test_image.jpg' do
      sign_in
      add_file
      visit '/'
      expect(page).to have_content('Test Model')
      click_link 'More Details'
      click_link 'Delete'
      expect(page).to have_content('Asset was successfully destroyed')
      visit '/'
      expect(page).not_to have_content('Test Model')
    end
  end
end

feature 'Non users cannot download files' do
  context 'a non user wants to download a file from show' do
    it "doesn't allow for non user downloads" do
      sign_in_add_and_sign_out
      click_link 'More Details'
      expect(page).not_to have_content 'Download'
    end

    context 'a non user wants to download a file from index' do
      it "doesn't allow for non user downloads" do
        sign_in_add_and_sign_out
        visit '/'
        expect(page).not_to have_link 'test_image.jpg'
        expect(page).to have_content 'test_image.jpg'
      end
    end
  end

  context 'a non user wants to delete a file' do
    it "doesn't allow for non user file deletions" do
      sign_in_add_and_sign_out
      visit '/'
      click_link 'More Details'
      expect(page).to have_content 'This model is private'
      expect(page).not_to have_content 'Delete'
    end
  end
end

feature 'signed in users cannot delete other users files' do
  context 'a user wants to delete a file that they did not upload' do
      it 'only allows file owners to delete files' do
      sign_in_add_and_sign_out
      sign_in('test2@test2mail.com', 'Mr Deleter', 'ideletestuff')
      visit '/'
      click_link 'More Details'
      expect(page).to have_content 'This model is private'
      expect(page).not_to have_content 'Delete'
    end
  end
end

feature 'users can log in anytime after creating an account' do
  context 'Test User wants to log back in after logging out' do
    it 'allows a user to log in' do
      sign_in_add_and_sign_out
      login
      expect(page).to have_content 'Signed in successfully'
    end
  end
end

feature 'User login' do
  context 'Test User tries to log in with an incorrect password' do
    it 'does not login succesfully' do
      sign_in_add_and_sign_out
      login('testy@testmail.com', 'password')
      expect(page).not_to have_content 'Signed in successfully'
      expect(page).to have_content 'Log in'
    end
  end
end

def submit_form
  find('input[name="commit"]').click
end

def sign_in(    email = 'testy@testmail.com',
            user_name = 'Test User',
             password = 'testtest')
  visit '/'
  first(:link, 'Register').click
  fill_in 'user[email]', with: email
  fill_in 'user[user_name]', with: user_name
  fill_in 'user[password]', with: password
  fill_in 'user[password_confirmation]', with: password
  click_button 'Sign up'
end

def login(email    = 'testy@testmail.com',
          password = 'testtest')
  visit '/'
  click_link 'Login'
  fill_in 'user[email]', with: email
  fill_in 'user[password]', with: password
  submit_form
end

def add_file
  visit '/'
  first(:link, 'Upload File').click
  fill_in 'asset[name]', :with => 'Test Model'
  page.attach_file('asset[uploaded_file]', Rails.root + 'spec/Fixtures/test_image.jpg')
  page.attach_file('asset[image_target]', Rails.root + 'spec/Fixtures/Marker-00.png')
  page.attach_file('asset[model_image]', Rails.root + 'spec/Fixtures/TrumpImg.jpg')
  submit_form
end

def sign_out
  click_link 'Logout'
end

def submit_form
   find('input[name="commit"]').click
end

def sign_in_add_and_sign_out
  sign_in
  add_file
  sign_out
end
