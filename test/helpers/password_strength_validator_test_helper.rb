module PasswordStrengthValidatorTestHelper
  def self.[](klass)
    Module.new do
      define_method 'test_password_with_repeating_characters' do
        record = klass.new
        record.password = 'AAAfk1swods'

        assert_not record.valid?
        assert_includes record.errors.details[:password], { error: :repeating_characters }
      end

      define_method 'test_password_without_uppercase_character' do
        record = klass.new
        record.password = 'abcdefghijk1'

        assert_not record.valid?
        assert_includes record.errors.details[:password], { error: :missing_uppercase_character }
      end

      define_method 'test_password_without_lowercase_character' do
        record = klass.new
        record.password = 'ABCDEFGHIJKL1'

        assert_not record.valid?
        assert_includes record.errors.details[:password], { error: :missing_lowercase_character }
      end

      define_method 'test_password_without_digit' do
        record = klass.new
        record.password = 'abcdefghijklmnop'

        assert_not record.valid?
        assert_includes record.errors.details[:password], { error: :missing_digit }
      end
    end.freeze
  end
end
