defmodule MovieApp do
  @moduledoc """
  Documentation for `MovieApp`.
  """
  alias MovieApp.{Main}

  def run(query)  do
    Main.call(query)
  end
end
