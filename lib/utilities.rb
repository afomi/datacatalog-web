class String
  def plugin?
    File.directory?(File.join(Rails.root, "vendor/plugins/#{self}"))
  end
end