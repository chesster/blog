Dotenv.load
I18n.default_locale = :en
Time.zone = "UTC"

activate :i18n
activate :livereload
activate :automatic_image_sizes
activate :syntax, :line_numbers => true


set :css_dir, 'stylesheets'
set :images_dir, 'images'
set :js_dir, 'javascripts'

set :helpers_dir, "helpers"
set :layout, :_auto_layout
set :layouts_dir, "layouts"
set :locales_dir, "locales"

 # Blog settings
activate :blog do |blog|
  blog.sources = "articles/:year-:month-:day-:title.html"
  blog.default_extension = ".markdown"

  blog.permalink = ":title-:year:month:day.html"
  blog.year_link = "archive/:year.html"
  blog.month_link = "archive/:year/:month.html"
  blog.day_link = "archive/:year/:month/:day.html"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"
  blog.layout = "layouts/article_layout.haml"

  # blog.prefix = "blog"
  blog.taglink = ":tag.html"
  blog.paginate = false
end

page "/feed.xml", :layout => false

# Build-specific configuration
configure :build do
  activate :minify_html
  activate :gzip
  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
  activate :relative_assets
end
