defmodule Solution do
  @red_cubes_constraints 12
  @green_cubes_constraints 13
  @blue_cubes_constraints 14

  def main() do 
    {:ok, file} = File.open("input.txt") 

    data = IO.read(file, :eof)
      |> String.split("\n")
      |> List.delete_at(-1) 

    raw_valid_ids = Enum.map(data, fn value -> 
      {id, r, g, b} = format_input_line(value)

      is_red_valid = validate_color_amount(r, "red")
      is_blue_valid = validate_color_amount(b, "blue")
      is_green_valid = validate_color_amount(g, "green")

      if is_red_valid && is_blue_valid && is_green_valid do
        String.to_integer(id)
      end

    end)

    filtered_valid_ids = Enum.filter(raw_valid_ids, fn id -> id !== nil end)    

    sum = Enum.reduce(filtered_valid_ids, 0, &(&1 + &2))

    IO.inspect sum 

    File.close(file)
  end

  def validate_color_amount(color_list, color) do
    is_valid_color_list = Enum.map(color_list, fn number -> 
      case color do
        "red" -> 
          if number <= @red_cubes_constraints do
            true
          else
            false
          end
        "green" -> 
          if number <= @green_cubes_constraints do
            true
          else
            false
          end
        "blue" -> 
          if number <= @blue_cubes_constraints do
            true
          else
            false
          end
      end
    end) 
    
    is_valid = Enum.member?(is_valid_color_list, false)

    !is_valid 
  end

  def format_input_line(value) do
    game_id = get_game_id(value)
    blue_count = get_color_count(value, "blue")
    red_count = get_color_count(value, "red")
    green_count = get_color_count(value, "green")

   {game_id, red_count, green_count, blue_count}
  end

  def get_color_count(value, color) do
    list = String.split(value, ":")
    [_first, rest] = list 
    
    formated_list = String.trim(rest) 
      |> String.replace(";", ",") 
      |> String.split(", ") 

    raw_blue_count_list = Enum.map(formated_list, fn cube_color ->  
      if String.contains?(cube_color, color) do
        String.to_integer(String.replace(cube_color, color, "") |> String.trim())
      else 
      end
    end)

    filtered_blue_count_list = Enum.filter(raw_blue_count_list, fn number -> number !== nil end)

    filtered_blue_count_list
  end

  def get_game_id(value) do
    String.split(value, ":") 
      |> hd() 
      |> String.replace("Game", "")
      |> String.trim()

  end

end

Solution.main()
