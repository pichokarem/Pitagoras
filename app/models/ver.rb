class Ver < ActiveRecord::Base

	require "rubygems"
	require "google_drive"
	has_no_table

	column :cedula, :string 
	validates_presence_of :cedula

	def leer_archivo(cedula)
		contador = 0
        registro1 = Array.new(7)
        registro2 = Array.new(7)
        registro3 = Array.new(7)
        lista = Array.new(4)

##MATEMATICA
		connection = GoogleDrive.login(ENV["GMAIL_USERNAME_PICHO"], ENV["GMAIL_PASSWORD"])
        ss = connection.spreadsheet_by_title("Matematica").worksheets[0]

        Rails.logger.info("cedula---->#{cedula}")

        for row in 1..ss.num_rows
			Rails.logger.info("registro---->#{ss[row,3]}")        	
  			if (ss[row,3] == cedula)
  				Rails.logger.info("registro dent if---->#{ss[row,3]}")      
  				for col in 1..6
		    		registro1[col-1] = ss[row, col]
		    	end
		    	registro1[6] = "Matematica"
		    	lista[contador] = registro1
		    	Rails.logger.info("matematica #{lista[contador]}")
		    	contador = contador + 1
		    end
		end
		Rails.logger.info("lista1 #{lista}")

##CASTELLANO
		connection = GoogleDrive.login(ENV["GMAIL_USERNAME_KAREM"], ENV["GMAIL_PASSWORD"])
        ss = connection.spreadsheet_by_title("Castellano").worksheets[0]

        for row in 1..ss.num_rows
  			if (ss[row,3] == cedula)
  				for col in 1..6
		    		registro2[col-1] = ss[row, col]
		    	end
		    	registro2[6] = "Castellano"
		    	lista[contador] = registro2
		    	Rails.logger.info("castellano #{lista[contador]}")
		    	contador = contador + 1
		    end
		end
		Rails.logger.info("lista2 ---> #{lista}")
		
##QUIMICA
		connection = GoogleDrive.login(ENV["GMAIL_USERNAME_MARIO"], ENV["GMAIL_PASSWORD"])
        ss = connection.spreadsheet_by_title("Quimica").worksheets[0]

        for row in 1..ss.num_rows
  			if (ss[row,3] == cedula)
  				for col in 1..6
		    		registro3[col-1] = ss[row, col]
		    	end
		    	registro3[6] = "Quimica"
		    	lista[contador] = registro3
		    	Rails.logger.info("quimica #{lista[contador]}")
		    	contador = contador + 1
		    end
		end
		Rails.logger.info("lista3 #{lista}")
		lista[3] = contador - 1
		return lista
	end
end