# frozen_string_literal: true

require 'csv'

class LanguageCodeValidator < ActiveModel::Validator

  def initialize(options)
    @field = options[:field]
  end

  def validate(record)
    return unless validate_empty_code(record)

    validate_language_code(record) if File.exist?(ENV['LANGUAGE_CODE_FILE_PATH'])
  end

  private

  attr_reader :field

  def validate_language_code(record)
    file = File.read(ENV['LANGUAGE_CODE_FILE_PATH'])
    language_data = CSV.parse(file, headers: true)

    return if language_data.select{ |row| code_exists?(row.to_hash, record) }.any?

    record.errors.add :base, I18n.t('glossary.errors.not_valid', field: field)

    false
  end

  def validate_empty_code(record)
    return true if record.send(field.to_sym).present?

    record.errors.add :base, I18n.t('glossary.errors.not_given', field: field)

    false
  end

  def code_exists?(data, record)
    data['code'].eql?(record.send(field.to_sym))
  end
end
