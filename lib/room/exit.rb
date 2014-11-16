require_relative '../room.rb'

module Mudbud
  class Room
    class Exit

      attr_reader :description, :trigger, :room

      def initialize(description:, trigger:, room:)
        @description = description
        @trigger = trigger
        @room = room
      end

    end
  end
end
