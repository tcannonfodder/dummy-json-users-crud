class PaginationCalculator
  attr_accessor :current_page, :per_page, :total_items, :current_item_count

  def initialize(current_page:, per_page:, total_items:, current_item_count:)
    self.current_page = [current_page, 1].max
    self.per_page = per_page
    self.total_items = total_items
    self.current_item_count = current_item_count
  end

  def self.pagination_offset(page:, per_page:)
    return 0 if page <= 0
    return (page - 1) * per_page
  end

  def has_next_page?
    current_offset < total_items
  end

  def has_previous_page?
    current_page > 1
  end

  def next_page
    return nil unless has_next_page?
    current_page + 1
  end

  def previous_page
    return nil unless has_previous_page?
    current_page - 1
  end

  def last_page_number
    self.total_items.fdiv(per_page).ceil
  end

  def current_offset
    ((current_page - 1) * per_page) + current_item_count
  end
end