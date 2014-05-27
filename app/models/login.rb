class Login < ActiveRecord::Base
	
	has_no_table

	column :username, :string
	column :password, :string
	column :materia, :string
	column :status, :string

	validates_presence_of :username
	validates_presence_of :password

	def validar_login

		if self.username == "picho" and self.password == "1234"
			self.materia = "Matematica"
			self.status = "profesor"
			return 1
		elsif self.username == "karem" and self.password == "1234"
			self.materia = "Castellano"
			self.status = "profesor"
			return 1
		elsif self.username == "mario" and self.password == "1234"
			self.materia = "Quimica"
			self.status = "profesor"
			return 1
		elsif self.username == "carlos"  and self.password == "1234"
			self.materia = "nulo"
			self.status = "alumno"
			return 2
		elsif self.username == "claudia"  and self.password == "1234"
			self.materia = "nulo"
			self.status = "alumno"
			return 2
		elsif self.username == "gabriel"  and self.password == "1234"
			self.materia = "nulo"
			self.status = "alumno"
			return 2
		else
			return false
		end
	end
end