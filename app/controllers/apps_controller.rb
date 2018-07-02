class AppsController < ApplicationController
	before_action :set_app, only: [:show, :edit, :update, :destroy]

  	def new
    	@app = App.new
    	@editor = Editor.find(params[:editor_id])
  	end

  	def create
    	@app = App.new(app_params)

    	respond_to do |format|
      	if @app.save!
	        format.html { redirect_to @app, notice: 'App was successfully created.' }
	        format.json { render :show, status: :created, location: @app }
	      else
	        format.html { render :new }
	        format.json { render json: @app.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def show

  	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:amount, :name, :editor_id)
    end
end
