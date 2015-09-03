json.array!(@blogs) do |blog|
  json.extract! blog, :id, :title, :context, :created_at, :updated_at
  json.url blog_url(blog, format: :json)
end
