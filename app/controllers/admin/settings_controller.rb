class Admin::SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def logo
    @setting = Setting.site_logo
  end

  def update_logo
    @setting = Setting.site_logo
    
    if params[:setting] && params[:setting][:logo].present?
      @setting.logo.attach(params[:setting][:logo])
      redirect_to admin_logo_path, notice: 'Logo uploaded successfully!'
    else
      redirect_to admin_logo_path, alert: 'Please select a logo file.'
    end
  end

  def destroy_logo
    @setting = Setting.site_logo
    @setting.logo.purge if @setting.logo_attached?
    redirect_to admin_logo_path, notice: 'Logo removed successfully!'
  end

  private

  def ensure_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user&.admin?
  end
end