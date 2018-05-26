class ChargesController < ApplicationController
  before_action :set_charge, only: [:show, :edit, :update, :destroy]

  # GET /charges
  # GET /charges.json
  def index
    @charges = Charge.all
  end

  # GET /charges/1
  # GET /charges/1.json
  def show
  end

  # GET /charges/new
  def new
    if logged_in?
      @charge = Charge.new
    else
      redirect_to login_url
    end
  end

  # GET /charges/1/edit
  def edit
  end

  # POST /charges
  # POST /charges.json
  def create
    # Amount in cents
    @amount = 3500
    user = current_user
    @name_on_card = "Chris"
    @cus = user.cus

    if user.cus.nil?
      customer = Stripe::Customer.create(
        :email => user.email,
        :source  => params[:stripeSource]
      )
      user.update_attribute(:cus, customer.id)   
    end
    
    stripe_charge = Stripe::Charge.create(
      :customer    => user.cus,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd',
      :statement_descriptor => 'LiveArticle Sub',
      :metadata => {'order_id' => 6735},
    )

    @charge = Charge.new(
        :user_id => user.id,
        :ch_id => stripe_charge.id,
        :txn_id => stripe_charge.balance_transaction,
        :address => params[:address],
        :city => params[:city],
        :state => params[:state],
        :amount => @amount,
        :source => params[:stripeSource],
      )

    respond_to do |format|
      if @charge.save
        format.html { redirect_to @charge, notice: 'Charge was successfully created.' }
        format.json { render :show, status: :created, location: @charge }
      else
        format.html { render :new }
        format.json { render json: @chrage.errors, status: :unprocessable_entity }
      end
    end

    logger.info "*" * 80
    logger.info params
    logger.info "*" * 80

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  # PATCH/PUT /charges/1
  # PATCH/PUT /charges/1.json
  def update
    respond_to do |format|
      if @charge.update(charge_params)
        format.html { redirect_to @charge, notice: 'Charge was successfully updated.' }
        format.json { render :show, status: :ok, location: @charge }
      else
        format.html { render :edit }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    @charge.destroy
    respond_to do |format|
      format.html { redirect_to charges_url, notice: 'Charge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_charge
      @charge = Charge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def charge_params
      params.require(:charge).permit(:txn_id, :source)
    end
end
