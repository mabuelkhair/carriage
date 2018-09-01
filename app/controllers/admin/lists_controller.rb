class Admin::ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy, :assign_member, :unassign_member]
  before_action :authorize_as_admin
  before_action :is_owner, only: [:update, :destroy, :assign_member, :unassign_member]
  before_action :set_user, only: [:assign_member, :unassign_member]

  # GET /lists
  def index
    @lists = List.all

    render json: @lists
  end

  # GET /lists/1
  def show
    render json: @list
  end

  # POST /lists
  def create
    @list = @current_user.owned_lists.new(list_params)

    if @list.save
      @list.users << @current_user
      render json: @list, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
  end

  def assign_member
    @list.users << @user
  end

  def unassign_member
    @user.lists.delete(@list)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def list_params
      params.require(:list).permit(:title)
    end


    def is_list_owner
      render json: { error: 'You do not have permission for this' }, status: 403 unless @list.owner_id==@current_user.id
    end

    def set_user
      @user = User.find(params[:user_id])
    end

end
