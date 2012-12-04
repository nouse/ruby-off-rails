require_relative 'test_helper'

scope do

  def description
    @description ||= generate_description
  end

  def content
    @content ||= generate_content
  end

  test 'it should show index page correctly' do
    visit '/'
    assert has_content?('title')
    click_link 'new note'
    assert_equal '/notes/new', current_path
  end

  test 'it should create notes correctly' do
    db {
      visit '/notes/new'

      original_count = Note.count

      fill_in 'Description', :with => description
      fill_in 'Content', :with => content
      click_button 'Create'

      assert_equal original_count+1, Note.count

      assert_equal '/notes', current_path
      assert has_content?(description)
      assert has_content?(truncate(content))
    }
  end

  test 'it should update notes correctly' do
    db {
      note = Fabricate(:note)
      note.save
      visit "/notes/#{note.id}/edit"

      assert has_field?('Description', :with => note.title)
      assert has_field?(note.body)

      original_count = Note.count

      fill_in 'Description', :with => description
      fill_in 'Content', :with => content
      click_button 'Update'

      assert_equal original_count, Note.count

      assert_equal "/notes/#{note.id}", current_path

      assert !has_content?(note.title)
      assert !has_content?(note.body)
      assert has_content?(description)
      assert has_content?(content)
    }
  end

  test 'it should delete notes correctly' do
    db {
      note = Fabricate(:note)
      note.save
      visit "/notes/#{note.id}/edit"

      original_count = Note.count

      click_button 'Remove'

      assert_equal original_count-1, Note.count

      assert_equal "/notes", current_path
    }
  end
end
