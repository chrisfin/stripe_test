class EditorsController < ApplicationController

  # GET /editors
  # GET /editors.json
  def index
    @editors = Editor.all
  end

  # GET /editors/1
  # GET /editors/1.json
  def show
  end

  # GET /users/new
  def new
    @editor = Editor.new
  end

  # GET /editors/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @editor = Editor.new(editor_params)

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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @editor.destroy
    respond_to do |format|
      format.html { redirect_to editors_url, notice: 'Editor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = Editor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def editor_params
      params.require(:editor).permit(:first_name, :last_name, :email)
    end
end
