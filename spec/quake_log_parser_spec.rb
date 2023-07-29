require 'spec_helper'

describe QuakeLogParser do
  it 'should read file from path' do
    log = File.open('qgames.log').read
    quake_log_parser = QuakeLogParser.new('qgames.log')

    expect(quake_log_parser.log).to eq log
  end

  it 'should generate ranking report' do
    parsed_log = QuakeLogParser.new('spec/test.log').player_ranking_report

    expect(parsed_log).to eq ranking_report
  end

  it 'should generate death causes report' do
    quake_log_parser = QuakeLogParser.new('spec/test.log')
    parsed_log = quake_log_parser.death_causes_report

    expect(parsed_log).to eq death_causes_report
  end

  def ranking_report
    [
      {:game_0=>{
        :total_kills=>0,
        :players=>["Isgalamido"],
        :kills=>{:Isgalamido=>0}}
      },
      {:game_1=>{
        :total_kills=>11,
        :players=>["Dono da Bola", "Isgalamido", "Mocinha"],
        :kills=>{:"Dono da Bola"=>0, :Isgalamido=>-7, :Mocinha=>0}}
      },
      {:game_2=>{
        :total_kills=>4,
        :players=>["Dono da Bola", "Isgalamido", "Mocinha", "Zeh"],
        :kills=>{:"Dono da Bola"=>-1, :Isgalamido=>1, :Mocinha=>0, :Zeh=>-2}}
      }
    ]
  end

  def death_causes_report
    [
      {:game_0=>{
        :kills_by_means=>{}}
      },
      {:game_1=>{
        :kills_by_means=>{
          :MOD_TRIGGER_HURT=>7,
          :MOD_ROCKET_SPLASH=>3,
          :MOD_FALLING=>1}}
      },
      {:game_2=>{
        :kills_by_means=>{
          :MOD_ROCKET=>1,
          :MOD_TRIGGER_HURT=>2,
          :MOD_FALLING=>1}}
      }
    ]
  end
end
