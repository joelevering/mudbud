module Mudbud
  class Character

    include DataMapper::Resource

    attr_reader :level, :hp, :mp, :attack, :defense, :magic, :dexterity

    def initialize(level: 1, hp: 100, mp: 30, attack: 10, defense: 10, magic: 10, dexterity: 10)
      @level = level
      @hp = hp
      @mp = mp
      @attack = attack
      @defense = defense
      @magic = magic
      @dexterity = dexterity
    end

    def level_up!
      @level += 1

      @hp += 10
      @mp += 3
      @attack += 2
      @defense += 2
      @magic += 2
      @dexterity += 2
    end
  end
end
