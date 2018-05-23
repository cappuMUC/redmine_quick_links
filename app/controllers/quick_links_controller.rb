class QuickLinksController < ApplicationController
  layout 'admin'
  self.main_menu = false

  before_action :require_admin, :except => :show

  def new
    @quick_link = QuickLink.new
  end

  def show
    @quick_link = QuickLink.find params[:id]
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
    @quick_link = QuickLink.find params[:id]
    begin
      @quick_link.destroy
    rescue
      flash[:error] =  l(:error_can_not_remove_quick_link)
    end
    redirect_to quick_links_path
  end

  private

  def quick_link_params
    puts
    params.require( :quick_link ).permit( :label, :description, :link, :project_id, :role_id, :icon_class )
  end
end
