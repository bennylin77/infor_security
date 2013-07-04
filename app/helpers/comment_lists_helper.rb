# encoding: UTF-8
module CommentListsHelper
	def setColor(con)
		if con=="4"
		  "green.png"  
		elsif con=="3"
		  "yellow_d.png"
		elsif con=="2"
		  "yellow.png"     
		elsif con=="1"
		  "red.png"
		else
		  "red.png"
		end    
	end
	def Check_config(adm_user)
		if adm_user.permission_config.comment & 16 == 16
			true
		else
			false
		end
	end	
	
	def Check_handle_adm(comment,adm_user)
		if(adm_user.id == comment.handling_adm_user_id)
			true
		else 
			false
		end	
	end
end 