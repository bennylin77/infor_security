# encoding: UTF-8
class IpMapsController < ApplicationController
  
  before_filter(:only => [:create, :new]) { |c| c.checkPermission('ip', Infor::Application.config.CREATE_PERMISSION)}        
  before_filter(:only => [:search, :filter]) { |c| c.checkPermission('ip', Infor::Application.config.READ_PERMISSION)}
  before_filter(:only => [:block, :alwaysVisible]) { |c| c.checkPermission('ip', Infor::Application.config.UPDATE_PERMISSION)}         
  before_filter(:only => [:edit, :update, :show]) { |c| c.checkUser('ip', Infor::Application.config.UPDATE_PERMISSION, params[:id])}    
  
  def index
    adm_user=AdmUser.find(session[:adm_user_id])
    if adm_user.permission_config.ip & Infor::Application.config.READ_PERMISSION != 0 
      @ip_maps = IpMap.paginate(:per_page => 256, :page => params[:page]).order('IPv4_3', 'IPv4_4')
    else    
      @ip_maps = IpMap.paginate(:per_page => 256, :page => params[:page], :conditions => ["adm_user_id = ?", session[:adm_user_id] ]).order('IPv4_3', 'IPv4_4')
    end  
  end

  def show
    @ip_map = IpMap.find(params[:id])
  end

  def new
    @ip_map = IpMap.new
  end

  def edit
    @disable = true
    @ip_map = IpMap.find(params[:id])
  end

  def create     
    #for first ip
    params[:ip_map][:ip]=params[:ip_map][:IPv4_1]+'.'+params[:ip_map][:IPv4_2]+'.'+params[:ip_map][:IPv4_3]+'.'+params[:ip_map][:IPv4_4]
    
    @ip_map = IpMap.new(params[:ip_map])
    @ip_map.save!
    #for rest ip
    if !params[:extra_ip].blank?
      params[:extra_ip].each do |key, value|
        ips=params[:extra_ip][key]
        params[:ip_map][:IPv4_1]=ips["1"]
        params[:ip_map][:IPv4_2]=ips["2"]
        params[:ip_map][:IPv4_3]=ips["3"]
        params[:ip_map][:IPv4_4]=ips["4"]  
        params[:ip_map][:ip]=params[:ip_map][:IPv4_1]+'.'+params[:ip_map][:IPv4_2]+'.'+params[:ip_map][:IPv4_3]+'.'+params[:ip_map][:IPv4_4]                      
        @ip_map = IpMap.new(params[:ip_map])
        @ip_map.save!
      end
    end    
    redirect_to :method=>:index
 
  rescue ActiveRecord::RecordInvalid
     @ip_map.valid? 
     render :action=>:edit
  end

  def update
    @ip_map = IpMap.find(params[:id])
    
    if params[:ip_map][:OS]!='其它'
      params[:ip_map][:OS_others]=nil   
    end
    if params[:ip_map][:place]!='其它'
      params[:ip_map][:place_others]=nil
    end
    if params[:ip_map][:use]!='其它' 
      params[:ip_map][:use_others]=nil  
    end  
     
    respond_to do |format|
      if @ip_map.update_attributes(params[:ip_map])
        format.html { redirect_to @ip_map, notice: '已成功修改IP' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
      end
    end
  end
 
  def search  
    if /\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/.match(params[:search][:term])   
      term=params[:search][:term].split(".")
      @ip_maps=IpMap.paginate(:per_page => 256, :page => params[:page], :conditions => ['IPv4_1 = ? and IPv4_2 = ? and IPv4_3 = ? and IPv4_4 = ? ', term[0], term[1], term[2], term[3]], :order=>['IPv4_3', 'IPv4_4'])       
    elsif /\b\d{1,3}\.\d{1,3}\.\d{1,3}\b/.match(params[:search][:term])   
      term=params[:search][:term].split(".")
      @ip_maps=IpMap.paginate(:per_page => 256, :page => params[:page], :conditions => ['IPv4_1 = ? and IPv4_2 = ? and IPv4_3 = ?', term[0], term[1], term[2]], :order=>['IPv4_3', 'IPv4_4'])           
    else  
      @ip_maps=IpMap.paginate(:per_page => 256, :page => params[:page], :conditions => ['user LIKE ? or room LIKE ? or extend LIKE ? ', "%#{params[:search][:term]}%", "%#{params[:search][:term]}%", "%#{params[:search][:term]}%"], :order=>['IPv4_3', 'IPv4_4'])     
    end
    render "index"
  end
  
  def filter
    @ip_maps=IpMap.paginate(:per_page => 256, :page => params[:page], :conditions => ['campus_buildings_list_id = ? ', params[:campus_area_select]], :order=>['IPv4_3', 'IPv4_4'])
    render "index"
  end  
  
  def block
    if params[:block]=='true'
      ip_map=IpMap.find(params[:id])
      ip_map.block=true
      ip_map.save!
      redirect_to ip_map, notice: '已成功封鎖IP'      
    else
      ip_map=IpMap.find(params[:id])
      ip_map.block=false
      ip_map.save!      
      redirect_to ip_map, notice: '已成功解除封鎖IP'        
    end 
  end
  
  def alwaysVisible
    if params[:always_visible]=='true'
      ip_map=IpMap.find(params[:id])
      ip_map.always_visible=true
      ip_map.save!
      redirect_to ip_map, notice: '顯示每筆攻擊已生效'      
    else
      ip_map=IpMap.find(params[:id])
      ip_map.always_visible=false
      ip_map.save!      
      redirect_to ip_map, notice: '不顯示每筆攻擊已生效'        
    end 
  end  
  
  def alwaysHandle
    if params[:always_handle]=='true'
      ip_map=IpMap.find(params[:id])
      ip_map.always_handle=true
      ip_map.save!
      redirect_to ip_map, notice: '處理此IP已生效'      
    else
      ip_map=IpMap.find(params[:id])
      ip_map.always_handle=false
      ip_map.save!      
      redirect_to ip_map, notice: '不處理此IP已生效'        
    end 
  end    


end
