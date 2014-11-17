require_relative 'chat'

class CommandRouter

  WHITELIST = [
    :quit,
    :exit,
    :say
  ]

  def initialize(server)
    @server = server
    @chat = Chat.new(server)
  end

  def route_command(command:)
    if trigger_whitelisted?(command.trigger)
      public_send(command.trigger, command)
    else
      command_not_found(command)
      true
    end
  end

  def quit(*args)
    false
  end
  alias_method :exit, :quit

  def say(command)
    @chat.new_message(player_name: command.player.name, message: command.message)
  end

  private

  def trigger_whitelisted?(trigger)
    WHITELIST.include?(trigger)
  end

  def command_not_found(command)
    @server.command_not_found(command)
  end
end
