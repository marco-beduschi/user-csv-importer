require 'test_helper'

class User::CsvImportTest < ActiveSupport::TestCase
  test 'file is required' do
    user_import = User::CsvImport.new(file: nil)

    assert_not user_import.valid?
    assert_includes user_import.errors.details[:file], { error: :blank }
  end

  test 'it is not persisted' do
    assert_not User::CsvImport.new.persisted?
  end

  test 'attempts to users from file' do
    user_import = User::CsvImport.new(file: file_fixture('user/csv_imports/file.csv'))

    user_import.import

    assert_equal(
      [
        ['Muhammad', 'QPFJWz1343439', true],
        ['Maria Turing', 'AAAfk1swods', false],
        ['Isabella', 'Abc123', false],
        ['Axel', '000aaaBBBccccDDD', false],
        ['Marco', 'ALLUPPERCASE', false]
      ],
      user_import.users.map { [_1.name, _1.password, _1.persisted?] }
    )
  end

  test 'does not create users if file is empty' do
    user_import = User::CsvImport.new(file: file_fixture('user/csv_imports/file_empty.csv'))

    user_import.import

    assert_empty user_import.users
  end
end
