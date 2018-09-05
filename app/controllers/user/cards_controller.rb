class User::CardsController < ApplicationController
  before_action :set_list
  before_action :set_card, only: [:show, :update, :destroy]
  before_action :is_card_owner, only: [:destroy, :update]
  before_action :is_list_member
  # GET /cards
  def index
    # get card ids in this list from cache then get number of comments of each card from cache
    # after that sort card ids based on number of comments then get those cards from DB
    cards_ids = $redis.lrange("list:#{@list.id}:cards", 0, -1)
    if cards_ids != []
      card_comment_dic = {}
      for card_id in cards_ids
        number_of_comments = $redis.get("card:#{card_id}:comments")
        number_of_comments = 0 unless number_of_comments
        card_comment_dic[card_id] = number_of_comments.to_i
      end
      card_comment_dic = card_comment_dic.sort_by { |key,val| val}.reverse!
      id_list = []
      card_comment_dic.each do |val|
        id_list.append(val[0])
      end
      @cards = Card.find(id_list)
    else
      @cards = @list.cards
    end
    render json: @cards, each_serializer: CardSerializer
  end

  # GET /cards/1
  def show
    render json: @card, serializer: CardSerializer
  end

  # POST /cards
  def create
    @card = @list.cards.new(card_params)
    @card.owner_id = @current_user['id']
    if @card.save
      $redis.rpush("list:#{@list.id}:cards",@card.id)
      render json: @card, status: :created, serializer: CardSerializer
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  def update
    if @card.update(card_params)
      render json: @card, serializer: CardSerializer
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1
  def destroy
    $redis.lrem("list:#{@list.id}:cards", 0, @card.id)
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

    def is_list_member
      @list.users.find(@current_user['id'])
    end
    def is_card_owner
      render json: { error: 'You do not have permission for this' }, status: 403 unless @card.owner_id == @current_user['id'] 
    end
    # Only allow a trusted parameter "white list" through.
    def card_params
      params.require(:card).permit(:user_id, :title, :list_id, :description)
    end
end
