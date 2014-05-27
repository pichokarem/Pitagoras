class LoginsController < ApplicationController
	def new
		@login = Login.new
	end
	
	def create
		@login = Login.new(secure_params)
		if @login.valid?
			@verificador = @login.validar_login
			if @verificador == 1
				session[:persona] = @login
				flash[:notice] = "buenas tardes profesor #{session[:persona].materia}"
				render 'paginas/gestion'
			elsif @verificador == 2
				#Rails.logger.info("akiiiiiiiiiiiiiiiiiiiiiiiiiiiiii #{@login.materias[0]}")
				session[:persona] = @login
				flash[:notice] = "buenas tardes alumno #{session[:persona].username}"
				render 'paginas/gestion_alumno'
			else
				flash[:alert] = "Username o Password incorrectos"
				render :new
			end
		else
			render :new
		end
	end

	private
	def secure_params
		params.require(:login).permit(:username,:password)
	end

end
