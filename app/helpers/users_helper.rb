module UsersHelper
  def user_name(user)
    return [user.first_name, user.last_name].join(' ')
  end

  def domain_url(domain)
    URI::HTTP.build(host: domain).to_s
  end

  def user_status(user)
    status_badge(user.status)
  end

  def status_badge(status)
    case status.to_sym
    when :unknown
      return "❓"
    when :warn
      return "⚠️"
    when :alert
      return "🚨"
    when :approved
      return "✅"
    end
  end

  def bulk_actions_user_checkbox(user)
    check_box_tag(field_name(:bulk_action, :user_ids, multiple: true), user.id, false, form: 'bulk-actions')
  end

  def bulk_actions_status_field_name
    field_name(:bulk_action, :status)
  end
end
