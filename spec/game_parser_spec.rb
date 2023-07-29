require 'spec_helper'

describe GameParser do
  it '#ranking' do
    game_log = File.open('spec/single_game.log').read
    parsed_game_log = GameParser.new(game_log, 0).ranking
    result = {
      game_0: {
        total_kills: 105,
        players: ['Assasinu Credi', 'Dono da Bola', 'Isgalamido', 'Zeh'],
        kills: {
          'Assasinu Credi': 12,
          'Dono da Bola': 9,
          'Isgalamido': 19,
          'Zeh': 20
        }
      }
    }

    expect(parsed_game_log).to eq result
  end

  it '#death_causes' do
    game_log = File.open('spec/single_game.log').read
    parsed_game_log = GameParser.new(game_log, 0).death_causes
    result = {
      game_0: {
        kills_by_means: {
          MOD_TRIGGER_HURT: 9,
          MOD_FALLING: 11,
          MOD_ROCKET: 20,
          MOD_RAILGUN: 8,
          MOD_ROCKET_SPLASH: 51,
          MOD_MACHINEGUN: 4,
          MOD_SHOTGUN: 2
        }
      }
    }

    expect(parsed_game_log).to eq result
  end
end
