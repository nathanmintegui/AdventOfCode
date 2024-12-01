defmodule Solution do
  def main() do
    data = read_file()

    sum_of_pontuations =
      data
      |> Enum.map(&get_pontuation_of_line/1)
      |> Enum.reduce(0, fn pontuation, acc ->
        pontuation + acc
      end)

    IO.inspect sum_of_pontuations

  end  

  def get_pontuation_of_line(value) do
    {winning_numbers_list, my_numbers_list} = get_winning_numbers_and_my_numbers(value)

    acc = Enum.reduce(winning_numbers_list, 0, fn winning_num, acc ->
      Enum.reduce(my_numbers_list, acc, fn my_num, acc_inner ->
        if my_num == winning_num do
          acc_inner + 1
        else
          acc_inner
        end
      end)
    end)

   pontuation = 
    if acc <= 2 do
      acc  
    else
      Integer.pow(2, acc - 1) 
    end

    pontuation
  end 

  def get_winning_numbers_and_my_numbers(value) do
    [_prefix, sufix] = String.split(value, ":", parts: 2)
    [wn, mn] = String.split(sufix, "|") 
    winning_numbers = String.split(wn, " ") 
      |> Enum.filter(fn item -> item !== "" end) 
  
    my_numbers = String.split(mn, " ")
      |> Enum.filter(fn item -> item !== "" end)

    {winning_numbers, my_numbers}
  end

  def read_file() do
    {:ok, file} = File.open("input.txt")

    IO.read(file, :eof)
      |> String.split("\n")
      |> List.delete_at(-1)
  end
end

Solution.main()
