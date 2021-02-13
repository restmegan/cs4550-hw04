defmodule Practice.Calc do
	def parse_float(text) do
		{num, _} = Float.parse(text)
		num
	end

	def getValAt(expr, i) do
		Enum.at(expr, i)
	end

	def getExprLength(expr) do
		Enum.count(expr)
	end

	def getProd(expr, i) do
		parse_float(getValAt(expr, i - 1)) * parse_float(getValAt(expr, i + 1))
	end
	def getQuotient(expr, i) do
		parse_float(getValAt(expr, i - 1)) / parse_float(getValAt(expr, i + 1))
	end

	def handleMult(expr, i) do
		expr
		|> List.replace_at(i - 1, Float.to_string(getProd(expr, i)))
		|> List.delete_at(i + 1)
		|> List.delete_at(i)
	end
	def handleDiv(expr, i) do
		expr
		|> List.replace_at(i - 1, Float.to_string(getQuotient(expr, i)))
		|> List.delete_at(i + 1)
		|> List.delete_at(i)
	end

	def handleMultDiv(expr, i) do
		cond do
			i >= Enum.count(expr) -> expr
			getValAt(expr, i) == "*" -> handleMultDiv(handleMult(expr, i), i)
			getValAt(expr, i) == "/" -> handleMultDiv(handleDiv(expr, i), i)
			true -> handleMultDiv(expr, i + 1)
		end
	end

	def multDiv(expr) do
		handleMultDiv(expr, 0)
	end

	def getSum(expr, i) do
		parse_float(getValAt(expr, i - 1)) + parse_float(getValAt(expr, i + 1))
	end
	def getDiff(expr, i) do
		parse_float(getValAt(expr, i - 1)) - parse_float(getValAt(expr, i + 1))
	end

	def handleAdd(expr, i) do
		expr
		|> List.replace_at(i - 1, Float.to_string(getSum(expr, i)))
		|> List.delete_at(i + 1)
		|> List.delete_at(i)
	end
	def handleSub(expr, i) do
		expr
		|> List.replace_at(i - 1, Float.to_string(getDiff(expr, i)))
		|> List.delete_at(i + 1)
		|> List.delete_at(i)
	end

	def handleAddSub(expr, i) do
		cond do
			i >= Enum.count(expr) -> expr
			getValAt(expr, i) == "+" -> handleAddSub(handleAdd(expr, i), i)
			getValAt(expr, i) == "-" -> handleAddSub(handleSub(expr, i), i)
			true -> handleAddSub(expr, i + 1)
		end
	end

	def addSub(expr) do 
		handleAddSub(expr, 0)
	end

	def calc(expr) do
		# This should handle +,-,*,/ with order of operations,
		# but doesn't need to handle parens.
		expr
		|> String.split(~r/\s+/)
		|> multDiv()
		|> addSub()
		|> hd
		|> parse_float
	end
end
