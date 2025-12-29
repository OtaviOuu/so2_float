defmodule So2Float.Market.ExtractSkinsFromImage do
  alias So2Float.Market.{ListWaponsSkins, CreateHistoryRecord}

  @model "meta-llama/llama-4-maverick-17b-128e-instruct"

  def call(image_url \\ "https://i.imgur.com/7OOqRo0.png") do
    with {:ok, content} <- request_for_llm(image_url),
         {:ok, json} <-
           Jason.decode(content) do
      results =
        json
        |> Map.get("skins", [])
        |> Enum.map(&CreateHistoryRecord.call/1)
        |> Enum.map(fn {:ok, history} -> history end)

      {:ok, results}
    else
      {:error, error} -> {:error, error}
    end
  end

  defp request_for_llm(image_url) do
    header = [
      {"Authorization", "Bearer #{groq_api_key()}"},
      {"Content-Type", "application/json"}
    ]

    body = %{
      messages: [
        %{
          role: "user",
          content: [
            %{
              type: "text",
              text: prompt()
            },
            %{
              type: "image_url",
              image_url: %{
                url: image_url
              }
            }
          ]
        }
      ],
      model: @model,
      temperature: 1,
      max_completion_tokens: 1024,
      top_p: 1,
      stream: false,
      response_format: %{"type" => "json_object"},
      stop: nil
    }

    case Req.post("https://api.groq.com/openai/v1/chat/completions",
           json: body,
           headers: header,
           retry: :transient
         ) do
      {:ok, %{body: %{"choices" => [%{"message" => %{"content" => content}}]}}} ->
        {:ok, content}

      {:error, error} ->
        {:error, error}
    end
  end

  defp prompt() do
    "
      Você é um assistente que extrai informações de imagens.

      Retorne um json com dados das skins anunciadas na imagem anexada.

      Algumas skins não estão com o nome compleo na imagem, então você deve comparar com os nomes mais prováveis baseando-se nas skins já existentes no jogo.

      As skins que existem no jogo são:

      #{Enum.map_join(ListWaponsSkins.call(), "\n", fn skin -> "- #{skin.complete_name}" end)}

      Por exemplo, o nome de todas as skins que começam com 'Dragon' devem ser 'Dragon Glass', já que é a única skin que começa com 'Dragon' no jogo.


      Use o formado:

      {
        'skins': [
          {
            'skin_complete_name': nome da skin,
            'price': preco da skin em golds integer,
            'units': unidades disponiveis
          }
        ]
      }
      "
  end

  defp groq_api_key do
    Application.fetch_env!(:so2_float, :groq_api_key)
  end
end
