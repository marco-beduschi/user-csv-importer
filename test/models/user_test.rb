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
    assert_includes user.errors.details[:password], { error: :repeating_characters }
  end

  test 'password without uppercase character should be rejected' do
    user = User.new(password: 'abcdefghijk1')

    assert_not user.valid?
    assert_includes user.errors.details[:password], { error: :missing_uppercase_character }
  end

  test 'password without lowercase character should be rejected' do
    user = User.new(password: 'ABCDEFGHIJKL1')

    assert_not user.valid?
    assert_includes user.errors.details[:password], { error: :missing_lowercase_character }
  end

  test 'password without digit should be rejected' do
    user = User.new(password: 'abcdefghijklmnop')

    assert_not user.valid?
    assert_includes user.errors.details[:password], { error: :missing_digit }
  end

  test 'valid password should be accepted' do
    user = User.new

    valid_passwords = %w[
      Aqpfk1swods
      QPFJWz1343439
      PFSHH78KSMa
    ]

    valid_passwords.each do |password|
      user.password = password

      user.valid?

      assert_empty user.errors[:password]
    end
  end
end
