# frozen_string_literal: true

class Ranking
  def self.fetch(tournament)
    RankingLog
      .where(tournament: tournament)
      .joins(:user)
      .group('users.id')
      .select('users.id, users.name, sum(points) as total_points')
      .order('total_points desc')
  end
end
