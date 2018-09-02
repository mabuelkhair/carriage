class User::ListsController < ApplicationController
  before_action :set_list, only: [:show]
  before_action :is_list_owner, only: [:show]

  # GET /lists
  def index
    @lists = @current_user.lists

    render json: @lists
  end

  # GET /lists/1
  def show
    render json: @list
  end


  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:title)
    end

    def is_list_owner
      render json: { error: 'You do not have permission for this' }, status: 403 unless @list.owner_id==@current_user.id
    end

end
