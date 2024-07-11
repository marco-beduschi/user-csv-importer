class PasswordStrengthValidator < ActiveModel::Validator
  def validate(record)
    validate_inclusion_of_digit(record)
    validate_inclusion_of_lowercase(record)
    validate_inclusion_of_uppercase(record)
    validate_exclusion_of_repeating_chars(record)
  end

  private

  def validate_inclusion_of_digit(record)
    inclusion_of_digit_regex = /\d/

    return if record.password.to_s =~ inclusion_of_digit_regex

    record.errors.add(:password, :missing_digit)
  end

  def validate_inclusion_of_uppercase(record)
    inclusion_of_uppercase_char_regex = /[A-Z]/

    return if record.password.to_s =~ inclusion_of_uppercase_char_regex

    record.errors.add(:password, :missing_uppercase_character)
  end

  def validate_inclusion_of_lowercase(record)
    inclusion_of_lowercase_char_regex = /[a-z]/

    return if record.password.to_s =~ inclusion_of_lowercase_char_regex

    record.errors.add(:password,
                      :missing_lowercase_character)
  end

  def validate_exclusion_of_repeating_chars(record)
    character_repeats_trice_regex = /(.)\1{2}/

    record.errors.add(:password, :repeating_characters) if record.password.to_s =~ character_repeats_trice_regex
  end
end
