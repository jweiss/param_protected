class ForgeryController < ApplicationController
  self.request_forgery_protection_token = :custom_auth_token
  protect_from_forgery
  param_accessible_defaults
  param_accessible :id
  def create; end
    
end
