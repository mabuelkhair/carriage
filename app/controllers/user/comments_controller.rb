class User::CommentsController < ApplicationController
  before_action :authorize_as_admin
  before_action :set_list, only: [:show, :update, :destroy]
  before_action :set_card, only: [:show, :update, :destroy]
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :is_comment_owner, only: [:destroy, :update]
  before_action :is_list_member

  # GET /comments
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end
    def set_card
      @card = @list.cards.find(params[:card_id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end
    def is_comment_owner
      render json: { error: 'You do not have permission for this' }, status: 403 unless @comment.owner_id == @current_user.id 
    end
    def is_list_member
      @list.users.find(@current_user.id)
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:card_id, :comment_id, :list_id, :content)
    end
end
