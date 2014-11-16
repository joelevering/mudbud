class PlayerClient
  attr_reader :client

  def initialize(server:, client:)
    @server = server
    @client = client
    @player_name = "(Logging In)"
  end

  def login
    client.puts "Who are you?"
    @player_name = client.gets.chomp
  end

  def name
    @player_name
  end

  def input_loop
    while true
      input = get_input

      break if input_is_quit?(input)

      process_and_respond_to_input(input)
    end
  end

  private

  def get_input
    @client.puts "What would you like to do?"
    return @client.gets.chomp
  end

  def input_is_quit?(input)
    input == "quit"
  end

  def process_and_respond_to_input(input)
    split_input = input.split(" ")

    if split_input.first == "say"
      @server.say(player_name: @player_name, input: split_input[1..-1].join(" "))
    else
      @client.puts "I don't know that command :3"
    end
  end
end
