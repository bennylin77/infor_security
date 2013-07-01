# encoding: UTF-8
module CommentListHelper
	def setColor(con)
		if con=="4"
		  "green.png"  
		elsif con=="3"
		  "yellow_d.png"
		elsif con=="2"
		  "yellow.png"     
		elsif con=="1"
		  "red.png"

		end    
	end
	def Check_config(adm_user)
		if adm_user.name=="許郡泓" or adm_user.name=="葉仲軒" or adm_user.name=="林起" or adm_user.name=="羅濟韋"
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