module Helpers
  def headers
    { "Content-Type": "application/json" }
  end

  def json
    JSON.parse(response.body).with_indifferent_access
  end
end
