require 'spec_helper'

feature 'Notes' do
  scenario 'test index' do
    visit '/'
    page.should have_content 'title'
    click_link 'new note'
    current_path.should == '/notes/new'
  end
end
