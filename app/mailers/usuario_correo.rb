class UsuarioCorreo < ActionMailer::Base
  default from: "do-not-replay@example.com"

  def contacto_email(correo,correo_estudiante,materia)
  	
  	Rails.logger.info("correo de estudiante #{correo_estudiante}")


  	if (materia == "Matematica")
  		Rails.logger.info("akiiiiiiii matematica")
        correo_drive = ENV['GMAIL_USERNAME_PICHO']
    elsif (materia == "Quimica")
    	Rails.logger.info("akiiiiiiii quimica")
          correo_drive = ENV['GMAIL_USERNAME_MARIO']
    elsif (materia == "Castellano")
    	Rails.logger.info("akiiiiiiii castellano")
          correo_drive = ENV['GMAIL_USERNAME_KAREM']
	end

  	#contacto.email es el correo del visitante
  	#owner_email email del propetario del site configurado en figaro
  	@correo = correo
  	#Rails.logger.info("akiiiiiiii #{correo_estudiante}")
  	mail(to: correo_estudiante ,from: correo_drive,:subject => @correo.asunto)
  end
end
