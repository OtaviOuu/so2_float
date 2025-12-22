defmodule So2Float.Market.ExtractSkinsFromImage do
  alias So2Float.Market.ListWaponsSkins

  @model "meta-llama/llama-4-maverick-17b-128e-instruct"

  def call(image_url \\ "https://i.imgur.com/l5kFP5t.png") do
    image_url
    |> request_for_llm
    |> Jason.decode!()
  end

  defp request_for_llm(image_url) do
    header = [
      {"Authorization", "Bearer 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"}
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

    {:ok, %{body: %{"choices" => [%{"message" => %{"content" => content}}]}}} =
      Req.post("https://api.groq.com/openai/v1/chat/completions",
        json: body,
        headers: header
      )

    content
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
            'weapon': nome da arma,
            'skin': nome da skin,
            'price': preco da skin em golds,
            'units': unidades disponiveis
          }
        ]
      }
      "
  end
end
