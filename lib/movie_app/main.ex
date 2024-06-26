defmodule MovieApp.Main do
  @moduledoc """
  The main module to interpret and execute commands.
  """

  alias MovieApp.{CSVReader, Operations, Constants}

  @doc """
  Interprets and executes a command.

  ## Examples

      iex> MovieApp.Main.call("count color")
      [{4814, ["Color"]}, {209, [" Black and White"]}]

      iex> MovieApp.Main.call("select duration from movie_title limit 2")
      [{"Trapped", "511"}, {"Carlos", "334"}]

  """

  def call(raw_query, file_name \\ "movies.csv") do
    data = CSVReader.read_file(file_name)
    query = String.downcase(raw_query)

    case String.split(query) do
      ["count", column | rest] ->
        Constants.valid_column?(column)
        |> send_count(column, rest, data)

      ["select", column, "from", sortable_col | rest] ->
        Constants.valid_column?(column, sortable_col)
        |> send_select(sortable_col, column, rest, data)

      _ ->
        {:error, "invalid query"}
    end
  end

  @doc """
  Call count functions or return an error

  ## Examples

      iex> MovieApp.Main.send_count(false, "col_name" ,1 , 2)
      {:error, "column col_name is not countable"}

      iex> data = MovieApp.CSVReader.read_file("movies.csv")
      iex> MovieApp.Main.send_count(true, "color", [], data)
      [{4814, ["Color"]}, {209, [" Black and White"]}]

  """

  def send_count(false, column, _rest, _data) do
    {:error, "column #{column} is not countable"}
  end

  def send_count(true, column, rest, data) do
    {order, limit} = get_options(rest)
    data
    |> Operations.count_column(column, order, limit)
  end

  @doc """
  Call sort_column_by functions or return an error

  ## Examples

      iex> MovieApp.Main.send_select(false, "col_name", "sort_col", [], nil)
      {:error, "column sort_col is not selectable for col_name"}

      iex> data = MovieApp.CSVReader.read_file("movies.csv")
      iex> MovieApp.Main.send_select(true, "movie_title", "duration", ["limit", "3"], data) 
      [{"Trapped", "511"}, {"Carlos", "334"}, {"Blood In, Blood Out", "330"}]

  """

  def send_select(false, sortable_col, column, _rest, _data) do
    {:error, "column #{column} is not selectable for #{sortable_col}"}
  end

  def send_select(true, sortable_col, column, rest, data) do
    {order, limit} = get_options(rest)
    data
    |> Operations.sort_column_by(sortable_col, column, order, limit)
  end

  defp get_options(rest) do
    data = to_keyword(rest)
    case data do
      [] -> {:desc, 5}
      _ -> { get_value(data, :order), get_value(data, :limit)}
    end
  end

  defp get_value(data, :order) do
    data
    |> Keyword.get(:order, "desc")
    |> String.to_atom
  end

  defp get_value(data, :limit) do
    data
    |> Keyword.get(:limit, "5")
    |> String.to_integer
  end

  defp to_keyword(rest) do
    rest
    |> Enum.chunk_every(2)
    |> Enum.map(fn [k, v] -> {String.to_atom(k), v} end)
  end
end
