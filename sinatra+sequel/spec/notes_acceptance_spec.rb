require 'spec_helper'

feature 'Notes' do

  let(:description) { generate_description }
  let(:content) { generate_content }

  background do
    Note.delete
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
    }.to change(Note, :count).by(1)

    current_path.should == '/notes'
    page.should satisfy {
      have_content description
      have_content truncate(h content)
    }
  end

  scenario 'update' do
    note = Note.spawn

    expect {
      visit "/notes/#{note.id}/edit"
      fill_in 'Description', :with => description
      fill_in 'Content', :with => content
      click_button 'Update'
    }.to_not change(Note, :count)

    current_path.should == "/notes/#{note.id}"
    page.should satisfy {
      !have_content note.title
      !have_content note.body
      have_content description
      have_content content
    }
  end

  scenario 'destroy' do
    note = Note.spawn

    expect {
      visit "/notes/#{note.id}/edit"
      click_button 'Remove'
    }.to change(Note, :count).by(-1)

    current_path.should == "/notes"
  end
end
