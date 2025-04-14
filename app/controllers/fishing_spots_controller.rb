class FishingSpotsController < ApplicationController
  def index
    @fishing_spots = FishingSpot.all
  end

  def show
    @fishing_spot = FishingSpot.find(params[:id])
    @posts = @fishing_spot.posts
  end

  def map
    @fishing_spots = FishingSpot.all
  end
end
