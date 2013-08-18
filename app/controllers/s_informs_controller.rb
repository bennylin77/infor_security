# encoding: UTF-8
class SInformsController < ApplicationController

  def index
    @s_informs = SInform.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @s_informs }
    end
  end

  def show
    @s_inform = SInform.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @s_inform }
    end
  end

  def new
    @s_inform = SInform.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @s_inform }
    end
  end


  def edit
    @s_inform = SInform.find(params[:id])
  end

  def create
    @s_inform = SInform.new(params[:s_inform])

    respond_to do |format|
      if @s_inform.save
        format.html { redirect_to @s_inform, notice: 'S inform was successfully created.' }
        format.json { render json: @s_inform, status: :created, location: @s_inform }
      else
        format.html { render action: "new" }
        format.json { render json: @s_inform.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @s_inform = SInform.find(params[:id])
    respond_to do |format|
      if @s_inform.update_attributes(params[:s_inform])   
        format.html { redirect_to :controller=>:main, :action=>:informUser, :id=>@s_inform.job.id }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /s_informs/1
  # DELETE /s_informs/1.json
  def destroy
    @s_inform = SInform.find(params[:id])
    @s_inform.destroy

    respond_to do |format|
      format.html { redirect_to s_informs_url }
      format.json { head :no_content }
    end
  end
end
