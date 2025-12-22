defmodule So2FloatWeb.HomeLive do
  use So2FloatWeb, :live_view

  import So2FloatWeb.Charts

  alias So2Float.Market

  def mount(_params, _session, socket) do
    timeseries = Market.list_skins_price_history("M9 Bayonet Dragon Glass")

    prices = Enum.map(timeseries, fn %{price: price} -> price end)

    dates =
      Enum.map(timeseries, fn %{inserted_at: inserted_at} ->
        inserted_at
        |> NaiveDateTime.to_date()
        |> Date.to_string()
      end)

    socket =
      socket
      |> assign(:skin_name, "M9 Bayonet Dragon Glass")
      |> assign(:price_history_series, prices)
      |> assign(:price_history_categories, dates)

    IO.inspect(prices, label: "Prices")
    IO.inspect(dates, label: "Dates")
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      oi
      <.line_chart_basic
        id="price-history-chart"
        title={@skin_name}
        categories={@price_history_categories}
        series={@price_history_series}
      />
    </Layouts.app>
    """
  end
end
