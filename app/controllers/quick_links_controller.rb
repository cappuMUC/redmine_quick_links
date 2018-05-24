class QuickLinksController < ApplicationController
  layout 'admin'
  self.main_menu = false
  model_object QuickLink
  before_action :find_model_object, :except => [:new, :create, :index]
  before_action :require_admin, :except => :show

  def new
    @quick_link = QuickLink.new
  end

  def show
  end

  def create
    params.permit!
    @quick_link = QuickLink.new( quick_link_params )
    if @quick_link.save
      redirect_to quick_links_path
    else
      render :action => 'new'
    end
  end

  def destroy
    begin
      @quick_link.destroy
    rescue
      flash[:error] =  l(:error_can_not_remove_quick_link)
    end
    redirect_to quick_links_path
  end

  def edit
  end

  def update
    @quick_link.update_attributes quick_link_params
    puts params[:quick_link].to_s
    if @quick_link.save
      redirect_to quick_links_path
    else
      render :action => 'edit'
    end
  end


  private

  def quick_link_params
    puts
    params.require( :quick_link ).permit( :label, :description, :url, :project_id, :role_id, :icon_class )
  end
end
