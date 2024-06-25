defmodule MovieApp.Operations do
  @moduledoc """
  Provides operations for counting and sorting movie data.
  """

  @director_name_cols ~w(director_facebook_likes)
  @actor_1_name_cols ~w(actor_1_facebook_likes)
  @actor_2_name_cols ~w(actor_2_facebook_likes)
  @actor_3_name_cols ~w(actor_3_facebook_likes)
  @movie_title_cols [
    "actor_1_facebook_likes",
    "actor_2_facebook_likes",
    "actor_3_facebook_likes",
    "budget",
    "cast_total_facebook_likes",
    "director_facebook_likes",
    "duration",
    "facenumber_in_poster",
    "gross",
    "imdb_score",
    "movie_facebook_likes",
    "num_critic_for_reviews",
    "num_user_for_reviews",
    "num_voted_users",
    "title_year"]

  @countable_cols [
    "actor_1_name",
    "actor_2_name",
    "actor_3_name",
    "aspect_ratio",
    "color",
    "content_rating",
    "country",
    "director_name",
    "language",
    "title_year",
    "movie_title"]

  @doc """
  Counts occurrences of values in a specified column.

  ## Examples

      iex> data = [%{"director_name" => "Director A"}, %{"director_name" => "Director B"}]
      iex> MovieApp.Operations.count_column(data, "director_name")
      %{"Director A" => 1, "Director B" => 1}

  """
  def count_column(data, column) do
    data
    |> Enum.map(&Map.get(&1, column))
    |> Enum.frequencies
    |> Map.delete("")
  end

  @doc """
  Sorts data by a specified column in ascending or descending order.

  ## Examples

      iex> data = [%{"budget" => 100}, %{"budget" => 200}]
      iex> MovieApp.Operations.sort_by(data, "budget", :asc)
      [%{"budget" => 100}, %{"budget" => 200}]

  """
  def sort_column_by(data, column, order, limit) do
    Enum.filter(data, fn x -> Map.get(x, column) != "" end)
    |> Enum.sort_by(&Map.get(&1,column) |> convert_to_int, order)
    |> Enum.map(fn x -> {Map.get(x, "movie_title"), Map.get(x, column)} end)
    |> Enum.take(limit)
  end

  @doc """
  Limits the number of records returned.

  ## Examples

      iex> data = [%{"budget" => 100}, %{"budget" => 200}]
      iex> MovieApp.Operations.limit(data, 1)
      [%{"budget" => 100}]

  """
  def limit(data, count) do
    Enum.take(data, count)
  end

  @doc """
  Validates if the column is countable.

  ## Examples

      iex> MovieApp.Operations.valid_countable_column?("director_name")
      true

      iex> MovieApp.Operations.valid_countable_column?("budget")
      false

  """
  def valid_countable_column?(column) do
    column in @countable_cols
  end

  defp convert_to_int(value) do
    case value do
      "" -> 0
      nil -> 0
      _ -> Integer.parse(value) |> elem(0)
    end
  end
end
