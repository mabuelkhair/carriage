class User::ListsController < ApplicationController
  before_action :set_list, only: [:show]
  before_action :is_list_member, only: [:show]

  # GET /lists
  def index
    @lists = List.where(owner_id: @current_user['id']) 

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

    def is_list_member
      @list.users.find(@current_user['id'])
    end

end
