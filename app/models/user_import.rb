class UserImport
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :file, :binary

  validates :file, presence: true

  def import; end

  def persisted?
    false
  end
end
