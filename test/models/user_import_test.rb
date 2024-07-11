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
end
