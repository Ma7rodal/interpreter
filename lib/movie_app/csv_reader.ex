defmodule MovieApp.CSVReader do
  @moduledoc """
  Read and parse CSV File
  """
  alias NimbleCSV.RFC4180, as: CSV
  alias MovieApp.{Constants}

  @doc """
  Read a CSV File and return a list of maps

  ## Examples

  iex> MovieApp.CSVReader.read_file("movies.csv")
  #Stream<[enum: #Function<63.105594673/2 in Stream.transform/4>, funs: [#Function<50.105594673/1 in Stream.map/2>]]>

  """

  def read_file(file_name) do
    Application.app_dir(:movie_app, "priv/#{file_name}")
    |> File.stream!
    |> CSV.parse_stream
    |> Stream.map(fn row -> Stream.zip(headers(), row) |> Enum.into(%{}) end)
  end

  defp headers do
    Constants.headers
  end
end
