require File.expand_path('helper', File.dirname(__FILE__))

scope do
  setup do
    Note.delete
  end

  test 'index' do
    visit '/'
    assert has_content? 'title'
    click_link 'new note'
    assert_equal current_path, '/notes/new'
  end

  test 'create' do
    visit '/notes/new'

    description = generate_description
    content = generate_content
    fill_in 'Description', :with => description
    fill_in 'Content', :with => content
    click_button 'Submit'

    assert_equal current_path, '/notes'
    assert has_content? description
    assert has_content? truncate(h content)
  end
end
