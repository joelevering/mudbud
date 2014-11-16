require 'socket'
require 'thread'
require_relative 'player_client'

PORT = 2000

class Server

  def self.run_server
    new.run_server
  end

  def initialize
    @server = TCPServer.open(PORT)
    @players = []
    @chat_log = []
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
    add_to_chat_log(say_string)
    @players.each { |player| print_chat(player) }
  end

  private

  def player_names
    @players.map { |player| player.name }.join(", ")
  end

  # FIXME Save off @chat_log to prevent overflow
  def add_to_chat_log(string)
    @chat_log << string
  end

  def print_chat(player)
    player.client.printf "\u001B[2J"
    last_five_chat_lines.each do |chat_line|
      player.client.puts chat_line
    end
  end

  def last_five_chat_lines
    if @chat_log.length <= 5
      @chat_log
    else
      @chat_log[-5..-1]
    end
  end

  def logout(player)
    player.client.puts "CLOSING NOW K BAI"
    player.client.close
    @players.delete(player)
  end
end

Server.run_server
