class ChargesController < ApplicationController
  before_action :set_charge, only: [:show, :edit, :update, :destroy, :confirm]

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
      @app = App.find(params[:app_id])
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
    user = current_user
    @cus = user.cus
    app = App.find(params[:app_id])

    if user.cus.nil?
      customer = Stripe::Customer.create(
        :email => user.email,
        :source  => params[:stripeSource]
      )
      user.update_attribute(:cus, customer.id)   
    end
    
    stripe_charge = Stripe::Charge.create(
      :customer    => user.cus,
      :amount      => app.amount,
      :description => app.name,
      :currency    => 'usd',
      :statement_descriptor => 'StripeTest Sub',
      :metadata => {'user_id' => user.id, 'editor_id' => app.editor.id, 'app_id' => app.id},
      :destination => {
        :account => app.editor.acct_id,
      }
    )

    @charge = Charge.new(
      :user_id => user.id,
      :cus => user.cus,
      :ch_id => stripe_charge.id,
      :txn_id => stripe_charge.balance_transaction,
      :address => params[:address],
      :city => params[:city],
      :state => params[:state],
      :amount => app.amount,
      :source => params[:stripeSource],
      :editor_id => app.editor.id,
    )

    respond_to do |format|
      if @charge.save!
        format.html { redirect_to @charge, notice: 'Charge was successfully created.' }
        format.json { render :show, status: :created, location: @charge }
      else
        format.html { render :new }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end

    logger.info "*" * 80
    logger.info params
    logger.info "*" * 80

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def confirm

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
      params.require(:charge).permit(:txn_id, :source, :amount, :app_id)
    end
end
