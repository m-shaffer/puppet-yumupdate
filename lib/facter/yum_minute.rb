Facter.add("yum_minute") do
    setcode do
        begin
        rescue
            Facter.loadfacts()
        end
        if Facter.value('ipaddress')
        # Stupidly I've had to define ip2 here, because for some reason acting upon ip was causing the
        # source facter value to be changed, meaning that anything else using the ipaddress fact broke
            ip = Facter.value('ipaddress')
            ip2 = ip.gsub(/\./, '')
            yum_minute = ip2.to_i % 60
	else
	    yum_minute = 5
	end
        yum_minute
    end
end
