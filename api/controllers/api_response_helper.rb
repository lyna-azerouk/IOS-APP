module ApiResponseHelper

  def self.render_success(code, data)
    response = Response.new()
    response.init_success({ data: data, code: code })
    return code, response.as_json
  end

  def self.render_failure(code, message)
    response = Response.new()
    response.init_failure({ code: code, message: message })
    return code, response.as_json
  end
end