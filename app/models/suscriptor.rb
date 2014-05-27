class Suscriptor < ActiveRecord::Base

	has_no_table
	
	column :email, :string
	validates_presence_of :email
	validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

	column :cedula, :string
	validates_presence_of :cedula

  	def suscripcion(materias)

    	mailchimp = Gibbon::API.new
      result = mailchimp.lists.subscribe({
                  :id => ENV['MAILCHIMP_LIST_ID'], :email => {
                    :email => self.email},
                    :double_optin => false,#confirmacion del coreeo enviado al suscriptor
                    :update_existing => true,
                    :send_welcome => true
                 })
       
      for i in 0..materias[3]
        if (materias[i] == "Matematica")
          correo = ENV['MAILCHIMP_LIST_ID_MATEMATICA']
          correo_drive = ENV['GMAIL_USERNAME_PICHO']
          lista_correo(materias[i],correo_drive)
          Rails.logger.info("matematica #{correo}")
        elsif (materias[i] == "Quimica")
          correo = ENV['MAILCHIMP_LIST_ID_QUIMICA']
          correo_drive = ENV['GMAIL_USERNAME_MARIO']
          lista_correo(materias[i],correo_drive)
          Rails.logger.info("quimica #{correo}")
        elsif (materias[i] == "Castellano")
          correo = ENV['MAILCHIMP_LIST_ID_CASTELLANO']
          correo_drive = ENV['GMAIL_USERNAME_KAREM']
          lista_correo(materias[i],correo_drive)
          Rails.logger.info("castellano #{correo}")
        end

        result = mailchimp.lists.subscribe({
                  :id => correo, :email => {
                        :email => self.email},
                        :double_optin => false,#confirmacion del coreeo enviado al suscriptor
                        :update_existing => true,
                        :send_welcome => true
                 })
       
    end

    Rails.logger.info("Suscrito  #{self.email} a MailChimp") if result end


def materias_inscritas(cedula)
        contador = 0
        lista = Array.new(4)

##MATEMATICA
    connection = GoogleDrive.login(ENV["GMAIL_USERNAME_PICHO"], ENV["GMAIL_PASSWORD"])
        ss = connection.spreadsheet_by_title("Matematica").worksheets[0]

        for row in 1..ss.num_rows
        if (ss[row,3] == cedula)
          lista[contador] = "Matematica"
          contador = contador + 1
        end
    end
    Rails.logger.info("lista1 #{lista}")

##CASTELLANO
    connection = GoogleDrive.login(ENV["GMAIL_USERNAME_KAREM"], ENV["GMAIL_PASSWORD"])
        ss = connection.spreadsheet_by_title("Castellano").worksheets[0]

        for row in 1..ss.num_rows
        if (ss[row,3] == cedula)
          lista[contador] = "Castellano"
          contador = contador + 1
        end
    end
    Rails.logger.info("lista2 ---> #{lista}")
    
##QUIMICA
    connection = GoogleDrive.login(ENV["GMAIL_USERNAME_MARIO"], ENV["GMAIL_PASSWORD"])
        ss = connection.spreadsheet_by_title("Quimica").worksheets[0]

        for row in 1..ss.num_rows
        if (ss[row,3] == cedula)
          lista[contador] = "Quimica"
          contador = contador + 1
        end
    end
    lista[3] = contador - 1
    return lista
  end

 def lista_correo(materia,correo_drive)
      
        connection = GoogleDrive.login(correo_drive, ENV["GMAIL_PASSWORD"]) 
        ss = connection.spreadsheet_by_title('correo')
        if ss.nil? 
           ss = connection.create_spreadsheet('correo') 
        end 
        ws = ss.worksheets[0] 
        last_row = 1 + ws.num_rows 
        ws[last_row, 1] = self.email 
        ws.save 
    end 
end

