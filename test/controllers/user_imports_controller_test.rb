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
end
