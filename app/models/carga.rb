class Carga < ActiveRecord::Base

    require 'spreadsheet' 
    require 'rubygems'  
    
    has_no_table

    column :path, :string

    def load_file(materia,ruta)
        
        Rails.logger.info("holaaaaaaaaa ruta #{ruta}")
        Rails.logger.info("Akiiiiiiiiiiiiiiiiiiiiiii #{ruta.original_filename}")
        Rails.logger.info("cual materia es  #{materia}")
        Spreadsheet.client_encoding = 'UTF-8'
        if (materia == "Matematica")
            book = Spreadsheet.open "/home/picho/Escritorio/prueba.xls"
            materia = "Matematica"
        
        elsif(materia == "Castellano")
            book = Spreadsheet.open "/home/picho/Escritorio/prueba.xls"
            materia = "Castellano"
        
        elsif(materia == "Quimica")
            book = Spreadsheet.open "/home/picho/Escritorio/prueba.xls"
            materia = "Quimica"
        end
        #book = Spreadsheet.open "/Users/karemsegura/Desktop/prueba.xls"
        sheet = book.worksheet 0
        columna = 1
        sheet.each do |row|
            actualizar_drive(row,columna,materia)
            columna = columna + 1
        end

    end

    def actualizar_drive(row,c,materia)
      
        if (materia == "Matematica")
            connection = GoogleDrive.login(ENV["GMAIL_USERNAME_PICHO"], ENV["GMAIL_PASSWORD"])    
            ss = connection.spreadsheet_by_title(materia)
        elsif(materia == "Castellano")
            connection = GoogleDrive.login(ENV["GMAIL_USERNAME_KAREM"], ENV["GMAIL_PASSWORD"])    
            ss = connection.spreadsheet_by_title(materia)
        else (materia == "Quimica")
            connection = GoogleDrive.login(ENV["GMAIL_USERNAME_MARIO"], ENV["GMAIL_PASSWORD"])    
            ss = connection.spreadsheet_by_title(materia)
        end
        if ss.nil? 
            ss = connection.create_spreadsheet(materia) 
        end 
       
        ws = ss.worksheets[0] 
        columna = 1
        row.each do |estudiante|

            if columna == 1
                ws[c,columna] = estudiante
                if columna == 6
                    c = c + 1
                end
            else
                ws[c,columna] = estudiante
            end
            columna = columna + 1
            ws.save
        end    
    end

end



