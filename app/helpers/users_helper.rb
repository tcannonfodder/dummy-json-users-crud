module UsersHelper
  def user_name(user)
    return [user.first_name, user.last_name].join(' ')
  end

  def domain_url(domain)
    URI::HTTP.build(host: domain).to_s
  end
end
