defmodule MovieApp.Operations do
  @moduledoc """
  Provides operations for counting and sorting movie data.
  """

  @doc """
  Counts occurrences of values in a specified column.

  ## Examples

      iex> data = MovieApp.CSVReader.read_file("movies.csv")
      iex> MovieApp.Operations.count_column(data, "aspect_ratio", :asc, 2)
      [{1, ["2.24", "1.89", "1.77", "1.44", "1.2", "1.18"]}, {2, ["2.55", "1.5"]}]

  """
  def count_column(data, column, order, limit) do
    data
    |> Stream.map(&Map.get(&1, column))
    |> Enum.frequencies
    |> Map.delete("")
    |> swap_keys
    |> sortable(order)
    |> Enum.take(limit)
  end

  @doc """
  Sorts data by a specified column in ascending or descending order.

  ## Examples

      iex> data = MovieApp.CSVReader.read_file("movies.csv")
      iex> MovieApp.Operations.sort_column_by(data, "movie_title", "budget", :desc, 3)
      [{"The Host", "12215500000"}, {"Lady Vengeance", "4200000000"}, {"Fateless", "2500000000"}]

  """
  def sort_column_by(data, sortable_col, column, order, limit) do
    Stream.filter(data, fn x -> Map.get(x, column) != "" end)
    |> Enum.sort_by(&Map.get(&1,column) |> convert_to_int, order)
    |> Stream.map(fn x -> {Map.get(x, sortable_col), Map.get(x, column)} end)
    |> Stream.uniq
    |> Enum.take(limit)
  end

  defp swap_keys(data) do
    Enum.reduce(data, %{}, fn {key, value}, acc ->
      Map.update(acc, value, [key], fn x -> [key | x] end)
    end)
  end

  defp sortable(data, order) do
    case order do
      :desc -> Enum.sort(data, fn {k1, _}, {k2, _} -> k1 >= k2 end)
      :asc -> Enum.sort(data)
    end
  end

  defp convert_to_int(value) do
    case value do
      "" -> 0
      nil -> 0
      _ -> Integer.parse(value) |> elem(0)
    end
  end
end
