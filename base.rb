	module Base
		class Basicinfo

			@sosreport_path = nil
			def initialize(x)
				@sosreport_path = x
			end

			# Get the hostname from SOS report
			# Output - String = Hostname
			def get_hostname
				hostname = @sosreport_path + "/hostname"
				arr = IO.readlines(hostname)
				return arr[0]
			end


			# Get Satellite version 
			# Output returns String = satellite version
			def satellite_version
				
				path = @sosreport_path + "/installed-rpms"
				
				File.foreach(path) do |line|
					 if line.match("^satellite-[0-9]")
	  					return line[0...15]
	  					break
	  				 end
				end
			end

			# Get the URL from rhsm.conf 
			# output String = URL 

			def registered_to
				path = @sosreport_path + "/etc/rhsm/rhsm.conf"
				File.foreach(path) do |line|
					 if line.match("^hostname")
	  					return line[11...-1]
	  					break
	  				 end
				end
			end


			# Get df output 
			# This does not returns anything 

			def disk_utilization
				path = @sosreport_path + "/df"
				# puts File.read(path)
				File.foreach(path) do |line|
					 if line.match("var") || line.match(/root/) || line.match(/Filesystem/)
	  					puts line
	  		  		 end
				end
			end

			# Get the mount of /tmp if any 
			# Returns String full output from mount command | Needs to be worked. 

			def check_mount_point
				path = @sosreport_path + "/mount"
				data = ""
				File.foreach(path) do |line|
					 if line.match(/\/tmp/)
	  					data = data + line
	  				 end
				end
				return data
			end

			# RHEL Version
			# Returns String = /etc/redhat-release

			def rhel_version
				path = @sosreport_path + "/etc/redhat-release"
				return File.read(path)
			end

		end	
	end