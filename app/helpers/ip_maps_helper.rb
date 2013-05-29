# encoding: UTF-8
module IpMapsHelper

  def areaBuildingsOptions
    options = Hash.new 
    CampusBuildingsList.order("campus_name").all.each do |s|  
        options[s.campus_name+'-'+s.building_name]=s.id 
    end            
    options
  end
  
end
