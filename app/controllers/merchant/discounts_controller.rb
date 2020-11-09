class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = Discount.where(merchant_id: current_user.merchant.id)
  end

  def new

  end

  def create
    merchant = current_user.merchant
    discount = merchant.discounts.new(discount_params)
    if discount.percent && discount.quantity >= 5 && discount.percent < 1.00 && discount.percent > 0.00 && /^0.\d{1,2}$/.match?(discount.percent.to_s)
      discount.save
      generate_flash(discount)
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
    if @discount.percent != discount_params[:percent].to_f && @discount.quantity != discount_params[:quantity].to_i
      @discount.update(discount_params)
      flash[:notice] = "Discount Updated"
      @discount.save
      redirect_to "/merchant/discounts/#{@discount.id}"
    else
      flash[:error] = "Discount Percent already in use or Discount Quantity already in use"
      redirect_to "/merchant/discounts/#{@discount.id}/edit"
    end
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to '/merchant/discounts'
  end

  private
    def discount_params
      params.permit(:percent, :quantity)
    end
end