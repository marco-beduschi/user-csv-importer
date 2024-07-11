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

  test 'password too short should be rejected' do
    user = User.new(password: 'Abc123')

    assert_not user.valid?
    assert_includes user.errors.details[:password], { error: :too_short, count: 10 }
  end

  test 'password too long should be rejected' do
    user = User.new(password: 'Abc12345678900000')

    assert_not user.valid?
    assert_includes user.errors.details[:password], { error: :too_long, count: 16 }
  end
end
