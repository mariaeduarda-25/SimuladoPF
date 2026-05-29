defmodule LpQuestionsTest do
  use ExUnit.Case

  for module <- [LpQuestions.ComCauda, LpQuestions.SemCauda] do
    describe "Testes para #{module}" do
      test "Q1: somar_naturais/1" do
        assert unquote(module).somar_naturais(0) == 0
        assert unquote(module).somar_naturais(5) == 15
        assert unquote(module).somar_naturais(10) == 55
      end

      test "Q2: fatorial/1" do
        assert unquote(module).fatorial(0) == 1
        assert unquote(module).fatorial(1) == 1
        assert unquote(module).fatorial(5) == 120
      end

      test "Q3: fibonacci/1" do
        assert unquote(module).fibonacci(0) == 0
        assert unquote(module).fibonacci(1) == 1
        assert unquote(module).fibonacci(2) == 1
        assert unquote(module).fibonacci(3) == 2
        assert unquote(module).fibonacci(4) == 3
        assert unquote(module).fibonacci(5) == 5
        assert unquote(module).fibonacci(8) == 21
      end

      test "Q4: menor_de_dois/2" do
        assert unquote(module).menor_de_dois(3, 5) == 3
        assert unquote(module).menor_de_dois(10, 2) == 2
        assert unquote(module).menor_de_dois(4, 4) == 4
      end

      test "Q5: produtorio_impares/1" do
        assert unquote(module).produtorio_impares(0) == 1
        assert unquote(module).produtorio_impares(1) == 1
        assert unquote(module).produtorio_impares(2) == 3
        assert unquote(module).produtorio_impares(3) == 15
      end

      test "Q6: somatorio_quadrados/1" do
        assert unquote(module).somatorio_quadrados(0) == 0
        assert unquote(module).somatorio_quadrados(1) == 1
        assert unquote(module).somatorio_quadrados(2) == 5
        assert unquote(module).somatorio_quadrados(3) == 14
        assert unquote(module).somatorio_quadrados(4) == 30
      end

      test "Q7: soma_digitos/1" do
        assert unquote(module).soma_digitos(0) == 0
        assert unquote(module).soma_digitos(9) == 9
        assert unquote(module).soma_digitos(123) == 6
        assert unquote(module).soma_digitos(9876) == 30
      end

      test "Q8: mdc/2" do
        assert unquote(module).mdc(12, 8) == 4
        assert unquote(module).mdc(17, 3) == 1
        assert unquote(module).mdc(5, 0) == 5
      end

      test "Q9: contagem_regressiva/1" do
        assert unquote(module).contagem_regressiva(0) == []
        assert unquote(module).contagem_regressiva(3) == [3, 2, 1]
      end

      test "Q10: soma_fracoes/1" do
        assert_in_delta unquote(module).soma_fracoes(1), 1.0, 0.0001
        assert_in_delta unquote(module).soma_fracoes(3), 1.0 + 0.5 + 0.33333, 0.0001
      end

      test "Q11: tamanho/1" do
        assert unquote(module).tamanho([]) == 0
        assert unquote(module).tamanho([10, 20, 30]) == 3
      end

      test "Q12: somar_elementos/1" do
        assert unquote(module).somar_elementos([]) == 0
        assert unquote(module).somar_elementos([1, 2, 3]) == 6
        assert unquote(module).somar_elementos([-1, 5, 2]) == 6
      end

      test "Q13: multiplicar_elementos/1" do
        assert unquote(module).multiplicar_elementos([]) == 1
        assert unquote(module).multiplicar_elementos([2, 3, 4]) == 24
      end

      test "Q14: pertence?/2 (elemento, lista)" do
        assert unquote(module).pertence?(3, [1, 2, 3, 4]) == true
        assert unquote(module).pertence?(5, [1, 2, 3, 4]) == false
        assert unquote(module).pertence?(1, []) == false
      end

      test "Q24: pertence?/2 (elemento, conjunto)" do
        assert unquote(module).pertence?(3, [1, 2, 3, 4]) == true
        assert unquote(module).pertence?(5, [1, 2, 3, 4]) == false
        assert unquote(module).pertence?(1, []) == false
      end

      test "Q15: inverter/1" do
        assert unquote(module).inverter([]) == []
        assert unquote(module).inverter([1, 2, 3]) == [3, 2, 1]
      end

      test "Q16: maior/1" do
        assert unquote(module).maior([5]) == 5
        assert unquote(module).maior([1, 5, 3]) == 5
        assert unquote(module).maior([10, -2, 8]) == 10
      end

      test "Q17: maiores_que/2" do
        assert unquote(module).maiores_que(3, [1, 5, 2, 4]) == [5, 4]
        assert unquote(module).maiores_que(5, [1, 2, 3]) == []
      end

      test "Q18: maiores_que?/2" do
        assert unquote(module).maiores_que?(2, [3, 4, 5]) == true
        assert unquote(module).maiores_que?(2, [1, 3, 4]) == false
        assert unquote(module).maiores_que?(5, []) == true
      end

      test "Q19: contar_ocorrencias/2" do
        assert unquote(module).contar_ocorrencias(2, [1, 2, 2, 3]) == 2
        assert unquote(module).contar_ocorrencias(5, [1, 2, 3]) == 0
        assert unquote(module).contar_ocorrencias(1, []) == 0
      end

      test "Q20: remover/2" do
        assert unquote(module).remover(2, [1, 2, 3, 2]) == [1, 3, 2]
        assert unquote(module).remover(5, [1, 2, 3]) == [1, 2, 3]
        assert unquote(module).remover(1, []) == []
      end

      test "Q21: eh_conjunto?/1" do
        assert unquote(module).eh_conjunto?([1, 2, 3]) == true
        assert unquote(module).eh_conjunto?([1, 2, 2]) == false
        assert unquote(module).eh_conjunto?([]) == true
      end

      test "Q22: uniao/2" do
        res = unquote(module).uniao([1, 2, 3], [3, 4, 5])
        assert Enum.sort(res) == [1, 2, 3, 4, 5]

        assert Enum.sort(unquote(module).uniao([], [1, 2])) == [1, 2]
      end

      test "Q23: intersecao/2" do
        res = unquote(module).intersecao([1, 2, 3], [2, 3, 4])
        assert Enum.sort(res) == [2, 3]

        assert unquote(module).intersecao([1, 2], [3, 4]) == []
      end

      test "Q25: subconjunto?/2" do
        assert unquote(module).subconjunto?([1, 2], [1, 2, 3]) == true
        assert unquote(module).subconjunto?([1, 4], [1, 2, 3]) == false
        assert unquote(module).subconjunto?([], [1, 2]) == true
      end

      test "Q26: superconjunto?/2" do
        assert unquote(module).superconjunto?([1, 2, 3], [1, 2]) == true
        assert unquote(module).superconjunto?([1, 2, 3], [1, 4]) == false
        assert unquote(module).superconjunto?([1, 2], []) == true
      end
    end
  end
end
