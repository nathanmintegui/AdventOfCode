defmodule Solution do
  def main() do
    values_part_one = [
      %{time: 60, distance: 601}, 
      %{time: 80, distance: 1163}, 
      %{time: 86, distance: 1559}, 
      %{time: 76, distance: 1300}, 
    ]

    values_part_two = [
      %{time: 60808676, distance: 601116315591300}
    ]

    answer = Enum.map(values_part_two, fn map -> 
      calculate_possibel_number_of_wins(map.time, map.distance)    
    end) 
      |> Enum.reduce(1, fn number, acc -> 
        number * acc
      end)

    IO.inspect answer
  end

  def calculate_possibel_number_of_wins(time, distance) do
    sum = Enum.map(0..time, fn number -> 
    speed = number
    remaining_time = time - number
    current_buffer = speed * remaining_time
      if current_buffer > distance do
        number 
      end
    end)

    Enum.filter(sum, fn number -> number !== nil end) |> length()
  end
end

Solution.main() 

