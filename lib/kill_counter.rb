class KillCounter
  def initialize(kill_log, players = nil)
    @kill_log = parse_kills(kill_log)
    @kills_by_player = group_kills_by_player(@kill_log)
    @deaths_by_cause = group_deaths_by_cause(@kill_log)
    @players = players
  end

  def parse_ranking
    return unless @players

    kills = { }
    @players.each { |p| kills[:"#{p}"] = kills_by(p) - death_by_world(p) }
    kills
  end

  def parse_death_causes
    death_causes = { }
    @deaths_by_cause.each { |dc, d| death_causes[:"#{dc}"] = d.count }
    death_causes
  end

  private

  def parse_kills(kill_log)
    kill_log.map do |kill|
      player, death, method = kill.split(':')[3]
                                  .split(' killed ')
                                  .map { |s| s.split(' by ') }
                                  .flatten
      { player: player.lstrip, death: death, method: method.chomp }
    end
  end

  def group_kills_by_player(kill_log)
    kill_log.group_by { |e| e[:player] }
  end

  def group_deaths_by_cause(kill_log)
    kill_log.group_by { |e| e[:method] }
  end

  def death_by_world(player)
    return 0 unless @kills_by_player.has_key?('<world>')

    @kills_by_player.fetch('<world>').filter { |e| e[:death] == player }.count
  end

  def kills_by(player)
    return 0 unless @kills_by_player.has_key?(player)

    @kills_by_player.fetch(player).filter { |e| e[:death] != player }.count
  end

  def deaths_by(death_cause)
    @deaths_by_cause.fetch(death_cause).count
  end
end
