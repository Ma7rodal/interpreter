FROM elixir:1.17.0 AS build

RUN mix local.hex --force && mix local.rebar --force

WORKDIR /app

COPY mix.exs mix.lock ./

RUN mix deps.get --only prod

COPY . .

RUN MIX_ENV=prod mix compile

FROM elixir:1.17.0

RUN mix local.hex --force && mix local.rebar --force

WORKDIR /app

COPY --from=build /app/_build /app/_build
COPY --from=build /app/deps /app/deps
COPY --from=build /app/lib /app/lib
COPY --from=build /app/priv /app/priv
COPY mix.exs mix.lock ./

CMD ["iex", "-S", "mix"]
