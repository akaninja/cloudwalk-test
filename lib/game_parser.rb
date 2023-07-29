class GameParser
  attr_reader :game_log, :index

  def initialize(game_log, index)
    @game_log = game_log
    @index = index
    @players_log = []
    @kill_log = []
  end

  def ranking
    parse_game
    players = parse_players(@players_log)

    {
      "game_#{index}": {
      total_kills: @kill_log.count,
      players: players,
      kills: parse_kills_ranking(players)
      }
    }
  end

  def death_causes
    parse_game

    {
      "game_#{index}": {
        kills_by_means: parse_death_causes
      }
    }
  end

  private

  def parse_game
    @game_log.each_line do |line|
      identifier = line.scan(/\w+/)[2]

      @kill_log << line if identifier == 'Kill'
      @players_log << line if identifier == 'ClientUserinfoChanged'
    end
  end

  def parse_kills_ranking(players)
    KillCounter.new(@kill_log, players).parse_ranking
  end

  def parse_players(players)
    players.map { |p| p.split(':')[2].split('\\')[1] }.uniq.sort
  end

  def parse_death_causes
    KillCounter.new(@kill_log).parse_death_causes
  end
end
