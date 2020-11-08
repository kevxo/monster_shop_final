class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = Discount.where(merchant_id: current_user.merchant.id)
  end

  def new

  end

  def create
    merchant = current_user.merchant
    discount = merchant.discounts.new(discount_params)
    if discount.quantity >= 5 && discount.percent < 1.00 && discount.percent > 0.00
      discount.save
      redirect_to '/merchant/discounts'
    else
      flash[:error] = 'Could not create discount: quantity less than 5 or percent is incorrect'
      redirect_to '/merchant/discounts/new'
    end
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def edit

  end

  def discount_params
    params.permit(:percent, :quantity)
  end
end