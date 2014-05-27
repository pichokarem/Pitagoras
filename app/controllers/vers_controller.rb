class VersController < ApplicationController

	def new
		@ver = Ver.new

	end
	def create
		@ver = Ver.new(secure_params)
		if @ver.valid?
			@lista = @ver.leer_archivo(@ver.cedula)
			@size = @lista[3]
			Rails.logger.info("size #{@size}")
			render 'notas'
		else
			redirect_to action: 'new'
		end
	end
	private 
	def secure_params
		params.require(:ver).permit(:cedula)
	end

	def notas
		return @lista = @ver.leer_archivo
	end
end