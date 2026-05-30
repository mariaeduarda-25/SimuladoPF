# Script para testar as implementações das Questões 2 e 3

# 1. Carrega o arquivo contendo a definição do módulo Imagem
Code.require_file("imagem_12.ex")

IO.puts("=== Testando Questão 3 ===")

# Caso 3a: Leitura com sucesso
caminho_sucesso = "dg.ppm"
IO.puts("Tentando ler arquivo existente: #{caminho_sucesso}...")
resultado_sucesso = Imagem.ler(caminho_sucesso)

case resultado_sucesso do
  {:ok, img} ->
    IO.puts("Imagem carregada: #{img.largura}x#{img.altura} píxeis")

  {:error, mensagem} ->
    IO.puts(mensagem)
end

# Caso 3b: Leitura com erro
caminho_erro = "arquivo_inexistente.ppm"
IO.puts("\nTentando ler arquivo inexistente: #{caminho_erro}...")
resultado_erro = Imagem.ler(caminho_erro)

case resultado_erro do
  {:ok, img} ->
    IO.puts("Imagem carregada: #{img.largura}x#{img.altura} píxeis")

  {:error, mensagem} ->
    IO.puts(mensagem)
end

IO.puts("\n=== Testando Filtros da Questão 2 ===")

case resultado_sucesso do
  {:ok, img} ->
    # 1. Espelhar Horizontal
    IO.puts("Testando espelhar_horizontal...")
    img_esp_hor = Imagem.espelhar_horizontal(img)
    Imagem.escrever(img_esp_hor, "dg_espelhar_horizontal.ppm")

    # 2. Espelhar Vertical (já implementado pelo professor)
    IO.puts("Testando espelhar_vertical...")
    img_esp_ver = Imagem.espelhar_vertical(img)
    Imagem.escrever(img_esp_ver, "dg_espelhar_vertical.ppm")

    # 3. Girar 180
    IO.puts("Testando girar_180...")
    img_girar_180 = Imagem.girar_180(img)
    Imagem.escrever(img_girar_180, "dg_girar_180.ppm")

    # 4. Girar 90 Horário
    IO.puts("Testando girar_90_horario...")
    img_girar_90_h = Imagem.girar_90_horario(img)
    Imagem.escrever(img_girar_90_h, "dg_girar_90_horario.ppm")

    # 5. Girar 90 Anti-Horário
    IO.puts("Testando girar_90_anti_horario...")
    img_girar_90_ah = Imagem.girar_90_anti_horario(img)
    Imagem.escrever(img_girar_90_ah, "dg_girar_90_anti_horario.ppm")

    # 6. Aplicar Negativo
    IO.puts("Testando aplicar_negativo...")
    img_negativo = Imagem.aplicar_negativo(img)
    Imagem.escrever(img_negativo, "dg_aplicar_negativo.ppm")

    # 7. Aplicar Limiar
    IO.puts("Testando aplicar_limiar (limite: 120)...")
    img_limiar = Imagem.aplicar_limiar(img, 120)
    Imagem.escrever(img_limiar, "dg_aplicar_limiar.ppm")

    # 8. Esquentar
    IO.puts("Testando esquentar (tx: 50)...")
    img_quente = Imagem.esquentar(img, 50)
    Imagem.escrever(img_quente, "dg_esquentar.ppm")

    # 9. Esfriar
    IO.puts("Testando esfriar (tx: 50)...")
    img_frio = Imagem.esfriar(img, 50)
    Imagem.escrever(img_frio, "dg_esfriar.ppm")

    IO.puts("\nFiltros aplicados e salvos com sucesso!")

  {:error, mensagem} ->
    IO.puts("Não foi possível prosseguir com os testes de filtros devido ao erro de leitura: #{mensagem}")
end
