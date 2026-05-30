# Resoluções das Questões de Processamento de Imagens

Este repositório contém a implementação das Questões 2 e 3 de processamento de imagens em Elixir.

---

## Questão 2: Filtros de Imagem não Implementados

A implementação completa dos filtros de imagem está no arquivo `questaoimagem/projeto_imagem/projeto_imagem/imagem_12.ex`.

### Transcrição da Função `aplicar_limiar/2`
```elixir
def aplicar_limiar(%Imagem{} = img, limite)
    when 0 <= limite and limite <= img.cor_maxima do
  nova_matriz =
    img.matriz_pixeis
    |> Enum.map(fn linha ->
      linha
      |> Enum.map(fn {r, g, b} ->
        luminosidade = div(299 * r + 587 * g + 114 * b, 1000)
        if luminosidade >= limite do
          {img.cor_maxima, img.cor_maxima, img.cor_maxima}
        else
          {0, 0, 0}
        end
      end)
    end)

  %Imagem{img | matriz_pixeis: nova_matriz}
end
```

### Transcrição de `espelhar_horizontal/1`
```elixir
def espelhar_horizontal(%Imagem{} = img) do
  nova_matriz =
    img.matriz_pixeis
    |> Enum.map(fn linha -> Enum.reverse(linha) end)

  %Imagem{img | matriz_pixeis: nova_matriz}
end
```

### Transcrição de `girar_180/1`
```elixir
def girar_180(%Imagem{} = img) do
  nova_matriz =
    img.matriz_pixeis
    |> Enum.reverse()
    |> Enum.map(fn linha -> Enum.reverse(linha) end)

  %Imagem{img | matriz_pixeis: nova_matriz}
end
```

### Transcrição de `girar_90_anti_horario/1`
```elixir
def girar_90_anti_horario(%Imagem{} = img) do
  nova_matriz =
    img.matriz_pixeis
    |> Enum.reverse()
    |> Enum.zip_with(&Function.identity/1)  # transpõe após reverter as linhas

  %Imagem{img |
    largura: img.altura,
    altura: img.largura,
    matriz_pixeis: nova_matriz
  }
end
```

### Transcrição de `aplicar_negativo/1`
```elixir
def aplicar_negativo(%Imagem{} = img) do
  nova_matriz =
    img.matriz_pixeis
    |> Enum.map(fn linha ->
      linha
      |> Enum.map(fn {r, g, b} ->
        {img.cor_maxima - r, img.cor_maxima - g, img.cor_maxima - b}
      end)
    end)

  %Imagem{img | matriz_pixeis: nova_matriz}
end
```

### Transcrição de `esfriar/2`
```elixir
def esfriar(%Imagem{} = img, tx) when tx in 0..100 do
  max = img.cor_maxima

  nova_matriz =
    img.matriz_pixeis
    |> Enum.map(fn linha ->
      linha
      |> Enum.map(fn {r, g, b} ->
        novo_r = round(r * (1 - tx / 100))
        novo_g = round(g * (1 - tx / 100))
        novo_b = round(b + (max - b) * tx / 100)
        {novo_r, novo_g, novo_b}
      end)
    end)

  %Imagem{img | matriz_pixeis: nova_matriz}
end
```

---

## Questão 3: Tratamento do Retorno de `Imagem.ler/1`

```elixir
resultado = Imagem.ler("caminho/da/imagem.ppm")

case resultado do
  {:ok, img} ->
    IO.puts("Imagem carregada: #{img.largura}x#{img.altura} píxeis")

  {:error, mensagem} ->
    IO.puts(mensagem)
end
```

---

## Testes Realizados

Os filtros foram aplicados e validados no ambiente Elixir/WSL com a seguinte saída:

```
=== Testando Questão 3 ===
Tentando ler arquivo existente: dg.ppm...
Imagem carregada: 4x3 píxeis

Tentando ler arquivo inexistente: arquivo_inexistente.ppm...
Arquivo não encontrado: arquivo_inexistente.ppm

=== Testando Filtros da Questão 2 ===
Testando espelhar_horizontal...
Testando espelhar_vertical...
Testando girar_180...
Testando girar_90_horario...
Testando girar_90_anti_horario...
Testando aplicar_negativo...
Testando aplicar_limiar (limite: 120)...
Testando esquentar (tx: 50)...
Testando esfriar (tx: 50)...

Filtros aplicados e salvos com sucesso!
```
