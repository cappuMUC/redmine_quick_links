class QuickLinksController < ApplicationController
  layout 'admin'
  self.main_menu = false


  def new
    @quick_link = QuickLink.new
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

  private

  def quick_link_params
    puts
    params.require( :quick_link ).permit( :label, :description, :link, :project_id, :role_id, :icon_class )
  end
end
