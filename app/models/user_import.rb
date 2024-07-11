class UserImport
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :file, :binary

  validates :file, presence: true

  def persisted?
    false
  end
end
