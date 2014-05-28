class Leer < ActiveRecord::Base

	require "rubygems"
	require "google_drive"
	has_no_table

	#column :x, :string 
	#validates_presence_of :x

	def self.leer_archivo(materia)

		if (materia == "Matematica")
			connection = GoogleDrive.login(ENV["GMAIL_USERNAME_PICHO"], ENV["GMAIL_PASSWORD"])
		elsif(materia == "Castellano")
			connection = GoogleDrive.login(ENV["GMAIL_USERNAME_KAREM"], ENV["GMAIL_PASSWORD"])
		elsif(materia == "Quimica")
			connection = GoogleDrive.login(ENV["GMAIL_USERNAME_MARIO"], ENV["GMAIL_PASSWORD"])
		end
		ss = connection.spreadsheet_by_title(materia).worksheets[0]
        retornar = Array.new(2)
        matriz = Array.new(ss.num_rows){Array.new(6)}
        
        for row in 1..ss.num_rows
  			for col in 1..6
	    		matriz[row-1][col-1] = ss[row, col]
	    		Rails.logger.info("#{matriz[row-1][col-1]}")
  			end
		end
		Rails.logger.info("#{matriz}")
		retornar[0] = matriz
		retornar[1] = ss.num_rows
		return retornar
	end
end