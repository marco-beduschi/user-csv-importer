require 'test_helper'

class UserImportsControllerTest < ActionDispatch::IntegrationTest
  test '#index renders a new form' do
    get('/user_imports/new')

    assert_response :success

    form = css_select('form')

    assert form.attr('action'), '/user_imports'
    assert form.attr('method'), 'post'

    form.each do |form|
      assert_select form, 'input[name="user_import[file]"]'
      assert_select form, 'input[type="submit"]'
    end
  end

  test '#create rerenders the form if invalid' do
    post('/user_imports', params: { user_import: { file: nil } })

    assert_response :unprocessable_entity

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
