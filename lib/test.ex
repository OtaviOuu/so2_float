defmodule Test do
  def call() do
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
              text: "
                Retorne um json com dados das skins anunciadas na imagem anexada.

                Algumas skins não estão com o nome compleo na imagem, então você deve comparar com os nomes mais prováveis baseando-se nas skins já existentes no jogo.

                As skins que existem são:

                M9 Bayonet: ['Dragon Glass', 'Universe', 'Scratch', 'Ancient']
                Mallard: ['PRO Gold']
                Sting: ['Mimicry']
                Karambit: ['Gold']
                AWM: ['Treasure Hunter', 'Sport V2]
                Dual Daggers: ['Harmony]
                Desert Eagle: ['Aureate']
                USP: ['Genesis']
                MAC10: ['Ruby Shadow']
                FN FAL: ['Leather']
                G22: ['Relic']

                Por exemplo, o nome de todas as skins que começam com 'Dragon' devem ser 'Dragon Glass'.


                Use o formado:
                '''
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
                '''
                "
            },
            %{
              type: "image_url",
              image_url: %{
                url: "https://i.imgur.com/l5kFP5t.png"
              }
            }
          ]
        }
      ],
      model: "meta-llama/llama-4-maverick-17b-128e-instruct",
      temperature: 1,
      max_completion_tokens: 1024,
      top_p: 1,
      stream: false,
      response_format: %{"type" => "json_object"},
      stop: nil
    }

    %{body: %{"choices" => [%{"message" => %{"content" => content}}]}} =
      Req.post!("https://api.groq.com/openai/v1/chat/completions",
        json: body,
        headers: header
      )

    JSON.decode!(content)
  end
end
