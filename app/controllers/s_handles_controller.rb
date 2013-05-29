# encoding: UTF-8
class SHandlesController < ApplicationController

  def index
    @s_handles = SHandle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @s_handles }
    end
  end

  def show
    @s_handle = SHandle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @s_handle }
    end
  end

  def new
    @s_handle = SHandle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @s_handle }
    end
  end

  def edit
    @s_handle = SHandle.find(params[:id])
  end

  def create
    @s_handle = SHandle.new(params[:s_handle])

    respond_to do |format|
      if @s_handle.save
        format.html { redirect_to @s_handle, notice: 'S handle was successfully created.' }
        format.json { render json: @s_handle, status: :created, location: @s_handle }
      else
        format.html { render action: "new" }
        format.json { render json: @s_handle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @s_handle = SHandle.find(params[:id])
    respond_to do |format|
      if @s_handle.update_attributes(params[:s_handle])
        format.html { redirect_to :controller=>:main, :action=>:handleJob, :id=>@s_handle.job.id }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @s_handle = SHandle.find(params[:id])
    @s_handle.destroy

    respond_to do |format|
      format.html { redirect_to s_handles_url }
      format.json { head :no_content }
    end
  end
end
