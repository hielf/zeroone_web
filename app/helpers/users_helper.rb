module UsersHelper
  def check_user_type(user)
    user_type = user.user_type
    case user_type
    when "normal"
      "普通"
    when "channel"
      user.superior ? "机构理财师" : "机构管理员"
    end
  end
end
