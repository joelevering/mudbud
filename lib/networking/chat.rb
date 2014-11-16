# FIXME make messages their own class for DB logging
# and attaching users
class Chat

  def initialize(server)
    @server = server
    @log = []
  end

  def new_message(message)
    log_message(message)
    update_players
  end

  private

  # FIXME Save off @log to prevent overflow
  def log_message(message)
    @log << message
  end

  def update_players
    players.each { |player| print_chat(player) }
  end

  def players
    @server.players
  end

  def print_chat(player)
    player.client.printf "\u001B[2J"
    recent_messages.each do |chat_line|
      player.client.puts chat_line
    end
  end

  def recent_messages
    @log.length <= 5 ? @log : last_five_chat_lines
  end

  def last_five_chat_lines
    @log[-5..-1]
  end
end
