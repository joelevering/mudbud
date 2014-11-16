module Mudbud
  class Room

    attr_reader :description, :exits

    def initialize(description:, exits:)
      @description = description
      @exits = exits
    end

  end
end
