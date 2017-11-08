require "rails_helper"

feature "root" do

  context "user wants to view the index" do
    it "can see a list of files" do
      visit "/"
      expect(page).to have_content("My Files")
    end
  end
end

  context "user wants to upload a new file" do
    it "can navigate to the Upload Files page" do
      visit '/'
      first(:link, 'Upload File').click
      expect(page).to have_content('New Asset')
    end

    it "can select a file for upload from the local machine" do
      visit '/'
      first(:link, 'Upload File').click
      page.attach_file('asset[uploaded_file]', Rails.root + 'spec/Fixtures/test_image.jpg')
      submit_form
      expect(Asset.first.uploaded_file_file_name).to eq('test_image.jpg')
    end

    it "can view uploaded file in the root directory" do
      visit '/'
      first(:link, 'Upload File').click
      page.attach_file('asset[uploaded_file]', Rails.root + 'spec/Fixtures/test_image.jpg')
      submit_form
      visit '/'
      expect(page).to have_content('test_image.jpg')
    end

    it "can view more details of an uploaded file" do
      add_file
      time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      visit '/'
      click_link 'More Details'
      expect(page).to have_content "File type: image/jpeg | Uploaded: #{time}"
    end

  end

  context "user wants to download a test_image.jpg" do
    it 'can download test_image.jpg' do
      add_file
      visit '/'
      click_link 'test_image.jpg'
      expect(page.response_headers['Content-Type']).to eq "image/jpeg"
    end
  end

  def submit_form
   find('input[name="commit"]').click
  end

  def add_file
    visit '/'
    first(:link, 'Upload File').click
    page.attach_file('asset[uploaded_file]', Rails.root + 'spec/Fixtures/test_image.jpg')
    submit_form
  end
