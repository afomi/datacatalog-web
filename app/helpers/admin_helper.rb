module AdminHelper

  def total_users
    User.all.count.to_s
  end

end
