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

  @doc """
    Escreve (salva) uma imagem no formato PPM P3.

    Retorna ':ok' ou '{:error, mensagem}'.
  """
  def escrever(%Imagem{} = img, caminho_arquivo) do
    conteudo_p3 = img |> codificar_ppm()

    case File.write(caminho_arquivo, conteudo_p3) do
      :ok ->
        :ok

      {:error, :enoent} ->
        {:error, "Diretório pai não encontrado: #{caminho_arquivo}"}

      {:error, razao} ->
        {:error, "Erro ao escrever arquivo '#{caminho_arquivo}': #{razao}"}
    end
  end

  @doc """
    Retorna uma nova imagem em tons de cinza.

    Retorna '%Imagem{}'.
  """
  def aplicar_tons_cinza(%Imagem{} = img) do
    nova_matriz =
      img.matriz_pixeis
      |> Enum.map(fn linha ->
        linha
        |> Enum.map(fn {r, g, b} ->
          media = div(r + g + b, 3)
          {media, media, media}
        end)
      end)

    %Imagem{
      largura: img.largura,
      altura: img.altura,
      cor_maxima: img.cor_maxima,
      matriz_pixeis: nova_matriz
    }
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

  defp gerar_imagem([largura, altura, cor_maxima, lista_subpixeis])
       when largura * altura * 3 == length(lista_subpixeis) do
    matriz_pixeis = lista_subpixeis |> converter_para_matriz(largura)

    img = %Imagem{
      largura: largura,
      altura: altura,
      cor_maxima: cor_maxima,
      matriz_pixeis: matriz_pixeis
    }

    {:ok, img}
  end

  defp gerar_imagem(_dados_imagem) do
    {:error, "Número de píxeis esperado é diferente do encontrado."}
  end

  defp decodificar_ppm(conteudo_arquivo) do
    # Decodifica uma string PPM para uma struct Imagem.
    # Retorna '{:ok, imagem}' ou '{:error, razao}'.
    resultado_extracao =
      conteudo_arquivo
      |> quebrar_em_objetos()
      |> extrair_dados_imagem()

    case resultado_extracao do
      {:ok, dados_imagem} -> dados_imagem |> gerar_imagem()
      {:error, razao} -> {:error, razao}
    end
  end

  defp codificar_ppm(%Imagem{} = img) do
    # Codifica uma struct Imagem para string PPM.
    comentario =
      "# Criado pela Biblioteca Imagem DG\n# Em: #{Date.utc_today()}"

    cabecalho_ppm =
      "P3\n#{comentario}\n#{img.largura} #{img.altura}\n#{img.cor_maxima}\n"

    corpo_pixeis =
      img.matriz_pixeis
      |> Enum.map(fn linha_pixeis ->
        linha_pixeis
        |> Enum.map(fn {r, g, b} -> "#{r} #{g} #{b}\n" end)
      end)
      |> Enum.join()

    cabecalho_ppm <> corpo_pixeis
  end
end

## Exemplo de uso:
#case Imagem.ler("alquimia.ppm") do
#  {:ok, img} ->
#    img
#    |> Imagem.aplicar_tons_cinza()
#    |> Imagem.escrever("alquimia_cinza_dg.ppm")
#
#  {:error, razao} ->
#    IO.puts("Erro: #{razao}")
#end
