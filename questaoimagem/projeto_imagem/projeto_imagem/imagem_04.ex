# Disciplina: Linguagens de Programação
# Professor: Douglas M. Tavares
# Versão: 2026
#
# Biblioteca: Imagem DG

defmodule Imagem do
  # Define a estrutura de dados:
  defstruct largura: 0, altura: 0, cor_maxima: 255, matriz_pixeis: []

  def ler(caminho_arquivo) do
    {:ok, conteudo_arquivo} = File.read(caminho_arquivo)

    # Pipeline de processamento:
    lista_lexica =
      conteudo_arquivo
      |> String.split("\n")
      |> Enum.map(fn item -> String.split(item, "#") |> hd() end)
      |> Enum.join(" ")
      |> String.split()

    # Extrai cabeçalho e os subpíxeis:
    ["P3", larg_str, alt_str, cor_max_str | cauda_lexica] = lista_lexica

    # Converte strings para inteiros:
    largura = larg_str |> String.to_integer()
    altura = alt_str |> String.to_integer()
    cor_maxima = cor_max_str |> String.to_integer()
    lista_subpixeis = cauda_lexica |> Enum.map(&String.to_integer/1)

    matriz_pixeis =
      lista_subpixeis
      |> Enum.chunk_every(3)
      |> Enum.map(fn [r, g, b] -> {r, g, b} end)
      |> Enum.chunk_every(largura)

    # Retorna uma estrutura (um registro):
    %Imagem{
      largura: largura,
      altura: altura,
      cor_maxima: cor_maxima,
      matriz_pixeis: matriz_pixeis
    }
  end
end
