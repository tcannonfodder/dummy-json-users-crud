class UsersController < ApplicationController
  PER_PAGE = 20
  before_action :build_pagination_calculator, only: [:index]
  before_action :load_user, only: [:expand, :collapse, :show, :edit, :update, :destroy]

  def index
    @users = current_page_association
  end

  def new
  end

  def create
  end

  def show
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def expand
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to action: :show}
    end
  end

  def collapse
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to action: :index}
    end
  end

  def edit
  end

  def update
    @user.update!(update_params)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to action: :show}
    end
  end

  def destroy
  end

  protected

  def update_params
    params.require(:user).permit(:status, :notes)
  end

  def load_user
    @user = User.find(params[:id])
  end

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
