module TeamsHelper
  def teams_for_select
    teams = Team.order(:name)

    teams.map do |team|
      [team.name, team.id]
    end
  end
end
