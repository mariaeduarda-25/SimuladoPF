# Disciplina: Linguagens de Programação
# Professor: Douglas M. Tavares
# Versão: 2026
#
# Biblioteca: Imagem DG

defmodule Imagem do
  # Define a estrutura de dados:
  defstruct largura: 0, altura: 0, cor_maxima: 255, lista_pixeis: []

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

    lista_pixeis =
      lista_subpixeis
      # A cada 3 subpíxeis, constrói 1 pixel: [r,g,b].
      |> Enum.chunk_every(3)
      # Converte lista para tupla.
      |> Enum.map(fn [r, g, b] -> {r, g, b} end)

    # Retorna uma estrutura (um registro):
    %Imagem{
      largura: largura,
      altura: altura,
      cor_maxima: cor_maxima,
      lista_pixeis: lista_pixeis
    }
  end
end
