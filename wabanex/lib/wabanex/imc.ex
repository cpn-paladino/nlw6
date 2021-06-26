defmodule Wabanex.IMC do
  def calculate(%{"filename" => filename}) do
    # functional programming
    filename
    |> File.read()
    |> handle_file()

  end

  defp handle_file({:ok, content}) do
    data =
      content
      |> String.split("\n")
      |> Enum.map(fn line -> parse_line(line) end)
      |> Enum.into(%{})

    {:ok, data}
    # usado para mostrar saída
    #|>IO.inspect()
  end

  defp handle_file({:error}) do
    {:error, 'Error while opening the file'}
    # reason
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()

  end

  defp calculate_imc([name, height, weight]), do: {name, weight/(height*height)}

  # old way
  # result = File.read(filename)
  # handle_file(result)



end
