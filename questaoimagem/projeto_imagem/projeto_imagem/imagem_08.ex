# Disciplina: Linguagens de Programação
# Professor: Douglas M. Tavares
# Versão: 2026
#
# Biblioteca: Imagem DG

defmodule Imagem do
  @moduledoc """
    Biblioteca: Imagem DG

    Permite ler, manipular e escrever imagens no formato PPM P3.
    Cada píxel é representado pelos valores R(vermelho), G(verde) e B(azul).

    Atenção: Este módulo atualmente suporta APENAS o formato PPM tipo P3.
  """

  defstruct largura: 0, altura: 0, cor_maxima: 255, matriz_pixeis: []

  @doc """
    Lê (carrega) uma imagem no formato PPM P3 do arquivo.

    Retorna '{:ok, imagem}' ou '{:error, mensagem}'.
  """
  def ler(caminho_arquivo) do
    case File.read(caminho_arquivo) do
      {:ok, conteudo_arquivo} ->
        conteudo_arquivo |> decodificar_ppm()

      {:error, :enoent} ->
        {:error, "Arquivo não encontrado: #{caminho_arquivo}"}

      {:error, razao} ->
        {:error, "Erro ao ler arquivo '#{caminho_arquivo}': #{razao}"}
    end
  end

  #
  # ========== Funções auxiliares (PRIVADAS) ==========

  defp quebrar_em_objetos(conteudo_arquivo) do
    # Quebra o texto conteudo_arquivo em uma lista de objetos léxicos.
    conteudo_arquivo
    |> String.split("\n")
    |> Enum.map(fn item -> String.split(item, "#") |> hd() end)
    |> Enum.join(" ")
    |> String.split()
  end

  defp converter_para_matriz(lista_subpixeis, largura) do
    # Converte [r1, g1 , b1, r2, g2, b2, ...] em matriz de tuplas.
    lista_subpixeis
    |> Enum.chunk_every(3)
    |> Enum.map(fn [r, g, b] -> {r, g, b} end)
    |> Enum.chunk_every(largura)
  end

  defp extrair_dados_imagem(["P3", larg_str, alt_str, cor_max_str | cauda_lexica]) do
    # Retorna {:ok, [largura, altura, cor_maxima, lista_pixels]}
    largura = larg_str |> String.to_integer()
    altura = alt_str |> String.to_integer()
    cor_maxima = cor_max_str |> String.to_integer()
    lista_subpixeis = cauda_lexica |> Enum.map(&String.to_integer/1)

    {:ok, [largura, altura, cor_maxima, lista_subpixeis]}
  end

  defp extrair_dados_imagem(["P3" | _]) do
    {:error, "Formato PPM P3 com cabeçalho mal formado."}
  end

  defp extrair_dados_imagem([formato | _]) do
    {:error, "Formato #{formato} não suportado. Esperado formato P3."}
  end

  defp extrair_dados_imagem([]) do
    {:error, "Arquivo vazio ou apenas comentários."}
  end

  defp decodificar_ppm(conteudo_arquivo) do
    # Decodifica uma string PPM para uma struct Imagem.
    # Retorna '{:ok, imagem}' ou '{:error, razao}'.
    resultado_extracao =
      conteudo_arquivo
      |> quebrar_em_objetos()
      |> extrair_dados_imagem()

    case resultado_extracao do
      {:ok, [largura, altura, cor_maxima, lista_subpixeis]} ->
        matriz_pixeis = lista_subpixeis |> converter_para_matriz(largura)

        img = %Imagem{
          largura: largura,
          altura: altura,
          cor_maxima: cor_maxima,
          matriz_pixeis: matriz_pixeis
        }

        {:ok, img}

      {:error, razao} ->
        {:error, razao}
    end
  end
end
