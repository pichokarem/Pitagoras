class LeersController < ApplicationController

	def new
		@leer = Leer.new

	end
	def create
		@leer = Leer.new(secure_params)
		if @leer.valid?
			resp = @leer.leer_archivo(session[:persona].materia)
			@lista = resp[0]
			@num_rows = resp[1]
			render 'notas'
		else
			redirect_to action: 'new'
		end
	end

		def notas

			resp = Leer.leer_archivo(session[:persona].materia)
			@lista = resp[0]
			@num_rows = resp[1]
			render 'notas'
		
	end
	
	private 
	def secure_params
		params.require(:leer).permit(:x)
	end

	
end