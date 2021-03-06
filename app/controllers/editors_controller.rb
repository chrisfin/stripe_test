class EditorsController < ApplicationController
 before_action :set_editor, only: [:show, :edit, :update, :destroy, :account_info, :account_save, :bank_info, :bank_save, :id_info, :id_save]
  # GET /editors
  # GET /editors.json
  def index
    @editors = Editor.all
  end

  # GET /editors/1
  # GET /editors/1.json
  def show
  end

  # GET /editors/new
  def new
    @editor = Editor.new
  end

  # GET /editors/1/edit
  def edit
  end

  # POST /editors
  # POST /editors.json
  def create
    @editor = Editor.new(editor_params)

    account = Stripe::Account.create(
      :type => 'custom',
      :country => 'US',
      :email => @editor.email,
      :legal_entity => {      
          :dob => {
              :day => @editor.dob.day,
              :month => @editor.dob.month,
              :year => @editor.dob.year,
          },
          :first_name => @editor.first_name,
          :last_name => @editor.last_name,
          :type => "individual",
      },
      :tos_acceptance => {
           :date => Time.now.to_i,
           :ip => request.remote_ip, 
      },
    )

    @editor.acct_id = account.id

    respond_to do |format|
      if @editor.save!
        format.html { redirect_to @editor, notice: 'Editor was successfully created.' }
        format.json { render :show, status: :created, location: @editor }
      else
        format.html { render :new }
        format.json { render json: @editor.errors, status: :unprocessable_entity }
      end
    end
  end

  def account_info
    @acct = Stripe::Account.retrieve(@editor.acct_id)
  end

  def account_save
    acct = Stripe::Account.retrieve(@editor.acct_id) 
    acct.account_token = params[:accountToken]
    acct.metadata = {id: @editor.id}
    
      if acct.save
        redirect_to :editors_bank_info
      else
        format.html { render :editors_account_info }
      end
  end

  def bank_info
    @acct = Stripe::Account.retrieve(@editor.acct_id)
  end

  def bank_save
    acct = Stripe::Account.retrieve(@editor.acct_id) 
    acct.external_account = params[:bankToken]

    if acct.save
        redirect_to @editor
    else
        format.html { render :editors_bank_info }
    end
  end

  def id_info
  end

  def id_save
    acct = Stripe::Account.retrieve(@editor.acct_id) 
    acct.legal_entity.verification.document = params[:idToken]

    if acct.save
        redirect_to @editor
    else
        format.html { render :editors_id_info }
    end
  end

  # PATCH/PUT /editors/1
  # PATCH/PUT /editors/1.json
  def update
    respond_to do |format|
      if @editor.update(editor_params)
        format.html { redirect_to @editor, notice: 'Editor was successfully updated.' }
        format.json { render :show, status: :ok, location: @editor }
      else
        format.html { render :edit }
        format.json { render json: @editor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /editors/1
  # DELETE /editors.json
  def destroy
    @editor.destroy
    respond_to do |format|
      format.html { redirect_to editors_url, notice: 'Editor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_editor
      @editor = Editor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def editor_params
      params.require(:editor).permit(:first_name, :last_name, :email, :dob, :password, :password_confirmation, :bankToken, :accountToken)
    end
end
