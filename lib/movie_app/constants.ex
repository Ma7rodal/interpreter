defmodule MovieApp.Constants do
  @moduledoc """
  Provides operations for counting and sorting movie data.
  """

  @headers ["color", "director_name", "num_critic_for_reviews", "duration",
   "director_facebook_likes", "actor_3_facebook_likes", "actor_2_name",
   "actor_1_facebook_likes", "gross", "genres", "actor_1_name", "movie_title",
   "num_voted_users", "cast_total_facebook_likes", "actor_3_name",
   "facenumber_in_poster", "plot_keywords", "movie_imdb_link",
   "num_user_for_reviews", "language", "country", "content_rating", "budget",
   "title_year", "actor_2_facebook_likes", "imdb_score", "aspect_ratio",
   "movie_facebook_likes"]

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
  Validates if the column is member of type of cols

  ## Examples

      iex> MovieApp.Constants.valid_column?("director_name")
      true

      iex> MovieApp.Constants.valid_column?("imdb_score")
      false

      iex> MovieApp.Constants.valid_column?("budget", "movie_title")
      true

      iex> MovieApp.Constants.valid_column?("col", "movie_title")
      false

  """


  def valid_column?(column, sortable_col) do
    case sortable_col do
      "movie_title" ->
        column in @movie_title_cols 
      "director_name" ->
        column in @director_name_cols
      "actor_1_name" ->
        column in @actor_1_name_cols
      "actor_2_name" ->
        column in @actor_2_name_cols
      "actor_3_name" ->
        column in @actor_3_name_cols
      _ -> false
    end
  end

  def valid_column?(column) do
    column in @countable_cols
  end

  def headers do
    @headers
  end
end
