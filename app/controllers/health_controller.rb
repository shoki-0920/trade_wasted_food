class HealthController < ApplicationController
  def show
    # レスポンスとして "OK" を返す
    render plain: "OK", status: :ok
  end
end
