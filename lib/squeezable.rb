module Squeezable

  def squeeze
    result = []
    previous = nil
    iterator = self.each
    loop do
      a = iterator.next
      result << a unless previous == a
      previous = a
    end
    result
  end

end
