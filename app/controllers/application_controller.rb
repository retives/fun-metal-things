class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_cart

  def current_cart
    if user_signed_in?
      # Знаходимо існуючий кошик або створюємо новий для юзера
      @current_cart ||= current_user.cart || current_user.create_cart
    else
      # Для гостей можна реалізувати логіку через session[:cart_id],
      # але поки обмежимося залогіненими користувачами згідно з ролями
      nil
    end
  end
end
