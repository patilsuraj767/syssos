module Foreman
	class Foremaninfo
		@sosreport_path = nil
		def initialize(x)
			@sosreport_path = x + "/sos_commands/foreman/foreman-debug"
		end

		# Get katello-service status 
		# This outputs the while file.

		def foreman_service_status
			puts "\n-------------------------------------------- Katello Service status  --------------------------------------------".red.bold
			print_count = 3
			path = @sosreport_path + "/foreman-maintain_service_status"
			File.foreach(path) do |line|

				if print_count < 2
					puts line
					print_count += 1
				elsif line.match(/^\*/) 
	  				puts line
	  				print_count = 0
	  		  	end
			end
			puts`tail -n 3 #{ path }`
			puts "\n------------------------------------------------------------------------------------------------------------------\n\n".red.bold
		end

		def hammer_ping
			path = @sosreport_path + "/hammer-ping"
			puts "\n------------------------------- Hammer ping  -------------------------------".red.bold
			puts File.read(path)
			puts "\n-----------------------------------------------------------------------------".red.bold
		end

		def version_puppet
			path = @sosreport_path + "/version_puppet"
			arr = IO.readlines(path)
			return arr[2]
		end


		def pulp_workers_count
			path = @sosreport_path + "/sos_commands/foreman/foreman-debug/etc/default/pulp_workers"
			File.foreach(path) do |line|
				if line.match("^PULP_CONCURRENCY")
	  				return line[17...-1]
	  				break
	  			end
			end
		end


	end
end