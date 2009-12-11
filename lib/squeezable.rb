module Squeezable

  def squeeze
    result = []
    previous = nil
    for i in (0...self.length)
      a = self[i]
      result << a unless previous == a
      previous = a
    end
    result
  end

end
