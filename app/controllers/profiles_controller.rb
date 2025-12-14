class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def show
    @orders = current_user.orders.order(created_at: :desc)
    @reviews = current_user.reviews.includes(:item)
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "Ваш профіль успішно оновлено! 🤘"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  private

  def set_profile
    @profile = current_user.profile || current_user.create_profile
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :phone_number)
  end
end
