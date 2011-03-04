require 'spec_helper'

feature 'Notes' do

  let(:description) { generate_description }
  let(:content) { generate_content }
  subject { page }

  scenario 'index' do
    visit '/'
    should have_content 'title'
    click_link 'new note'
    current_path.should == '/notes/new'
  end

  scenario 'create' do
    visit '/notes/new'
    expect {
      fill_in 'Description', :with => description
      fill_in 'Content', :with => content
      click_button 'Create'
    }.to change(Note, :count).by(1)

    current_path.should == '/notes'
    should have_content description
    should have_content truncate(content)
  end

  scenario 'update' do
    note = Note.make
    visit "/notes/#{note.id}/edit"

    page.find_field('Description').value.should == note.title
    should have_content note.body

    expect {
      fill_in 'Description', :with => description
      fill_in 'Content', :with => content
      click_button 'Update'
    }.to_not change(Note, :count)

    current_path.should == "/notes/#{note.id}"
    should_not have_content note.title
    should_not have_content note.body
    should have_content description
    should have_content content
  end

  scenario 'destroy' do
    note = Note.make
    visit "/notes/#{note.id}/edit"

    expect {
      click_button 'Remove'
    }.to change(Note, :count).by(-1)

    current_path.should == "/notes"
  end
end
