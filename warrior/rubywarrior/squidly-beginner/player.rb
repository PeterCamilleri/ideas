class Player

  attr_reader :warrior

  PERFECT_HEALTH = 20
  MIDDLE_HEALTH  = 10

  def initialize
    @state = :walking
    @health = PERFECT_HEALTH
    @rests = 0
  end

  def play_turn(warrior)
    @warrior = warrior

    until (send(@state)); end
  end

  def walking
    if warrior.feel.empty?
      warrior_do :walk!
    else
      set_state :fighting
    end
  end

  def fighting
    if warrior.feel.empty?
      reset_health

      if strong? || (@rests > 1)
        set_state :walking
      else
        @rests += 1
        set_state :resting
      end
    else
      warrior_do :attack!
    end
  end

  def resting
    if been_hurt?
      set_state :walking
    elsif weak?(12)
      warrior_do :rest!
    else
      set_state :walking
    end
  end

  def warrior_do(action, *args)
    @warrior.send(action, *args)
    true
  end

  def set_state(new_state)
    @state = new_state
    false
  end

  def strong?(health = MIDDLE_HEALTH)
    warrior.health >= health
  end

  def weak?(health = MIDDLE_HEALTH)
    warrior.health < health
  end

  def been_hurt?
    @health > warrior.health
  end

  def reset_health
    @health = warrior.health
  end


end






















