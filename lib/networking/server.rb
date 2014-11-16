require 'socket'
require 'thread'
require_relative 'player_client'
require_relative 'chat'

PORT = 2000

class Server

  attr_reader :players

  def self.run_server
    new.run_server
  end

  def initialize
    @server = TCPServer.open(PORT)
    @chat = Chat.new(self)
    @players = []
  end

  def run_server
    loop do
      Thread.start(@server.accept) do |client|
        player= PlayerClient.new(server: self, client: client)
        @players << player

        player.login

        client.puts "PLAYERS ONLINE: #{player_names}"

        player.input_loop

        logout(player)
      end
    end
  end

  def say(player_name:, input:)
    say_string = "#{player_name} says: #{input}"
    @chat.new_message(say_string)
  end

  private

  def player_names
    @players.map { |player| player.name }.join(", ")
  end

  def logout(player)
    player.client.puts "CLOSING NOW K BAI"
    player.client.close
    @players.delete(player)
  end
end
