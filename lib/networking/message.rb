class Message

  attr_reader :time_stamp, :author, :body

  def initialize(author:, body:)
    @time_stamp = Time.now
    @author = author
    @body = body
    @delivered = false
  end

  def author_name
    @author.name
  end

  def delivered?
    @delivered
  end

  def delivered!
    @delivered = true
  end

end
