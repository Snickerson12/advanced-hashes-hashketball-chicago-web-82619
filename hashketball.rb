require 'pry'

def game_hash
  {
        home: { team_name: 'Brooklyn Nets',
            colors: %w[Black White],
            players: [
              { player_name: 'Alan Anderson',
                number: 0,
                shoe: 16,
                points: 22,
                rebounds: 12,
                assists: 12,
                steals: 3,
                blocks: 1,
                slam_dunks: 1 },
              { player_name: 'Reggie Evans',
                number: 30,
                shoe: 14,
                points: 12,
                rebounds: 12,
                assists: 12,
                steals: 12,
                blocks: 12,
                slam_dunks: 7 },
              { player_name: 'Brook Lopez',
                number: 11,
                shoe: 17,
                points: 17,
                rebounds: 19,
                assists: 10,
                steals: 3,
                blocks: 1,
                slam_dunks: 15 },
              { player_name: 'Mason Plumlee',
                number: 1,
                shoe: 19,
                points: 26,
                rebounds: 11,
                assists: 6,
                steals: 3,
                blocks: 8,
                slam_dunks: 5 },
              { player_name: 'Jason Terry',
                number: 31,
                shoe: 15,
                points: 19,
                rebounds: 2,
                assists: 2,
                steals: 4,
                blocks: 11,
                slam_dunks: 1 }
            ] },
    away: { team_name: 'Charlotte Hornets',
            colors: %w[Turquoise Purple],
            players: [
              { player_name: 'Jeff Adrien',
                number: 4,
                shoe: 18,
                points: 10,
                rebounds: 1,
                assists: 1,
                steals: 2,
                blocks: 7,
                slam_dunks: 2 },
              { player_name: 'Bismack Biyombo',
                number: 0,
                shoe: 16,
                points: 12,
                rebounds: 4,
                assists: 7,
                steals: 22,
                blocks: 15,
                slam_dunks: 10 },
              { player_name: 'DeSagna Diop',
                number: 2,
                shoe: 14,
                points: 24,
                rebounds: 12,
                assists: 12,
                steals: 4,
                blocks: 5,
                slam_dunks: 5 },
              { player_name: 'Ben Gordon',
                number: 8,
                shoe: 15,
                points: 33,
                rebounds: 3,
                assists: 2,
                steals: 1,
                blocks: 1,
                slam_dunks: 0 },
              { player_name: 'Kemba Walker',
                number: 33,
                shoe: 15,
                points: 6,
                rebounds: 12,
                assists: 12,
                steals: 7,
                blocks: 5,
                slam_dunks: 12 }
            ] }
  }
end

def num_points_scored(get_player_name)
  game_hash.each do |location, team|
    team.each do |attribute, data|
      next unless attribute == :players

      data.each do |player|
        return player[:points] if player[:player_name] == get_player_name
      end
    end
  end
end

def shoe_size(get_player_name)
  game_hash.each do |location, team|
    team.each do |attribute, data|
      next unless attribute == :players
      
      data.each do |player|
        return player[:shoe] if player[:player_name] == get_player_name
      end
    end
  end
end

def team_colors(team_name)
  game_hash.each do |location, team|
    return game_hash[location][:colors] if team[:team_name] == team_name
  end
end

def team_names
  game_hash.collect do |location, team|
    team[:team_name]
  end
end

def player_numbers(team_name)
  numbers = []
  game_hash.each do |location, team|
    next unless team[:team_name] == team_name
    
    team.each do |attribute, data|
      next unless attribute == :players
      
      data.each do |data|
        numbers << data[:number]
      end
    end
  end
  numbers
end

def player_stats(sought_player_name)
  hash = {}
  game_hash.collect do |location, team|
    team.each do |attribute, _data|
      next unless attribute == :players

      game_hash[location][attribute].each do |player|
        next unless player[:player_name] == sought_player_name

        hash = player.delete_if do |key, value|
          key == :player_name
        end
      end
    end
  end
  hash
end

def big_shoe_rebounds
  max_shoe = 0
  num_rebounds = 0
  
  game_hash.each do |team, data|
    data[:players].each do |player|
      if player[:shoe] > max_shoe
        max_shoe = player[:shoe]
        num_rebounds = player[:rebounds]
      end
    end
  end
  num_rebounds
end

def most_points_scored
  max_points = 0
  highest_shooter = ()
  
  game_hash.each do |team, data|
    data[:players].each do |player|
      if player[:points] > max_points
        max_points = player[:points]
        highest_shooter = player[:player_name]
      end
    end
  end
  highest_shooter
end


def iterate_through_players_for(name, stat)
  game_hash.each do |_team, data|
    data[:players].each do |player|
      return player[stat] if player[:player_name] == name
    end
  end
end

def player_with_most(stat)
  player_name = nil
  amount_of_stat = 0

  game_hash.each do |_team, data|
    data[:players].each do |player|
      if player[stat].is_a? String
        if player[stat].length > amount_of_stat
          amount_of_stat = player[stat].length
          player_name = player[:player_name]
        end
      elsif player[stat] > amount_of_stat
        amount_of_stat = player[stat]
        player_name = player[:player_name]
      end
    end
  end

  player_name
end

def winning_team
  scores = { 'Brooklyn Nets' => 0, 'Charlotte Hornets' => 0 }

  game_hash.each do |_team, data|
    data[:players].each do |player|
      scores[data[:team_name]] += iterate_through_players_for(player[:player_name], :points)
    end
  end

  scores.max_by { |key, value| value }.first
end

def player_with_longest_name
  player_with_most(:player_name)
end

def long_name_steals_a_ton?
  player_with_most(:steals) == player_with_most(:player_name)
end







