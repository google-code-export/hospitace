module CoursesHelper
  def short_users(users)
    u = []
    users.each do |l|
      u << l.lastname
    end
    u.join(", ")
  end
end
