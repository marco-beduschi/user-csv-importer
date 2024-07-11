require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name is required' do
    user = User.new(name: nil)

    assert_not user.valid?
    assert_includes user.errors.details[:name], { error: :blank }
  end

  test 'password is required' do
    user = User.new(password: nil)

    assert_not user.valid?
    assert_includes user.errors.details[:password], { error: :blank }
  end
end
