class SuscriptorsController < ApplicationController
	def new
		@suscriptor = Suscriptor.new
	end
	def create
		@suscriptor = Suscriptor.new(secure_params)
		
		verificador = @suscriptor.materias_inscritas(@suscriptor.cedula)

		if @suscriptor.suscripcion(verificador)
			if (verificador[3] >= 0)
				flash[:notice] = "Se suscribio el #{@suscriptor.email} sus materias "
				render "paginas/gestion_alumno"
			
			else
				flash[:alert] = "No se suscribio #{@suscriptor.email}"
				render :new
			end
		else
			flash[:alert] = "No se suscribio #{@suscriptor.email}"
			render :new
		end
	end
	private
	def secure_params
		params.require(:suscriptor).permit(:email,:cedula)
	end

end
