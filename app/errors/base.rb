class Base < StandardError

  def code
    404
  end

  def message
    super
  end

end