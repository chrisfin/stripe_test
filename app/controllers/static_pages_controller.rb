class StaticPagesController < ApplicationController
	def home
		@apps = App.all
	end
end
