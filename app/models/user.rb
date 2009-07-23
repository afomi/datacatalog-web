class User < ActiveRecord::Base
  acts_as_authentic do |config|

  end
end