# count every line of the file 
# search for the numbers
# then sum each number if theres is only one, should double it
# finally, sum every line number

defmodule Solution do
  def readFileLines() do
    {:ok, file} = File.open("input.txt") # TODO: see options to improve perf.

    data = IO.read(file, :eof) # TODO: remove last empty string on tupple 
      |> String.split("\n")

    list = []
    number_combination_list = Enum.map(data, fn value ->
      list ++ extract_numbers_sum(value)
    end)

    # sum all the number combinatons
    filtered_number_combination_list = Enum.filter(number_combination_list, fn number_combination -> number_combination !== "" end)

    converted_number_combination_list = Enum.map(filtered_number_combination_list, fn number_combination -> 
      String.to_integer(number_combination)
    end)

    #{:ok, binary} = File.read("example_input.txt")

    File.close(file)

    sum_values(converted_number_combination_list)
  end

  def combine_values(list) do
    "#{Enum.at(list, 0)}#{Enum.at(list, length(list) - 1)}"
  end

  def extract_numbers_sum(value) do
    chars_list = String.codepoints(value) # ["1", "a", "b", "c", "2"]

    # [1, nil, nil, nil, 2]
    numbers_list = []
    number_list = Enum.map(chars_list, fn char ->
      if Solution.is_number(char) do
        numbers_list ++ char
      end
    end) 

    # format the list
    filtered_list = Enum.filter(number_list, fn number -> number !== nil end)

    combine_values(filtered_list) 
  end

  def is_number(char) do
    case char do
      "1" -> true
      "2" -> true
      "3" -> true
      "4" -> true
      "5" -> true
      "6" -> true
      "7" -> true
      "8" -> true
      "9" -> true
       _  -> false
    end
  end

  def sum_values(list) do
    Enum.reduce(list, 0, &(&1 + &2))
  end
end

Solution.readFileLines() |> IO.inspect()
