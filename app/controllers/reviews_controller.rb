class ReviewsController < ApplicationController
  before_action :authenticate_user! # Лише авторизовані користувачі (Вимога 3.2.1)

  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to item_path(@item), notice: "Ваш відгук успішно додано!"
    else
      redirect_to item_path(@item), alert: "Помилка: відгук не може бути порожнім, а рейтинг має бути від 1 до 5."
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :details)
  end
end
