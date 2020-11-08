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
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    if @discount.percent != discount_params[:percent].to_f
      flash[:notice] = "Discount Updated"
      redirect_to "/merchant/discounts/#{@discount.id}"
    else
      flash[:error] = "#{@discount.percent} already in use"
      redirect_to "/merchant/discounts/#{@discount.id}/edit"
    end
  end

  private
    def discount_params
      params.permit(:percent, :quantity)
    end
end