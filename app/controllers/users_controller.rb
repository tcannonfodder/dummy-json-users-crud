class UsersController < ApplicationController
  PER_PAGE = 20
  before_action :build_pagination_calculator

  def index
    @users = current_page_association
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def base_association
    User.all
  end

  def current_page_association
    offset = PaginationCalculator.pagination_offset(page: params[:page].to_i, per_page: PER_PAGE)
    base_association.limit(PER_PAGE).offset(offset)
  end

  def build_pagination_calculator
    @pagination_calculator = PaginationCalculator.new(
      current_page: params[:page].to_i,
      per_page: PER_PAGE,
      total_items: base_association.count,
      current_item_count: current_page_association.count
    )
  end
end
