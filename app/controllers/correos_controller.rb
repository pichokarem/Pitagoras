class CorreosController < ApplicationController
	def new
		@correo = Correo.new
	end
	def create
		@correo = Correo.new(secure_params)
		if @correo.valid?
			lista = @correo.correo_lista(session[:persona].materia)			
			for i in 0..lista.size-1
				UsuarioCorreo.contacto_email(@correo,lista[i],session[:persona].materia).deliver
			end
			flash[:notice] = "Correo enviado a los estudiantes"
			render 'paginas/gestion'
		else
			render :new
		end
	end
	private
	def secure_params
		params.require(:correo).permit(:mensaje, :asunto)
	end
end
