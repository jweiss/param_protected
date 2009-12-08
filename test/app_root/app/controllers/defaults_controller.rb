class DefaultsController < ActionController::Base
  before_filter :render_nothing
  
  param_accessible_defaults
  
private

  def render_nothing
    render :nothing => true
  end
  
end
