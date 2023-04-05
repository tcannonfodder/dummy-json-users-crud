module UsersHelper
  def user_name(user)
    return [user.first_name, user.last_name].join(' ')
  end
end
