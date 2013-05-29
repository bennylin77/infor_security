# encoding: UTF-8
class EventMapsController < ApplicationController

  before_filter(:only => [:create, :new]) { |c| c.checkPermission('event', Infor::Application.config.CREATE_PERMISSION)}  
  before_filter(:only => [:destroy]) { |c| c.checkPermission('event', Infor::Application.config.DELETE_PERMISSION)}
  before_filter(:only => [:edit, :update, :show]) { |c| c.checkPermission('event', Infor::Application.config.UPDATE_PERMISSION)}
  before_filter(:only => [:index, :indexAll, :search]) { |c| c.checkPermission('event', Infor::Application.config.READ_PERMISSION)}    

  def index
  end
  
  def indexAll
     @event_maps = EventMap.paginate(:per_page => 50, :page => params[:page]).order('thread_id')
  end
  # GET /event_maps/1
  # GET /event_maps/1.json
  def show
    @event_map = EventMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_map }
    end
  end

  # GET /event_maps/new
  # GET /event_maps/new.json
  def new
    @event_map = EventMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_map }
    end
  end

  # GET /event_maps/1/edit
  def edit
    @event_map = EventMap.find(params[:id])
  end

  # POST /event_maps
  # POST /event_maps.json
  def create
    @event_map = EventMap.new(params[:event_map])
    respond_to do |format|
      if @event_map.save
        @event_log=EventAdmLog.new
        @event_log.adm_user=AdmUser.find_by_id(session[:adm_user_id])
        @event_log.edit_at=Time.now 
        @event_log.event_map=@event_map   
        @event_log.save!                
        format.html { redirect_to event_maps_path, notice: '成功新增事件' }
      else
        format.html { render action: "new" }
        format.json { render json: @event_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event_maps/1
  # PUT /event_maps/1.json
  def update
    @event_map = EventMap.find(params[:id])
    respond_to do |format|
      if @event_map.update_attributes(params[:event_map])
        @event_log=EventAdmLog.new
        @event_log.adm_user=AdmUser.find_by_id(session[:adm_user_id])
        @event_log.edit_at=Time.now 
        @event_log.event_map=@event_map   
        @event_log.save!        
        format.html { redirect_to @event_map, notice: '成功更新事件' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_maps/1
  # DELETE /event_maps/1.json
  def destroy
    @event_map = EventMap.find(params[:id])
    @event_map.destroy

    respond_to do |format|
      format.html { redirect_to event_maps_url }
      format.json { head :no_content }
    end
  end
  
  def search  
        
    @event_maps=EventMap.find(:all, :conditions => ['thread_id LIKE ? or name LIKE ? or chinese_name LIKE ? ', "%#{params[:search][:term]}%", "%#{params[:search][:term]}%", "%#{params[:search][:term]}%"])     
    
    render "index"
  end
 
end
