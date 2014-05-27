class Correo < ActiveRecord::Base

	has_no_table
	
	column :mensaje, :string
	column :asunto, :string

	validates_presence_of :mensaje	

	def correo_lista(materia)

		if (materia == "Matematica")
          correo_drive = ENV['GMAIL_USERNAME_PICHO']
        elsif (materia == "Quimica")
          correo_drive = ENV['GMAIL_USERNAME_MARIO']
        elsif (materia == "Castellano")
          correo_drive = ENV['GMAIL_USERNAME_KAREM']
        end


		connection = GoogleDrive.login(correo_drive, ENV["GMAIL_PASSWORD"])
        ss = connection.spreadsheet_by_title('correo').worksheets[0]
        lista = Array.new(ss.num_rows)
        
        for row in 1..ss.num_rows
  			lista[row-1] = ss[row, 1]
		end
		return lista
	end


end
