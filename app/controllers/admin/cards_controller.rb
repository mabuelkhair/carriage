class Admin::CardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]
  before_action :set_list
  before_action :authorize_as_admin
  before_action :is_list_or_card_owner, only: [:destroy, :update]
  # GET /cards
  def index
    @cards = @list.cards
    render json: @cards
  end

  # GET /cards/1
  def show
    render json: @card
  end

  # POST /cards
  def create
    @card = @list.cards.new(card_params)
    @card.owner_id = @current_user.id
    if @card.save
      render json: @card, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  def update
    if @card.update(card_params)
      render json: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1
  def destroy
    @card.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = @list.cards.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def is_list_or_card_owner
      render json: { error: 'You do not have permission for this' }, status: 403 unless @list.owner_id == @current_user.id || @card.owner_id == @current_user.id 
    
    # Only allow a trusted parameter "white list" through.
    def card_params
      params.require(:card).permit(:user_id, :title, :list_id, :description)
    end
end
