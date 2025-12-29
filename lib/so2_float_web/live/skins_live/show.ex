defmodule So2FloatWeb.SkinsLive.Show do
  use So2FloatWeb, :live_view

  alias So2Float.Market.GetPriceHistory
  alias So2Float.Market
  import So2FloatWeb.Charts

  def mount(%{"skin_name" => skin_name}, _session, socket) do
    skin = Market.get_skin(skin_name)
    timeseries = Market.list_skins_price_history(skin, limit: 100)

    prices = Enum.map(timeseries, fn %{price: price} -> price end)

    dates =
      Enum.map(timeseries, fn %{inserted_at: inserted_at} ->
        inserted_at
        |> Calendar.strftime("%d-%m-%Y %H:%M")
        |> to_string()
      end)

    socket =
      socket
      |> assign(:page_title, "Skin Details")
      |> assign(:skin_name, skin_name)
      |> assign(:price_history_series, prices)
      |> assign(:price_history_categories, dates)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <div class="bg-white dark:bg-gray-800 shadow sm:rounded-lg p-6">
        <.line_chart_basic
          id="price-history-chart"
          title={@skin_name}
          categories={@price_history_categories}
          series={@price_history_series}
        />
      </div>
    </Layouts.app>
    """
  end
end
