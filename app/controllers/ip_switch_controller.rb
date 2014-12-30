class IpSwitchController < ApplicationController
	def index
	end


	def search
		if /\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/.match(params[:search][:term])  
			con = Mysql.new("140.113.220.170", "webadmin", "gocreating", "nagios")
			term=params[:search][:term].split(".")
			@ip_maps=IpMap.paginate(:per_page => 256, :page => params[:page], :conditions => ['IPv4_1 = ? and IPv4_2 = ? and IPv4_3 = ? and IPv4_4 = ? ', term[0], term[1], term[2], term[3]], :order=>['IPv4_3', 'IPv4_4'])       
			sql = "SELECT snmp.IP, snmp.MAC, snmp.Interface, snmp.startTime, snmp.endTime, snmp.switchIP FROM SNMP_MAPPING_#{term[2]} as snmp
WHERE snmp.IP = #{ActiveRecord::Base.sanitize(params[:search][:term])}
ORDER BY snmp.endTime DESC"
			rs = con.query(sql)
			@switch_ip = rs
			con.close
		end
		render "index"
	end
end
