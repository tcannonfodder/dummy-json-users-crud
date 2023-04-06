class FilterAndSearch
  include ActiveModel::API

  attr_accessor :status, :note_presence, :note, :email, :name
end