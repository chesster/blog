require "lib/uuid"

Dotenv.load
I18n.default_locale = :en
Time.zone = "UTC"

activate :i18n, :path => "/:locale/", :mount_at_root => :en, :lang_map => { :en => :en, :pl => :pl }
activate :livereload
activate :automatic_image_sizes
activate :syntax, :line_numbers => true


set :css_dir, 'stylesheets'
set :images_dir, 'images'
set :js_dir, 'javascripts'
set :haml, { ugly: true }

set :helpers_dir, "helpers"
set :layout, :_auto_layout
set :layouts_dir, "layouts"
set :locales_dir, "locales"

# set :markdown_engine, :redcarpet
set :markdown_engine, :kramdown
set :markdown, :fenced_code_blocks => true, :smartypants => true

# Create an RFC4122 UUID http://www.ietf.org/rfc/rfc4122.txt
set :uuid, UUID.create_sha1('malik.pro', UUID::NameSpace_URL)

 # Blog settings - GLOBAL
def blog_set (obj, name, prefix="")
  obj.sources = "articles/"+name+"/:year-:month-:day-:title.html"
  obj.default_extension = ".markdown"

  obj.permalink = prefix+"/:title-:year:month:day.html"
  obj.year_link = prefix+"/:year.html"
  obj.month_link = prefix+"/:year/:month.html"
  obj.day_link = prefix+"/:year/:month/:day.html"
  obj.taglink = prefix+"/:tag.html"

  obj.layout = "layouts/article_layout.haml"

  obj.tag_template = "tag."+name+".html"
  obj.calendar_template = "calendar."+name+".html"

  obj.name = name
  obj.paginate = false
  obj
end
# Blog settings - EN
activate :blog do |blog|
  blog_set blog, 'en'
end
# Blog settings - PL
activate :blog do |blog|
  blog_set blog, 'pl', 'pl'
end

page "/sitemap.xml", :layout => "sitemap.xml"

# Build-specific configuration
configure :build do
  activate :minify_html
  activate :gzip
  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
  activate :relative_assets
end
