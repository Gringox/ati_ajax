json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :username, :content
  json.url tweet_url(tweet, format: :json)
end
