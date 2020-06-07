module ApplicationHelper

  def integer_string?(str)
    Integer(str)
      true
    rescue ArgumentError
      false
  end

end
