require 'spec_helper'

feature 'Notes' do

  let(:description) { generate_description }
  let(:content) { generate_content }

  background do
    Note.delete
    @content = generate_content
  end

  scenario 'index' do
    visit '/'
    page.should have_content 'title'
    click_link 'new note'
    current_path.should == '/notes/new'
  end

  scenario 'create' do
    expect {
      visit '/notes/new'
      fill_in 'Description', :with => description
      fill_in 'Content', :with => content
      click_button 'Create'
    }.should change(Note, :count).by(1)

    current_path.should == '/notes'
    page.should have_content description
    page.should have_content truncate(h content)
  end

  scenario 'update' do
    note = Note.spawn

    expect {
      visit "/notes/#{note.id}/edit"
      fill_in 'Description', :with => description
      fill_in 'Content', :with => content
      click_button 'Update'
    }.should_not change(Note, :count)

    current_path.should == "/notes/#{note.id}"
    page.should_not have_content note.title
    page.should_not have_content note.body
    page.should have_content description
    page.should have_content content
  end

  scenario 'destroy' do
    note = Note.spawn

    expect {
      visit "/notes/#{note.id}/edit"
      click_button 'Remove'
    }.should change(Note, :count).by(-1)

    current_path.should == "/notes"
  end
end