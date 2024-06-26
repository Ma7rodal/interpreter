# MovieApp (Interpreter)

This application script allows you to analyze the CSV file about movies, and from the elixir  
interactive console you can make queries
We have two types of queries: count and select

**Count** is done on columns that are not integer type, you can see them [here](https://github.com/Ma7rodal/interpreter/blob/main/lib/movie_app/constants.ex#L27)  
- Limit and order are optional, by default are limit 5 and order desc
  
<a name="count">Query examples</a>:  
- count title_year LIMIT 1 ORDER asc
- count color color LIMIT 2
- count director_name LIMIT -1

------------

**SELECT** is done on columns associated with main columns such as movie_title or director_name   
the syntax is `SELECT duration FROM movie_title`
- Limit and order are optional, by default are limit 5 and order desc

*principal columns and its selects*
- director_name => director_facebook_likes
- actor_1_name => actor_1_facebook_likes
- actor_2_name => actor_2_facebook_likes
- actor_3_name => actor_3_facebook_likes
- movie_title => actor_1_facebook_likes, actor_2_facebook_likes, actor_3_facebook_likes, budget, cast_total_facebook_likes, director_facebook_likes, duration, facenumber_in_poster, gross, imdb_score, movie_facebook_likes, num_critic_for_reviews, num_user_for_reviews, num_voted_users, title_year

<a name="select">Query examples</a>: 
- SELECT budget FROM movie_title limit 3 order asc
- SELECT director_facebook_likes FROM director_name ORDER desc limit 5
- SELECT duration FROM movie_title limit 20

## local
Install elixir [install](https://elixir-lang.org/install.html) from official documentation  
Check version  
```bash
$ elixir --version
```
Elixir console, in a terminal navigate to your project directory
```bash
$ iex -S mix
```
Now you can execute queries [examples](#count)
```elixir
iex(1)> query = "select duration from movie_title order desc limit 4"
"select duration from movie_title order desc limit 4"
iex(2)> MovieApp.run(query)
```

### local tests
From your project directory
```bash
$ mix test
```
------------
## Docker
Build app  
```bash
$ docker build -t movie_app -f Dockerfile .
```
Run  
```bash
$ docker run --rm -it movie_app
```
Now you can execute [queries](#select)
```
Interactive Elixir (1.17.0) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> query = "count title_year limit 3"
"count title_year limit 3"
iex(2)> MovieApp.run(query)
[{260, ["2009"]}, {252, ["2014"]}, {239, ["2006"]}]
```

### Test from docker
```bash
$ docker build -t movie_app_test -f Dockerfile.test .
$ docker run --rm movie_app_test
```
------------
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `movie_app` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:movie_app, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/movie_app>.
