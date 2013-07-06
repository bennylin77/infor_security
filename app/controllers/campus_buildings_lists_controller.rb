# encoding: UTF-8
class CampusBuildingsListsController < ApplicationController
  
  before_filter(:only => [:create, :new]) { |c| c.checkPermission('building', Infor::Application.config.CREATE_PERMISSION)}  
  before_filter(:only => [:destroy]) { |c| c.checkPermission('building', Infor::Application.config.DELETE_PERMISSION)}
  before_filter(:only => [:edit, :update, :show]) { |c| c.checkPermission('building', Infor::Application.config.UPDATE_PERMISSION)}
  before_filter(:only => [:index]) { |c| c.checkPermission('building', Infor::Application.config.READ_PERMISSION)}     
  
  def index
    @campus_buildings_lists = CampusBuildingsList.order("campus_name").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @campus_buildings_lists }
    end
  end

  # GET /campus_buildings_lists/1
  # GET /campus_buildings_lists/1.json
  def show
    @campus_buildings_list = CampusBuildingsList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @campus_buildings_list }
    end
  end

  # GET /campus_buildings_lists/new
  # GET /campus_buildings_lists/new.json
  def new
    @campus_buildings_list = CampusBuildingsList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @campus_buildings_list }
    end
  end

  # GET /campus_buildings_lists/1/edit
  def edit
    @campus_buildings_list = CampusBuildingsList.find(params[:id])
  end

  # POST /campus_buildings_lists
  # POST /campus_buildings_lists.json
  def create
    @campus_buildings_list = CampusBuildingsList.new(params[:campus_buildings_list])

    respond_to do |format|
      if @campus_buildings_list.save
        format.html { redirect_to campus_buildings_lists_path, notice: '成功新增校區建築' }
      else
        format.html { render action: "new" }
        format.json { render json: @campus_buildings_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /campus_buildings_lists/1
  # PUT /campus_buildings_lists/1.json
  def update
    @campus_buildings_list = CampusBuildingsList.find(params[:id])

    respond_to do |format|
      if @campus_buildings_list.update_attributes(params[:campus_buildings_list])
        format.html { redirect_to @campus_buildings_list, notice: '成功更新校區建築' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @campus_buildings_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campus_buildings_lists/1
  # DELETE /campus_buildings_lists/1.json
  def destroy
    @campus_buildings_list = CampusBuildingsList.find(params[:id])
    @campus_buildings_list.destroy

    respond_to do |format|
      format.html { redirect_to campus_buildings_lists_url }
      format.json { head :no_content }
    end
  end 
end
