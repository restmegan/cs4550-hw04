defmodule Practice.Factors do
	def nextOdd(i) do
		if (i === 2) do
			3
		else
			i + 2
		end
	end
	def nextPrime(i) when i < 7 do
		nextOdd(i)
	end
	def nextPrime(i) do
		x = nextOdd(i)
		if (rem(x, 3) == 0 || rem(x, 5) == 0 || rem(x, 7) == 0) do
			nextPrime(x)
		else
			x
		end
	end
	def factor(num, curPrime, list) when num == 1 do
		list
	end
	def factor(num, curPrime, list) do
		if (rem(num, curPrime) === 0) do
			factor(div(num, curPrime), curPrime, [curPrime | list])
		else
			factor(num, nextPrime(curPrime), list)
		end
	end
	def getFactors(num) do
		if (num === 1) do
			[1]
		else
			factor(num, 2, []) |> Enum.reverse()
		end
	end
end
    
