require 'spec_helper'

feature 'Notes' do
  before do
    Note.delete
  end

  scenario 'index' do
    visit '/'
    page.should have_content 'title'
    click_link 'new note'
    current_path.should == '/notes/new'
  end

  scenario 'create' do
    visit '/notes/new'

    description = generate_description
    content = generate_content
    fill_in 'Description', :with => description
    fill_in 'Content', :with => content
    click_button 'Submit'

    current_path.should == '/notes'
    page.should have_content description
    page.should have_content truncate(h content)
  end
end
