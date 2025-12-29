defmodule So2Float.Market do
  alias So2Float.Market.GetPriceHistory

  def list_skins_price_history(skin, opts \\ []) do
    GetPriceHistory.call(skin, opts)
  end

  def extract_skins_from_image(image_url, scope) when is_binary(image_url) do
    with :ok <- So2Float.Authorizer.call(:extract_skins_from_image, scope) do
      So2Float.Market.ExtractSkinsFromImage.call(image_url)
    end
  end

  def extract_skins_from_image(image_url) when is_binary(image_url) do
    {:error, :unauthorized}
  end

  def get_skin(complete_name) do
    So2Float.Market.GetSkin.call(complete_name)
  end

  def list_skins() do
    So2Float.Market.ListWaponsSkins.call()
  end
end
