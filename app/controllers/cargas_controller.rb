class CargasController < ApplicationController
	

	def new
		@carga = Carga.new
	end

	def create

		@carga = Carga.new(secure_params)

		if @carga.valid?
			#Rails.logger.info("aki esta la mateira!!! #{params[:path]}")
			@carga.load_file(session[:persona].materia,params[:path])
			flash[:notice] = "buenas tardes profesor #{session[:persona].materia}"
			flash[:notice] = "Archivo de #{session[:persona].materia} subido :)"
			render 'paginas/gestion'
		else
			flash[:alert] = "No se pudo cargar el archivo"
		end
	end
	private
	def secure_params
		params.require(:carga).permit(:path)
	end
end