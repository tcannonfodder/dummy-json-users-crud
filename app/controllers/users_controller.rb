class UsersController < ApplicationController
  PER_PAGE = 20
  before_action :build_pagination_calculator, only: [:index]
  before_action :build_filter_and_search, only: [:index]
  before_action :load_user, only: [:expand, :collapse, :show, :edit, :update, :destroy]
  before_action :load_bulk_action_users, only: [:destroy_multiple, :update_multiple]

  helper_method :filter_and_search_params

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
    @user.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to action: :index}
    end
  end

  def destroy_multiple
    @bulk_action_users.destroy_all
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to action: :index}
    end
  end

  def update_multiple
    @bulk_action_users.update_all(status: bulk_action_params[:status])
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to action: :index}
    end
  end

  protected

  def load_bulk_action_users
    @bulk_action_users = User.where(id: bulk_action_params[:user_ids])
  end

  def filter_and_search_params
    params.permit(filter_and_search: [:status, :note_presence, :note, :email, :name])
  end

  def build_filter_and_search
    @filter_and_search = FilterAndSearch.new(filter_and_search_params[:filter_and_search])
  end

  def update_params
    params.require(:user).permit(:status, :notes)
  end

  def bulk_action_params
    params.require(:bulk_action).permit(:status, user_ids: [])
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
