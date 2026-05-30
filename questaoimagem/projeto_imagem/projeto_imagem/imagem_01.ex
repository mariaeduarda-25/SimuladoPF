# Disciplina: Linguagens de Programação
# Professor: Douglas M. Tavares
# Versão: 2026
#
# Biblioteca: Imagem DG

defmodule Imagem do
  def ler(caminho_arquivo) do
    # Lê o arquivo:
    {:ok, conteudo_arquivo} = File.read(caminho_arquivo)

    # Divide em linhas:
    lista = String.split(conteudo_arquivo, "\n")

    lista
  end
end

## Exemplo de uso:
#Imagem.ler("dg.ppm")
