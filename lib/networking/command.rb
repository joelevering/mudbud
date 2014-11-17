class Command

  attr_reader :input, :player

  def initialize(player:, input:)
    @player = player
    @input = input
    @input_array = @input.split(" ")
  end

  def trigger
    @input_array.first.to_sym
  end

  def message
    @input_array[1..-1]
  end

  def message_string
    message.join(" ")
  end
end
