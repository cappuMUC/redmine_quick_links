class QuickLinksController < ApplicationController
  layout 'admin'
  self.main_menu = false
  model_object QuickLink
  before_action :find_model_object, :except => [:new, :create, :index]
  before_action :require_admin, :except => :show

  def new
    @quick_link = QuickLink.new
  end

  def index
    @quick_links = QuickLink.sorted.to_a
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
      @quick_link = QuickLink.find(params[:id])
      @quick_link.destroy
    rescue
      flash[:error] =  l(:error_can_not_remove_quick_link)
    end
    redirect_to quick_links_path
  end

  def edit
  end

  def update
    @quick_link = QuickLink.find(params[:id])
    @quick_link.update_attributes quick_link_params
    puts "Quick Link: " + @quick_link.label.to_s
    puts "Parameters: " + params[:quick_link].to_s
    if @quick_link.save
      respond_to do |format|
        format.html {
          flash[:notice] = l(:notice_successful_update)
          redirect_to quick_links_path
        }
        format.js { head 200 }
      end
    else
      respond_to do |format|
        format.html{ render :action => 'edit' }
        format.js {head 422}
      end
    end
  end



  private

  def quick_link_params
    puts
    params.require( :quick_link ).permit( :label, :description, :url, :project_id, :role_id, :icon_class, :position )
  end
end
