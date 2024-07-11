require 'test_helper'

class PasswordStrengthValidatorTest < ActiveSupport::TestCase
  class DummyModel
    include ActiveModel::Model
    attr_accessor :password

    validates_with PasswordStrengthValidator
  end

  setup do
    @dummy_model = DummyModel.new
  end

  test 'password with three repeating characters should be rejected' do
    @dummy_model.password = 'AAAfk1swods'

    assert_not @dummy_model.valid?
    assert_includes @dummy_model.errors.details[:password], { error: :repeating_characters }
  end

  test 'password without uppercase character should be rejected' do
    @dummy_model.password = 'abcdefghijk1'

    assert_not @dummy_model.valid?
    assert_includes @dummy_model.errors.details[:password], { error: :missing_uppercase_character }
  end

  test 'password without lowercase character should be rejected' do
    @dummy_model.password = 'ABCDEFGHIJKL1'

    assert_not @dummy_model.valid?
    assert_includes @dummy_model.errors.details[:password], { error: :missing_lowercase_character }
  end

  test 'password without digit should be rejected' do
    @dummy_model.password = 'abcdefghijklmnop'

    assert_not @dummy_model.valid?
    assert_includes @dummy_model.errors.details[:password], { error: :missing_digit }
  end
end
