defmodule MovieApp.Operations do
  @moduledoc """
  Provides operations for counting and sorting movie data.
  """

  @countable_columns ~w(color director_name year_title)a
  @sortable_columns ~w(movie_title director_name)a

  @doc """
  Counts occurrences of values in a specified column.

  ## Examples

      iex> data = [%{"director_name" => "Director A"}, %{"director_name" => "Director B"}]
      iex> MovieApp.Operations.count_column(data, "director_name")
      %{"Director A" => 1, "Director B" => 1}

  """
  def count_column
end
