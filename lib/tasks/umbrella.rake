task(:umbrella) do
    raw_file = open("https://api.darksky.net/forecast/" + ENV.fetch("DARKSKY_API_KEY") + "/41.8887,-87.6355").read
    data = JSON.parse(raw_file)
    p data
end