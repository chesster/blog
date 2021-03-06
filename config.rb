require "lib/uuid"

Dotenv.load
I18n.default_locale = :en
Time.zone = "UTC"

activate :i18n, :path => "/:locale/", :mount_at_root => :en, :lang_map => { :en => :en, :pl => :pl }
activate :livereload
activate :automatic_image_sizes
activate :syntax, :line_numbers => true

activate :deploy do |deploy|
  # deploy.build_before = true
  deploy.method = :rsync
  deploy.host   = "web2.mydevil.net"
  deploy.path   = "/home/malik/domains/malik.pro/public_html"
  deploy.user  = "malik"
  deploy.port  = 22
  deploy.clean = true # remove orphaned files on remote host
end

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
set :markdown, :fenced_code_blocks => true, :smartypants => true, :autolink => true

# Create an RFC4122 UUID http://www.ietf.org/rfc/rfc4122.txt
set :uuid, UUID.create_sha1('malik.pro', UUID::NameSpace_URL)

 # Blog settings - GLOBAL
def blog_set (obj, name, prefix="")
  obj.sources = "articles/"+name+"/:year-:month-:day-:title.html"
  obj.default_extension = ".markdown.erb"

  obj.permalink = prefix+":title.html"
  obj.year_link = prefix+":year.html"
  obj.month_link = prefix+":year/:month.html"
  obj.day_link = prefix+":year/:month/:day.html"
  obj.taglink = prefix+":tag.html"

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
  blog_set blog, 'pl', 'pl/'
end

# Ignore Blog Templates
ignore "/tag.html"
ignore "/calendar.html"
ignore "/pl/tag.html"
ignore "/pl/calendar.html"


page '/kw.html' , :layout => :single_layout

page "/sitemap.xml", :layout => "sitemap.xml"


configure :development do
  activate :google_analytics do |ga|
    ga.tracking_id = false
  end
end


# Build-specific configuration
configure :build do
  # activate :minify_html
  activate :gzip
  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
  activate :relative_assets

  activate :google_analytics do |ga|
    ga.tracking_id = 'UA-44619069-1'
  end
end
