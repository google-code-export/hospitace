require "kosapi"

module UsersHelper
  def get_users
    return KOSapi::User.all.sort_by(&:lastname)
  end
  
end
