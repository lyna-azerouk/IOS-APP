require 'json'

class Response
  attr_reader :code, :message, :data, :errors, :success, :resource

  def init_success(response)
    @success = true
    @code = response[:code]
    @resource = response[:data]
  end

  def init_failure(response)
    @success = false
    @code = response[:code]
    @message = response[:message]
    @errors = response[:errors]
  end

  def as_json(*)
    if success
      JSON.generate(
        {
          code: code,
          resource: resource.as_json
        }
      )
    else
      JSON.generate(
        {
          code: code,
          message: message,
          errors: errors.as_json
        }
      )
    end
  end
end
