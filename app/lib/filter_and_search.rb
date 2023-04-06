class FilterAndSearch
  include ActiveModel::API

  attr_accessor :status, :note_presence, :note, :email, :name

  def filter(scope:)
    if status.present?
      scope = scope.where(status: status)
    end

    if note_presence
      scope = scope.where("note IS NOT NULL")
    elsif note.present?
      scope = scope.where("LOWER(note) LIKE LOWER(?)", "%#{ApplicationRecord.sanitize_sql_like(note)}%")
    end

    if email.present?
      scope = scope.where("LOWER(email) LIKE LOWER(?)", "%#{ApplicationRecord.sanitize_sql_like(email)}%")
    end

    if name.present?
      scope = scope.where("LOWER(name) LIKE LOWER(?)", "%#{ApplicationRecord.sanitize_sql_like(name)}%")
    end

    return scope
  end
end