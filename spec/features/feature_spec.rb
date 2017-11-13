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
      fill_in('model_name', :with => "Test")
      first(:link, 'Choose File').click
      page.attach_file('asset[uploaded_file]', Rails.root + 'spec/Fixtures/test_image.jpg')
      second(:link, 'Choose File').click
      page.attach_file('asset[uploaded_file]', Rails.root + 'spec/Fixtures/test_image.jpg')
      third(:link, 'Choose File').click
      page.attach_file('asset[uploaded_file]', Rails.root + 'spec/Fixtures/test_image.jpg')
      submit_form
      expect(Asset.first.uploaded_file_file_name).to eq('test_image.jpg')
    end

    it 'can view uploaded file in the root directory' do
      visit '/'
      sign_in
      first(:link, 'Upload File').click
      page.attach_file('asset[uploaded_file]', Rails.root + 'spec/Fixtures/test_image.jpg')
      submit_form
      visit '/'
      expect(page).to have_content('test_image.jpg')
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
      click_link 'test_image.jpg'
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
      expect(page).to have_content('test_image.jpg')
      click_link 'More Details'
      click_link 'Delete'
      expect(page).to have_content('Asset was successfully destroyed')
      visit '/'
      expect(page).not_to have_content('test_image.jpg')
    end
  end
end

def submit_form
  find('input[name="commit"]').click
end

def sign_in
  visit '/'
  first(:link, 'Register').click
  fill_in 'user[email]', with: 'testy@testmail.com'
  fill_in 'user[user_name]', with: 'Test User'
  fill_in 'user[password]', with: 'testtest'
  fill_in 'user[password_confirmation]', with: 'testtest'
  click_button 'Sign up'
end

def add_file
  visit '/'
  first(:link, 'Upload File').click
  page.attach_file('asset[uploaded_file]', Rails.root + 'spec/Fixtures/test_image.jpg')
  submit_form
end
