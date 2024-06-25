defmodule MovieApp.CSVReader do
  @moduledoc """
  Read and parse CSV File
  """
  alias NimbleCSV.RFC4180, as: CSV

  @doc """
  Read a CSV File and return a list of maps

  ## Examples

  iex> MovieApp.CSVReader.read_file("path/to/movies.csv")

  """

  def read_file(file_name) do
    Application.app_dir(:movie_app, "priv/#{file_name}")
    |> File.stream!
    |> CSV.parse_stream(skip_headers: false)
    |> Enum.to_list
    |> to_keyword_list
  end

  def to_keyword_list([headers | rows]) do
    Enum.map(rows, fn row -> Enum.zip(headers, row) |> Enum.into(%{}) end)
  end
end

