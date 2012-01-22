module UsersHelper
  
  def roles(user)
    user.roles.collect{|i| t(i,:scope=>"roles")}.join(", ")
  end
  
  def input_roles
    User::ROLES.collect{|item| [t(item, :scope=>"roles"),item]}
  end
end
