require 'test_helper'

class UserImportsControllerTest < ActionDispatch::IntegrationTest
  test '#index renders a new form' do
    get('/user_imports/new')

    assert_response :success

    assert_select 'h2', text: 'Import Users'

    form = css_select('form')
    assert form.attr('action'), '/user_imports'
    assert form.attr('method'), 'post'

    form.each do |form|
      assert_select form, 'input[name="user_import[file]"]'
      assert_select form, 'input[type="submit"]'
    end
  end

  test '#create renders the result of the import if form is valid' do
    post(
      '/user_imports',
      params: { user_import: { file: file_fixture('user_imports/file.csv') } }
    )

    assert_response :success

    assert_select 'table tr', 6
    assert_select 'table caption', text: 'Import Details'
  end

  test '#create rerenders the form if invalid' do
    post('/user_imports', params: { user_import: { file: nil } })

    assert_response :unprocessable_entity

    assert_select 'h2', text: 'Import Users'

    form = css_select('form')
    assert form.attr('action'), '/user_imports'
    assert form.attr('method'), 'post'

    form.each do |form|
      assert_select form, 'input[name="user_import[file]"]'
      assert_select form, 'p', text: "File can't be blank"
      assert_select form, 'input[type="submit"]'
    end
  end
end
