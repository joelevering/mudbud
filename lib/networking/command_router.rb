require_relative 'chat'
require_relative 'message'

class CommandRouter

  WHITELIST = [
    :quit,
    :exit,
    :say
  ]

  def initialize(server:, chat:)
    @server = server
    @chat = chat
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
    chat_message = Message.new(author: command.player, body: command.message_string)
    @chat.new_message(chat_message)
  end

  private

  def trigger_whitelisted?(trigger)
    WHITELIST.include?(trigger)
  end

  def command_not_found(command)
    command.player.command_not_found(command)
  end
end
