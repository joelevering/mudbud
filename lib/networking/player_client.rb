require_relative 'message'
require_relative 'command'

require 'ostruct'

SYSTEM = OpenStruct.new(name: "System")

class PlayerClient
  attr_reader :client

  def initialize(server:, client:)
    @server = server
    @client = client
    @server_log = []
    @chat_log = []
    @player_name = "(Logging In)"
  end

  def get_name
    send_system_message("Who are you?")
    @player_name = client.gets.chomp
  end

  def name
    @player_name
  end

  def get_command
    Command.new(player: self, input: get_input)
  end

  def get_input
    send_system_message("What would you like to do?")
    return @client.gets.chomp
  end

  def clear_screen
    @client.printf "\u001B[2J"
  end

  def chat_updated(recent_messages)
    clear_screen

    recent_messages.each do |chat_message|
      @chat_log << chat_message
      send_message(chat_message)
    end
  end

  def command_not_found(command)
    clear_screen
    send_system_message("Sorry, I don't understand command '#{command.input}'")
  end

  private

  def send_system_message(message_body)
    message = Message.new(author: SYSTEM, body: message_body)

    @server_log << message
    send_message(message)
  end

  def send_message(message)
    @client.puts "#{message.author_name}: #{message.body}"
    message.delivered!
  end

end
