require 'application_system_test_case'

class ImportUsersFromCSVTest < ApplicationSystemTestCase
  test 'importing users from CSV file' do
    visit '/'

    click_on 'Create Csv import'

    assert_text "File can't be blank"

    attach_file 'user_csv_import[file]', file_fixture('user/csv_imports/file.csv')
    click_on 'Create Csv import'

    assert_current_path '/user/csv_imports'
    assert_css 'table'
    assert_table(
      with_rows: [
        ['Muhammad', 'QPFJWz1343439', 'created'],
        ['Maria Turing', 'AAAfk1swods', 'error', 'Password cannot contain three repeating characters'],
        ['Isabella', 'Abc123', 'error', 'Password is too short (minimum is 10 characters)'],
        ['Axel', '000aaaBBBccccDDD', 'error', 'Password cannot contain three repeating characters'],
        ['Marco', 'ALLUPPERCASE', 'error',
         'Password must contain at least one digit, Password must contain at least one lowercase letter']
      ]
    )
  end
end
