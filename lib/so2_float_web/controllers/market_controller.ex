defmodule So2FloatWeb.MarketController do
  use So2FloatWeb, :controller

  action_fallback So2FloatWeb.FallbackController

  alias So2Float.Market

  def publish_market_print(conn, %{"image_url" => image_url}) do
    with {:ok, results} <- Market.extract_skins_from_image(image_url) do
      render(conn, :publish_market_print, results: results)
    end
  end
end
