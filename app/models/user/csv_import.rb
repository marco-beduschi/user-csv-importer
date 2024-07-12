require 'csv'

class User::CsvImport
  include ActiveModel::API

  attr_accessor :file, :users

  validates :file, presence: true

  def import
    users = []

    CSV.foreach(file) do |row|
      name, password = row
      header = name == 'name' && password == 'password'

      next if header
      next if row.empty?

      users << User.create(name:, password:)
    end

    self.users = users
  end

  def persisted?
    false
  end
end
