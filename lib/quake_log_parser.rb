class QuakeLogParser
  attr_reader :log

  def initialize(log_path)
    @log = File.open(log_path).read
    @games_log = clear_games_log(@log.split(game_line_break))
  end

  def player_ranking_report
    parse_games_ranking
  end

  def death_causes_report
    parse_games_death_causes
  end

  private

  def parse_games_ranking
    @games_log.map.with_index { |game, i| GameParser.new(game, i).ranking }
  end

  def parse_games_death_causes
    @games_log.map.with_index { |game, i| GameParser.new(game, i).death_causes }
  end

  def clear_games_log(log)
    log.map { |game| game unless game.scan(/\w+/)[2].nil? }.compact
  end

  def game_line_break
    '------------------------------------------------------------'
  end
end
