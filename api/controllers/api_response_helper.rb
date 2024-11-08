module ApiResponseHelper

  def self.render_success(code, data)
    response = Response.new()
    response.init_success({ data: data, code: code })
    return code, response.as_json
  end

  def self.render_failure(code, message, errors=nil)
    response = Response.new()
    response.init_failure({ code: code, message: message, errors: errors})
    return code, response.as_json
  end
end