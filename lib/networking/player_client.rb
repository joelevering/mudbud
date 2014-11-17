require_relative 'command'

class PlayerClient
  attr_reader :client

  def initialize(server:, client:)
    @server = server
    @client = client
    @player_name = "(Logging In)"
  end

  def get_name
    client.puts "Who are you?"
    @player_name = client.gets.chomp
  end

  def name
    @player_name
  end

  def get_command
    Command.new(player: self, input: get_input)
  end

  def get_input
    @client.puts "What would you like to do?"
    return @client.gets.chomp
  end

  def clear_screen
    @client.printf "\u001B[2J"
  end

end
