defmodule LpQuestions.ComCauda do
  @moduledoc """
  Implementações das questões utilizando recursão em cauda (Tail Recursion).
  """

  # # 1. somar_naturais(n)
  def somar_naturais(n) when n >= 0, do: somar_naturais_cauda(n, 0)

  defp somar_naturais_cauda(0, acc), do: acc
  defp somar_naturais_cauda(n, acc), do: somar_naturais_cauda(n - 1, acc + n)

  # # 2. fatorial(n)
  def fatorial(n) when n >= 0, do: fatorial_cauda(n, 1)

  defp fatorial_cauda(0, acc), do: acc
  defp fatorial_cauda(n, acc), do: fatorial_cauda(n - 1, acc * n)

  # # 3. fibonacci(n)
  def fibonacci(n) when n >= 0, do: fibonacci_cauda(n, 0, 1)

  defp fibonacci_cauda(0, atual, _proximo), do: atual

  defp fibonacci_cauda(n, atual, proximo),
    do: fibonacci_cauda(n - 1, proximo, atual + proximo)

  # # 4. menor_de_dois(a, b)
  def menor_de_dois(a, b), do: menor_cauda(a, b, 0)

  defp menor_cauda(0, _b, acc), do: acc
  defp menor_cauda(_a, 0, acc), do: acc
  defp menor_cauda(a, b, acc), do: menor_cauda(a - 1, b - 1, acc + 1)

  # # 5. produtorio_impares(n)
  def produtorio_impares(n) when n >= 0, do: produtorio_impares_cauda(n, 1)

  defp produtorio_impares_cauda(0, acc), do: acc

  defp produtorio_impares_cauda(n, acc) do
    impar_atual = 2 * n - 1
    produtorio_impares_cauda(n - 1, acc * impar_atual)
  end

  # # 6. somatorio_quadrados(n)
  def somatorio_quadrados(n) when n >= 0, do: somatorio_quadrados_cauda(n, 0)

  defp somatorio_quadrados_cauda(0, acumulador), do: acumulador

  defp somatorio_quadrados_cauda(n, acumulador) do
    somatorio_quadrados_cauda(n - 1, n * n + acumulador)
  end

  # # 7. soma_dos_digitos(n)
  def soma_digitos(n) when n >= 0, do: soma_digitos_cauda(n, 0)

  defp soma_digitos_cauda(0, acc), do: acc
  defp soma_digitos_cauda(n, acc), do: soma_digitos_cauda(div(n, 10), acc + rem(n, 10))

  # # 8. MDC
  def mdc(a, b), do: mdc_cauda(a, b)

  defp mdc_cauda(a, 0), do: a
  defp mdc_cauda(a, b), do: mdc_cauda(b, rem(a, b))

  # # 9. Contagem regressiva
  def contagem_regressiva(n) when n >= 0, do: contagem_regressiva_cauda(n, [])

  defp contagem_regressiva_cauda(0, acc), do: acc
  defp contagem_regressiva_cauda(n, acc), do: contagem_regressiva_cauda(n - 1, acc ++ [n])

  # # 10. Soma harmônica
  def soma_fracoes(n) when n >= 0, do: soma_fracoes_cauda(n, 0.0)

  defp soma_fracoes_cauda(0, acc), do: acc
  defp soma_fracoes_cauda(n, acc), do: soma_fracoes_cauda(n - 1, acc + 1 / n)

  # # 11. Tamanho
  def tamanho(lista), do: tamanho_cauda(lista, 0)

  defp tamanho_cauda([], acc), do: acc
  defp tamanho_cauda([_h | t], acc), do: tamanho_cauda(t, acc + 1)

  # # 12. Somar elementos
  def somar_elementos(lista), do: somar_elementos_cauda(lista, 0)

  defp somar_elementos_cauda([], acc), do: acc
  defp somar_elementos_cauda([h | t], acc), do: somar_elementos_cauda(t, acc + h)

  # # 13. Multiplicar elementos
  def multiplicar_elementos(lista), do: multiplicar_elementos_cauda(lista, 1)

  defp multiplicar_elementos_cauda([], acc), do: acc
  defp multiplicar_elementos_cauda([h | t], acc), do: multiplicar_elementos_cauda(t, acc * h)

  # # 14 & 24. Pertence?
  def pertence?(elemento, lista), do: pertence_cauda(elemento, lista)

  defp pertence_cauda(_elemento, []), do: false
  defp pertence_cauda(elemento, [elemento | _t]), do: true
  defp pertence_cauda(elemento, [_h | t]), do: pertence_cauda(elemento, t)

  # # 15. Inverter
  def inverter(lista), do: inverter_cauda(lista, [])

  defp inverter_cauda([], acc), do: acc
  defp inverter_cauda([h | t], acc), do: inverter_cauda(t, [h | acc])

  # # 16. Maior
  def maior([h | t]), do: maior_cauda(t, h)

  defp maior_cauda([], acc), do: acc

  defp maior_cauda([h | t], acc) do
    novo_maior = if h > acc, do: h, else: acc
    maior_cauda(t, novo_maior)
  end

  # # 17. maiores_que(elemento, lista)
  def maiores_que(e, lista), do: maiores_que_c(e, lista, [])

  defp maiores_que_c(_e, [], acc), do: Enum.reverse(acc)

  defp maiores_que_c(e, [h | t], acc) do
    novo_acc = if h > e, do: [h | acc], else: acc
    maiores_que_c(e, t, novo_acc)
  end

  # # 18. maiores_que?(elemento, lista)
  def maiores_que?(e, lista), do: mq_bool_c(e, lista)

  defp mq_bool_c(_e, []), do: true

  defp mq_bool_c(e, [h | t]) do
    if h > e, do: mq_bool_c(e, t), else: false
  end

  # # 19. contar_ocorrencias(elemento, lista)
  def contar_ocorrencias(e, lista), do: contar_c(e, lista, 0)

  defp contar_c(_e, [], acc), do: acc

  defp contar_c(e, [h | t], acc) do
    novo_acc = if h == e, do: acc + 1, else: acc
    contar_c(e, t, novo_acc)
  end

  # # 20. remover(elemento, lista)
  def remover(e, lista), do: remover_c(e, lista, [])

  defp remover_c(_e, [], acc), do: Enum.reverse(acc)
  defp remover_c(e, [e | t], acc), do: Enum.reverse(acc) ++ t
  defp remover_c(e, [h | t], acc), do: remover_c(e, t, [h | acc])

  # # 21. eh_conjunto?
  def eh_conjunto?(lista), do: eh_conjunto_cauda(lista)

  defp eh_conjunto_cauda([]), do: true

  defp eh_conjunto_cauda([h | t]) do
    if pertence?(h, t), do: false, else: eh_conjunto_cauda(t)
  end

  # # 22. uniao
  def uniao(conjunto_A, conjunto_B), do: uniao_cauda(conjunto_A, conjunto_B)

  defp uniao_cauda([], acc), do: acc

  defp uniao_cauda([h | t], acc) do
    novo_acc = if pertence?(h, acc), do: acc, else: [h | acc]
    uniao_cauda(t, novo_acc)
  end

  # # 23. intersecao
  def intersecao(conjunto_A, conjunto_B), do: intersecao_cauda(conjunto_A, conjunto_B, [])

  defp intersecao_cauda([], _cB, acc), do: acc

  defp intersecao_cauda([h | t], conjunto_B, acc) do
    novo_acc = if pertence?(h, conjunto_B), do: [h | acc], else: acc
    intersecao_cauda(t, conjunto_B, novo_acc)
  end

  # # 25. subconjunto?
  def subconjunto?(conjunto_A, conjunto_B), do: subconjunto_cauda(conjunto_A, conjunto_B)

  defp subconjunto_cauda([], _cB), do: true

  defp subconjunto_cauda([h | t], conjunto_B) do
    if pertence?(h, conjunto_B) do
      subconjunto_cauda(t, conjunto_B)
    else
      false
    end
  end

  # # 26. superconjunto?
  def superconjunto?(conjunto_A, conjunto_B), do: subconjunto?(conjunto_B, conjunto_A)
end
