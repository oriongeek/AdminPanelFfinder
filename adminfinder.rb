#!/usr/bin/env ruby


begin
require 'rainbow/ext/string'
require 'net/http'
rescue LoadError
p "Missing Gems rainbow and net/http"
exit
end


trap "SIGINT" do
  puts "Exiting\n"
  exit 130
end


puts <<LOGO
                                                 
╔═╗┌┬┐┌┬┐┬┌┐┌    ╔═╗┌─┐┌┐┌┌─┐┬    
╠═╣ │││││││││    ╠═╝├─┤│││├┤ │    
╩ ╩─┴┘┴ ┴┴┘└┘────╩  ┴ ┴┘└┘└─┘┴─┘  
╔═╗┬┌┐┌┌┬┐┌─┐┬─┐                  
╠╣ ││││ ││├┤ ├┬┘                  
╚  ┴┘└┘─┴┘└─┘┴└─  

LOGO

puts "\n\nEnter the website address abc.com {without http or www}".color(:red)
site = gets.chomp

puts "Enter the extension as html, php, asp, htm, aspx, etc".color(:yellow)
ext = gets.chomp

puts "\n\n"

list = %w{admin administrator admin/controlpanel admin123 admin1 admin2 admin2/login login admin2/index admin3 admin4 admin5 admin/admin admin/cp 
admin_area admin/index adminarea/index adminarea/admin admin/account admin_Login acceso bb-admin adminLogin admincontrol admin-login 
pages/admin/admin-login siteadmin affiliate siteadmin/login siteadmin/index admin/index admin/login adminarea/login usuarios usuario 
panel-administracion/login home moderator moderator/login webadmin adminarea bb-admin/index bb-admin/login bb-admin/admin cp adm admloginuser 
adm_auth instadmin memberadmin controlpanel user home wp-login adminarea/index panel-administracion/index administracion/admin 
modelsearch/index modelsearch/admin model modelsearch/login administrator_login administratorlogin panel-administracion/index 
panel-administracion/admin webadmin webadmin/index webadmin/admin }

begin
for count in 0...list.count
#  print "Checking #{site}/#{list[count]}.#{ext}".colorize(:white)
res = Net::HTTP.get_response(site, "/#{list[count]}.#{ext}") 
res = res.to_s
div = res.split(":")

if res.include?("HTTPOK") or res.include?("HTTPFound")
  puts "#{site}/#{list[count]}.#{ext} :: Server Says #{div[2]}".color(:green).blink
 else
puts "#{site}/#{list[count]}.#{ext}".color(:red)
end
end

rescue => e
p "Error Occurred: #{e}".color(:red)
end
