# encoding: UTF-8
class SClosedsController < ApplicationController
  # GET /s_closeds
  # GET /s_closeds.json
  def index
    @s_closeds = SClosed.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @s_closeds }
    end
  end

  # GET /s_closeds/1
  # GET /s_closeds/1.json
  def show
    @s_closed = SClosed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @s_closed }
    end
  end

  # GET /s_closeds/new
  # GET /s_closeds/new.json
  def new
    @s_closed = SClosed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @s_closed }
    end
  end

  # GET /s_closeds/1/edit
  def edit
    @s_closed = SClosed.find(params[:id])
    @s_closed.status=@s_closed.job.stage6
  end

  # POST /s_closeds
  # POST /s_closeds.json
  def create
    @s_closed = SClosed.new(params[:s_closed])

    respond_to do |format|
      if @s_closed.save
        format.html { redirect_to @s_closed, notice: 'S closed was successfully created.' }
        format.json { render json: @s_closed, status: :created, location: @s_closed }
      else
        format.html { render action: "new" }
        format.json { render json: @s_closed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /s_closeds/1
  # PUT /s_closeds/1.json
  def update
    @s_closed = SClosed.find(params[:id])

    respond_to do |format|
      if @s_closed.update_attributes(params[:s_closed])
        if @s_closed.description.blank?
          @s_closed.job.stage6="un" 
        else 
          @s_closed.job.stage6=@s_closed.status    
        end
        @s_closed.job.save!
        format.html { redirect_to @s_closed, notice: '已成功修改' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /s_closeds/1
  # DELETE /s_closeds/1.json
  def destroy
    @s_closed = SClosed.find(params[:id])
    @s_closed.destroy

    respond_to do |format|
      format.html { redirect_to s_closeds_url }
      format.json { head :no_content }
    end
  end
end
