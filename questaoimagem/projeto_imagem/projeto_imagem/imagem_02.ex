# Disciplina: Linguagens de Programação
# Professor: Douglas M. Tavares
# Versão: 2026
#
# Biblioteca: Imagem DG

defmodule Imagem do
  def ler(caminho_arquivo) do
    # Lê o arquivo:
    {:ok, conteudo_arquivo} = File.read(caminho_arquivo)

    # Pipeline de processamento:
    #  - Remove os cometários.
    #  - Gera uma lista contento todos os objetos léxicos.
    lista_lexica =
      conteudo_arquivo
      |> String.split("\n")
      |> Enum.map(fn item -> String.split(item, "#") |> hd() end)
      |> Enum.join(" ")
      |> String.split()

    # Extrai cabeçalho e os subpíxeis:
    #   - Ignora elementos que não serão usados ainda.
    ["P3", _, _, _ | cauda_lexica] = lista_lexica

    # Converte strings para inteiros:
    lista_subpixeis =
      cauda_lexica |> Enum.map(fn item -> String.to_integer(item) end)

    lista_subpixeis
  end
end

## Exemplo de uso:
#Imagem.ler("dg.ppm")
