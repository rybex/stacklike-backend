module Helpers
  def generate_uuid
    SecureRandom.uuid
  end

  def parse_json(payload)
    JSON.parse(payload)
  end
end
