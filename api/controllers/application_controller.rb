require 'json'
require 'net/https'
require 'uri'
require 'action_controller'

class ApplicationController < ActionController::Base

  def find_user(params)
    User.find_by(id: params['user_id'])
  end
end