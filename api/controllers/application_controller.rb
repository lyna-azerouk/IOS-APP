require 'json'
require 'net/https'
require 'uri'
require 'action_controller'

class ApplicationController < ActionController::Base

  def find_user(params)
    User.find_by(id: params['user_id'])
  end

  def find_user_by_dwolla_id(params)
    User.find_by(dwolla_id: params['resourceId'] )
  end
end