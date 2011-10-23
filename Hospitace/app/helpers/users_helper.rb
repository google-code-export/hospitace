require "kosapi"

module UsersHelper
  def peoples
    return KOSapi::User.all.sort_by(&:lastname)
  end
  
end
