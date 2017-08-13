module UsersHelper
  def user_full_name(user)
    "#{user.first_name} #{user.surname}"
  end
end
