require 'test_helper'

class UserImportTest < ActiveSupport::TestCase
  test 'file is required' do
    user_import = UserImport.new(file: nil)

    assert_not user_import.valid?
    assert_includes user_import.errors.details[:file], { error: :blank }
  end

  test 'it is not persisted' do
    assert_not UserImport.new.persisted?
  end

  test 'creates users from file' do
    user_import = UserImport.new(file: file_fixture('user_imports/file.csv'))

    user_import.import

    assert_equal 5, user_import.users.length
    assert_equal 1, user_import.users.select(&:valid?).length
  end

  test 'does not create users if file is empty' do
    user_import = UserImport.new(file: file_fixture('user_imports/file_empty.csv'))

    user_import.import

    assert_equal 0, user_import.users.length
    assert_empty user_import.users
  end
end
