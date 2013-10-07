require "lib/uuid"

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

# Create an RFC4122 UUID http://www.ietf.org/rfc/rfc4122.txt
set :uuid, UUID.create_sha1('malik.pro', UUID::NameSpace_URL)

 # Blog settings

def blog_set (obj, name, prefix="")
  obj.sources = "articles/"+name+"/:year-:month-:day-:title.html"
  obj.default_extension = ".markdown"

  obj.permalink = prefix+"/:title-:year:month:day.html"
  obj.year_link = prefix+"/:year.html"
  obj.month_link = prefix+"/:year/:month.html"
  obj.day_link = prefix+"/:year/:month/:day.html"
  obj.taglink = prefix+"/:tag.html"

  obj.tag_template = "tag.html"
  obj.calendar_template = "calendar.html"
  obj.layout = "layouts/article_layout.haml"

  obj.name = name
  obj.paginate = false
  obj
end

activate :blog do |blog|
  blog_set blog, 'en'
end

activate :blog do |blog|
  blog_set blog, 'pl', 'pl'
end

page "/sitemap.xml", :layout => "sitemap.xml"
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
