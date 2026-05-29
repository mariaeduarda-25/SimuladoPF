defmodule LpQuestions.SemCauda do
  @moduledoc """
  Implementações das questões utilizando recursão sem cauda (Body Recursion).
  """

  # # 1. somar_naturais(n)
  def somar_naturais(0), do: 0
  def somar_naturais(n) when n > 0, do: n + somar_naturais(n - 1)

  # # 2. fatorial(n)
  def fatorial(0), do: 1
  def fatorial(n) when n > 0, do: n * fatorial(n - 1)

  # # 3. fibonacci(n)
  def fibonacci(0), do: 0
  def fibonacci(1), do: 1
  def fibonacci(n) when n > 1, do: fibonacci(n - 1) + fibonacci(n - 2)

  # # 4. menor_de_dois(a, b)
  def menor_de_dois(a, b) when a < b, do: a
  def menor_de_dois(_a, b), do: b

  # # 5. produtorio_impares(n)
  def produtorio_impares(0), do: 1
  def produtorio_impares(n) when n > 0, do: (2 * n - 1) * produtorio_impares(n - 1)

  # # 6. somatorio_quadrados(n)
  def somatorio_quadrados(0), do: 0
  def somatorio_quadrados(n) when n > 0, do: n * n + somatorio_quadrados(n - 1)

  # # 7. soma_digitos(n)
  def soma_digitos(n) when n < 10, do: n
  def soma_digitos(n), do: rem(n, 10) + soma_digitos(div(n, 10))

  # # 8. MDC
  def mdc(a, 0), do: a
  def mdc(a, b), do: mdc(b, rem(a, b))

  # # 9. Contagem regressiva
  def contagem_regressiva(0), do: []
  def contagem_regressiva(n) when n > 0, do: [n | contagem_regressiva(n - 1)]

  # # 10. Soma harmônica
  def soma_fracoes(1), do: 1.0
  def soma_fracoes(n) when n > 1, do: 1 / n + soma_fracoes(n - 1)

  # # 11. Tamanho
  def tamanho([]), do: 0
  def tamanho([_h | t]), do: 1 + tamanho(t)

  # # 12. Somar elementos
  def somar_elementos([]), do: 0
  def somar_elementos([h | t]), do: h + somar_elementos(t)

  # # 13. Multiplicar elementos
  def multiplicar_elementos([]), do: 1
  def multiplicar_elementos([h | t]), do: h * multiplicar_elementos(t)

  # # 14. Pertence?
  def pertence?(_elemento, []), do: false
  def pertence?(elemento, [h | t]), do: h == elemento or pertence?(elemento, t)

  # # 24. Pertence?
  def pertence?(_elemento, []), do: false
  def pertence?(elemento, [h | t]), do: h == elemento or pertence?(elemento, t)

  # # 15. Inverter
  def inverter([]), do: []
  def inverter([h | t]), do: inverter(t) ++ [h]

  # # 16. Maior
  def maior([h]), do: h

  def maior([h | t]) do
    m = maior(t)
    if h > m, do: h, else: m
  end

  # # 17. maiores_que(elemento, lista)
  def maiores_que(_e, []), do: []

  def maiores_que(e, [h | t]) do
    if h > e, do: [h | maiores_que(e, t)], else: maiores_que(e, t)
  end

  # # 18. maiores_que?(elemento, lista)
  def maiores_que?(_e, []), do: true
  def maiores_que?(e, [h | t]), do: h > e and maiores_que?(e, t)

  # # 19. contar_ocorrencias(elemento, lista)
  def contar_ocorrencias(_e, []), do: 0

  def contar_ocorrencias(e, [h | t]) do
    if h == e, do: 1 + contar_ocorrencias(e, t), else: contar_ocorrencias(e, t)
  end

  # # 20. remover(elemento, lista)
  def remover(_e, []), do: []
  def remover(e, [e | t]), do: t
  def remover(e, [h | t]), do: [h | remover(e, t)]

  # # 21. eh_conjunto?
  def eh_conjunto?([]), do: true

  def eh_conjunto?([h | t]) do
    if pertence?(h, t), do: false, else: eh_conjunto?(t)
  end

  # # 22. uniao
  def uniao([], conjunto_B), do: conjunto_B

  def uniao([h | t], conjunto_B) do
    if pertence?(h, conjunto_B) do
      uniao(t, conjunto_B)
    else
      [h | uniao(t, conjunto_B)]
    end
  end

  # # 23. intersecao
  def intersecao([], _conjunto_B), do: []

  def intersecao([h | t], conjunto_B) do
    if pertence?(h, conjunto_B) do
      [h | intersecao(t, conjunto_B)]
    else
      intersecao(t, conjunto_B)
    end
  end
  # # 25. subconjunto?
  def subconjunto?([], _conjunto_B), do: true

  def subconjunto?([h | t], conjunto_B) do
    pertence?(h, conjunto_B) and subconjunto?(t, conjunto_B)
  end

  # # 26. superconjunto?
  def superconjunto?(conjunto_A, conjunto_B) do
    subconjunto?(conjunto_B, conjunto_A)
  end
end
