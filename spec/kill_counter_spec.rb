require 'spec_helper'

describe KillCounter do
  it '#parse_ranking' do
    players = ["Assasinu Credi", "Dono da Bola", "Isgalamido", "Zeh"]
    player_kills = KillCounter.new(kill_log, players).parse_ranking
    result = {"Assasinu Credi": -1, "Dono da Bola": 1,
              "Isgalamido": 4, "Zeh": 5}

    expect(player_kills).to eq result
  end

  it '#parse_death_causes' do
    death_causes = KillCounter.new(kill_log).parse_death_causes
    result = {MOD_FALLING: 4, MOD_RAILGUN: 5, MOD_ROCKET: 8,
              MOD_ROCKET_SPLASH: 3, MOD_TRIGGER_HURT: 3}

    expect(death_causes).to eq result
  end

  def kill_log
    ["  2:00 Kill: 1022 3 22: <world> killed Isgalamido by MOD_TRIGGER_HURT\n",
     "  2:04 Kill: 1022 2 19: <world> killed Dono da Bola by MOD_FALLING\n",
     "  2:04 Kill: 1022 3 19: <world> killed Isgalamido by MOD_FALLING\n",
     "  2:11 Kill: 2 4 6: Dono da Bola killed Zeh by MOD_ROCKET\n",
     "  2:22 Kill: 3 2 10: Isgalamido killed Dono da Bola by MOD_RAILGUN\n",
     "  2:29 Kill: 3 4 10: Isgalamido killed Zeh by MOD_RAILGUN\n",
     "  2:37 Kill: 3 2 10: Isgalamido killed Dono da Bola by MOD_RAILGUN\n",
     "  2:43 Kill: 3 4 10: Isgalamido killed Zeh by MOD_RAILGUN\n",
     "  2:57 Kill: 3 4 10: Isgalamido killed Zeh by MOD_RAILGUN\n",
     "  3:12 Kill: 2 4 6: Dono da Bola killed Zeh by MOD_ROCKET\n",
     "  3:13 Kill: 3 2 6: Isgalamido killed Dono da Bola by MOD_ROCKET\n",
     "  3:27 Kill: 1022 3 22: <world> killed Isgalamido by MOD_TRIGGER_HURT\n",
     "  3:29 Kill: 4 2 6: Zeh killed Dono da Bola by MOD_ROCKET\n",
     "  3:32 Kill: 3 4 6: Isgalamido killed Zeh by MOD_ROCKET\n",
     "  3:37 Kill: 3 4 7: Isgalamido killed Zeh by MOD_ROCKET_SPLASH\n",
     "  3:41 Kill: 2 3 6: Dono da Bola killed Isgalamido by MOD_ROCKET\n",
     "  3:51 Kill: 1022 2 19: <world> killed Dono da Bola by MOD_FALLING\n",
     "  3:59 Kill: 4 5 6: Zeh killed Assasinu Credi by MOD_ROCKET\n",
     "  4:00 Kill: 4 2 6: Zeh killed Dono da Bola by MOD_ROCKET\n",
     "  4:08 Kill: 4 3 7: Zeh killed Isgalamido by MOD_ROCKET_SPLASH\n",
     "  4:11 Kill: 1022 5 19: <world> killed Assasinu Credi by MOD_FALLING\n",
     "  4:16 Kill: 1022 3 22: <world> killed Isgalamido by MOD_TRIGGER_HURT\n",
     "  4:21 Kill: 4 2 7: Zeh killed Dono da Bola by MOD_ROCKET_SPLASH\n"]
  end
end
