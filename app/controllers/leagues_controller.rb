class LeaguesController < ApplicationController
  def nearby
    # Get nearby leagues and sort them by cost ascending
    nearby_leagues = League.filter_within_5_miles(params[:lat_long]).sort_by { |league| league[:cost]}
    budget_left = params[:budget].to_f
    leagues_within_budget = []

    # Loop over all leagues and if the budget is more than the cost of the league, add it to the array and deduct the cost from the budget
    nearby_leagues.each do |league|
      if budget_left - league.cost > 0
        leagues_within_budget << league
        budget_left -= league.cost
      else
        break
      end
    end

    render json: leagues_within_budget
  end

  def create
    @league = League.new(strong_params)

    if @league.save
      render json: @league, status: :created
    else
      render json: @league.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def strong_params
    params.require(:league).permit(:name, :lat_long, :cost, :radius, :budget)
  end
end
