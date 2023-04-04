require 'uri'
require 'httpx'

class DummyUsersClient

  def self.load(page:, per_page: 50, filter_key: nil, filter_value: nil)
    normalized_page = [(page - 1), 0].max.to_i
    skip = (normalized_page * per_page).to_i

    if (filter_key.nil? && filter_value.present?) || (filter_key.present? && filter_value.nil?)
      raise ArgumentError, "filter_key and value must both be provided!"
    end

    query_parameters = {
      skip: skip,
      limit: per_page,
    }

    if (filter_key.present? && filter_value.present?)
      query_parameters[:filter_key] = filter_key
      query_parameters[:filter_value] = filter_value
    end

    request_uri = URI("https://dummyjson.com/users")
    request_uri.query = Rack::Utils.build_query(query_parameters)

    response = client.get(request_uri)

    raise response.error if response.error.present?

    return response.json
  end

  def self.client
    return HTTPX.plugin(:retries, retry_change_requests: true).with_headers("Content-Type" => "application/json")
  end
end