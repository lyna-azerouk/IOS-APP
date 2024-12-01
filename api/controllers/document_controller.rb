require_relative 'application_controller'
require_relative '../transactions/api/document/save_transaction'

class DocumentController < ApplicationController

  def self.create(params)
    @user = new().find_user(params)

    if @user.present?
      params = params.merge(user: @user)
      transaction = Api::Document::SaveTransaction.call(params: params)

      if transaction.success?
        ApiResponseHelper.render_success(200, transaction.success[:user])
      else
        ApiResponseHelper.render_failure(401, "unprocessable_entity", transaction.failure[:errors])
      end
    else
      ApiResponseHelper.render_failure(404, 'user_not_found')
    end
  end
end