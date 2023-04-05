class LoadPageIntoUsersJob < ApplicationJob
  queue_as :default

  def perform(page: , per_page: 50, enqueue_next: true)
    page_data = DummyUsersClient.load(page: page, per_page: per_page)
    users = page_data["users"]
    users.each do |user_json|
      next if User.find_by(dummy_json_id: user_json["id"])

      User.create!({
        dummy_json_id: user_json["id"],
        first_name: user_json["firstName"],
        last_name: user_json["lastName"],
        email: user_json["email"],
        domain: user_json["domain"],
        ip_address: user_json["ip"],
        mac_address: user_json["macAddress"],
        user_agent: user_json["userAgent"]
      })
    end

    if enqueue_next && !users.empty?
      LoadPageIntoUsersJob.perform_later(page: page + 1, per_page: per_page)
    end
  end
end
