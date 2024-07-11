class User < ApplicationRecord
  validates :name, presence: true
  validates :password, presence: true
  validates :password, length: { in: 10..16 }
  validates :password, format: {
    without: /(.)\1{2}/,
    message: I18n.t(
      :repeating_characters,
      scope: %i[activerecord errors models user attributes password]
    )
  }
  validates :password, format: {
    with: /[a-z]/,
    message: I18n.t(
      :missing_lowercase_character,
      scope: %i[activerecord errors models user attributes password]
    )
  }
  validates :password, format: {
    with: /[A-Z]/,
    message: I18n.t(
      :missing_uppercase_character,
      scope: %i[activerecord errors models user attributes password]
    )
  }
  validates :password, format: {
    with: /\d/,
    message: I18n.t(
      :missing_digit,
      scope: %i[activerecord errors models user attributes password]
    )
  }
end
