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

  test 'password with three repeating characters should be rejected' do
    user = User.new(password: 'AAAfk1swods')

    assert_not user.valid?
    assert_includes user.errors.details[:password], { error: :invalid, value: 'AAAfk1swods' }
    assert_includes user.errors[:password], I18n.t(
      :repeating_characters,
      scope: %i[activerecord errors models user attributes password]
    )
  end

  test 'password without uppercase character should be rejected' do
    user = User.new(password: 'abcdefghijk1')

    assert_not user.valid?
    assert_includes user.errors.details[:password], { error: :invalid, value: 'abcdefghijk1' }
    assert_includes user.errors[:password], I18n.t(
      :missing_uppercase_character,
      scope: %i[activerecord errors models user attributes password]
    )
  end

  test 'password without lowercase character should be rejected' do
    user = User.new(password: 'ABCDEFGHIJKL1')

    assert_not user.valid?
    assert_includes user.errors.details[:password], { error: :invalid, value: 'ABCDEFGHIJKL1' }
    assert_includes user.errors[:password], I18n.t(
      :missing_lowercase_character,
      scope: %i[activerecord errors models user attributes password]
    )
  end

  test 'password without digit should be rejected' do
    user = User.new(password: 'abcdefghijklmnop')

    assert_not user.valid?
    assert_includes user.errors.details[:password], { error: :invalid, value: 'abcdefghijklmnop' }
    assert_includes user.errors[:password], I18n.t(
      :missing_digit,
      scope: %i[activerecord errors models user attributes password]
    )
  end
end
