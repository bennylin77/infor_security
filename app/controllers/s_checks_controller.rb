# encoding: UTF-8
class SChecksController < ApplicationController
  # GET /s_checks
  # GET /s_checks.json
  def index
    @s_checks = SCheck.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @s_checks }
    end
  end

  # GET /s_checks/1
  # GET /s_checks/1.json
  def show
    @s_check = SCheck.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @s_check }
    end
  end

  # GET /s_checks/new
  # GET /s_checks/new.json
  def new
    @s_check = SCheck.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @s_check }
    end
  end

  # GET /s_checks/1/edit
  def edit
    @s_check = SCheck.find(params[:id])
    @s_check.status=@s_check.job.stage5
  end

  # POST /s_checks
  # POST /s_checks.json
  def create
    @s_check = SCheck.new(params[:s_check])

    respond_to do |format|
      if @s_check.save
        format.html { redirect_to @s_check, notice: 'S check was successfully created.' }
        format.json { render json: @s_check, status: :created, location: @s_check }
      else
        format.html { render action: "new" }
        format.json { render json: @s_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /s_checks/1
  # PUT /s_checks/1.json
  def update
    @s_check = SCheck.find(params[:id])

    respond_to do |format|
      if @s_check.update_attributes(params[:s_check])
        if @s_check.description.blank?
          @s_check.job.stage5="un" 
        else 
          @s_check.job.stage5=@s_check.status    
        end
        @s_check.job.save!
        format.html { redirect_to @s_check, notice: '已成功修改' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /s_checks/1
  # DELETE /s_checks/1.json
  def destroy
    @s_check = SCheck.find(params[:id])
    @s_check.destroy

    respond_to do |format|
      format.html { redirect_to s_checks_url }
      format.json { head :no_content }
    end
  end
end
