require 'socket'
require 'thread'
require_relative 'player_client'
require_relative 'command_router'

PORT = 2000

class Server

  attr_reader :players

  def self.run_server
    new.run_server
  end

  def initialize
    ip = IPSocket.getaddress(Socket.gethostname)
    puts ip
    @server = TCPServer.open(ip, 19191)
    @command_router = CommandRouter.new(self)
    @players = []
  end

  def run_server
    loop do
      Thread.start(@server.accept) do |client|
        player= PlayerClient.new(server: self, client: client)
        @players << player

        player.get_name

        player.clear_screen
        client.puts "PLAYERS ONLINE: #{player_names}"

        take_input_and_route(player)

        logout(player)
      end
    end
  end

  def command_not_found(command)
    command.player.clear_screen
    command.player.client.puts "Sorry, I don't understand command '#{command.input}'"
  end

  private

  def player_names
    @players.map { |player| player.name }.join(", ")
  end

  def take_input_and_route(player)
    while @command_router.route_command(command: player.get_command)
    end
  end

  def logout(player)
    player.client.puts "CLOSING NOW K BAI"
    player.client.close
    @players.delete(player)
  end
end
