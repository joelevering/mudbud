require 'wisper'

class Chat

  include Wisper::Publisher

  def initialize(server)
    @server = server
    @log = []
  end

  def new_message(message)
    log_message(message)

    publish(:chat_updated, recent_messages)
  end

  def subscribe_player(player)
    self.subscribe(player)
  end

  private

  def log_message(message)
    @log << message
  end

  def recent_messages
    @log.length <= 5 ? @log : last_five_chat_lines
  end

  def last_five_chat_lines
    @log[-5..-1]
  end
end
