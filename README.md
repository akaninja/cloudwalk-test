Quake log parser
================

Made with Ruby 3.2.2

# Instructions

Run `bin/setup` or `bundle install` to install dependencies.

Run `rspec` to run tests.

# Information

`QuakeLogParser` is the main class, should be instantiated with the path to the
`log` file. The class has methods for generating player rank report and kills
grouped by mean of death.

```ruby
QuakeLogParser.new('log_path').player_ranking_report

QuakeLogParser.new('log_path').death_causes_report
```

Secondary classes `GameParser` and `KillCounter` are responsible for
processing each game data and generating kill data for each game.
