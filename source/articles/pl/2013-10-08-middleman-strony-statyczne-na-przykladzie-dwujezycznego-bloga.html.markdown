---
title: "Middleman: Strony statyczne na przykładzie dwujęzycznego bloga"
description: "- Hostuj swoją stronę za darmo, nie martwiąc się o efekt wykopu i błedy programistyczne"
date: 2013-10-08 14:52 UTC
tags: ruby, middleman
blog: pl
lang: pl
---

* list
{:toc}


## Dlaczego statycznie?
Można by zapytać po co w erze Ruby on Rails, Django i Wordpressa bawić się stronami statycznymi, ale można też zapytać po co zaprzęgać bazy danych i płatny hosting by napisać kilka zdań albo zaprezentować firmę, więc może jednak warto się temu przyjrzeć z bliska:

### Zalety

* **Prędkość**. Nic nie jest szybciej ładowane od czystego HTMLa. Robienie stron w ten sposób (a blogów w szczególności) uodparnia nas na *efekt wykopu* dosyć skutecznie.
* **Prostota**. Pełna kontrola nad tym co się dzieje, nie musimy się przedzierać przez cudzy (czasami nienajlepszy) kod by osiągnąć to co chcemy. Nie trzeba się martwić czy nasz kod "wewnętrzny" jest zoptymalizowany, ma tylko działać.
* **Bezpieczeństwo**. Żadnego XSS, przechwytywania sesji, SQL injection, bugów w GEMach i innych. Mamy spokój.
* **Hosting**. Możemy hostować taką stronę gdzie chcemy, od [Github Pages](http://pages.github.com/) i Dropboxa przez darmowe hostingi, [RassberyPi](https://mug.im/blog/2013/01/20/how-to-deploy-octopress-on-a-raspberrypi/) po [TOR](https://www.torproject.org)a.
* **Łatwy backup**. Wszystko, od kodu po dane można trzymać na Githubie/Bitbuckecie/Dropboxie i przenieść stronę z serwera na serwer w minutę.
* **Ulubiony edytor zamiast wymuszonych WYSIWYGów**. Nie wiem jak wy, ale wole dodawać treść Vimem w markdownie, offline, niż się bawić w przeglądarki, ewentualnie w *kopiuj-wklej*.
* **Własne skrytpy**. Z czasem możemy sobie stworzyć zestaw skryptów w dowolnym języku programowania i jeszcze bardziej ułatwić sobie pracę.
* **Utylizacja usług zewnętrznych**. Istnieje wiele gotowych zewnętrznych komponentów które możemy wykorzystać. [Disqus](http://disqus.com/) tu jest dobrym przykładem: sami zrobimy to samo najwyżej równie dobrze, częściej gorzej.

### Wady
* **Brak interakcji z użytkownikiem**. Po za javascriptem z ciastkami i Local Storage i wszystkimi zewnętrznymi gotowcami których poszukamy w internecie (albo napiszemy sami) niewiele tu jesteśmy w stanie zdziałać.
* **Brak zaawansowanej wyszukiwarki**. Po za gotowcem od Google z wyszukiwarką będzie ciężko. szczególnie, jeśli mamy dużo (1000+) treści, pozostają nam tylko frontendowe rozwiązania, a nie wszędzie się one sprawdzą.
* **Bardzo kłopotpliwe przy dużej ilości treści i częstych zmianach**. Przegenerowanie paru milionów stron troche trwa a uploadowanie gigabajtow za każdym razem gdy trochę zmienimy wygląd to jakaś pomyłka.


## Ale jak to tak? HTML? Ręcznie?!
**Nie**. Nikt oczywiście nie bedzię pisał HTMLa samemu. Zmiana w wyglądzie była by zabawą na cały dzień albo i dłużej, nie wspominając o kanałach RSS, Sitemapach itp. Dlatego wymyślono gotowce. Aplikacje w np w Pythonie, Rubym które to ułatwią na tyle, że nie odczujemy tego przeskoku. No i nadal będziemy mogli korzystać ze wszystkich dobrodziejstw *nowego internetu* typu [LESS](http://haml.info/), [HAML](http://haml.info/), [Jinja](http://jinja.pocoo.org/) i co tam sobie wymyślimy.

## Gotowe rozwiązania
W trakcie pisania tej notki istnieje [194](http://staticsitegenerators.net/ "Lista systemów to generowania stron statycznych") systemów to generowania stron statycznych. Z popularniejszych (w miare sprawnie rozwijanych) można wymienić:

1. [Jekyll](http://jekyllrb.com/) ([Ruby](http://ruby-lang.org))
2. [Octopress](http://octopress.org/) ([Ruby](http://ruby-lang.org))
3. [Pelican](http://getpelican.com/) ([Python](http://www.python.org/))
4. [Hyde](http://hyde.github.io/)  ([Python](http://www.python.org/))
5. [DocPad](http://docpad.org/) ([CoffeeScript](http://coffeescript.org/))
6. **[Middleman](http://middlemanapp.com/)** ([Ruby](http://ruby-lang.org))

W tej notce skupimy się na tym ostatnim. 

## Middleman
Middleman ma solidny system wtyczek, niedużo domyślnych ustawień i wspiera takie technologie jak Coffescript, Sass i HAML na wejściu, bez zbędnego grzebania. Po prostu działa. I tak ma być. 
Zakładając, że używacie Linuksa/OSXa przystępujemy do instalacji.

### Instalacja RVM
Ci którzy jeszcze tego nie zrobili, powinni zainstalować [RVM](https://rvm.io/rvm/install). Nie jest to oczywiście wymagane, ale się przydaje, tak więc: 

~~~
    $ \curl -L https://get.rvm.io | bash
    $ source ~/.rvm/scripts/rvm
~~~

Sprawdzamy swoją konfigurację...

~~~
    $ type rvm | head -n 1
    rvm is a function
~~~

... i instalujemy odpowiednią wersję Ruby.

~~~
    $ rvm install 1.9.2
~~~

### Instalacja Middlemana
Instalujemy gema:

~~~
    $ gem install middleman
    $ gem install middleman-blog # opcjonalnie, ale do tego przykładu się przyda.
~~~

Inicjujemy projekt (w założeniu blog).

~~~ shell
    $ middleman init blog --template=blog
~~~

 `--template` to oczywiście szablon projektu, dostępne są *html5*, *mobile*, *smacss* (*blog* jest dostępny dopiero po instalacji wtyczki). Społeczność udostępniła też [kilka innych](http://directory.middlemanapp.com/#/templates/all).

Przechodzimy do `blog` i zmieniamy wpisy w `Gemfile` by korzystać z najnowszych wersji

~~~ ruby
    gem "middleman", git: 'https://github.com/middleman/middleman', branch: "master"
    gem "middleman-blog", git: 'https://github.com/epochwolf/middleman-blog', branch: "master"
~~~

Instalujemy pakiety...

~~~ shell
    $ bundle install
~~~

...i gotowe. Teraz możemy zobaczyć co mamy:

~~~ shell
    $ middleman server
    == The Middleman is loading
    == Locales: en (Default en)
    == LiveReload is waiting for a browser to connect
    == The Middleman is standing watch at http://0.0.0.0:4567
    == Inspect your site configuration at http://0.0.0.0:4567/__middleman/
~~~

Pierwszy adres to nasz blog, drugi to konfiguracja naszej aplikacji:

W przypadku gdy pojawi nam sie komunikat typu 

~~~ shell
/home/_USER_/.rvm/gems/ruby-1.9.3-p448/gems/execjs-1.4.0/lib/execjs/runtimes.rb:51:in `autodetect': Could not find a JavaScript runtime. See https://github.com/sstephenson/execjs for a list of available runtimes. (ExecJS::RuntimeUnavailable)
~~~

Dopisujemy na koniec `Gemfile`'a

~~~ ruby
gem 'execjs'
gem 'therubyracer'
~~~

i wpisujemy `bundle install`

### Gotowe wtyczki
Teraz można przystąpić do konfuguracji, ale zanim to zrobimy przejrzyjmy kilka [wtyczek](http://directory.middlemanapp.com/#/extensions/all) wykorzystanych w tym blogu. 


#### middleman-syntax ( [<i class="icon-external-link"></i>](https://github.com/middleman/middleman-syntax) )
Odpowiada za podświetlanie składni, przez [kramdown](http://kramdown.rubyforge.org) (wykorzystywany tutaj) lub [redcarpet](https://github.com/vmg/redcarpet). Wszystkie ustawienia wpisujemy w `config.rb`, ale o tym później.

~~~ ruby
gem "middleman-syntax", git: 'https://github.com/middleman/middleman-syntax', branch: "master"
~~~~

#### middleman-livereload ( [<i class="icon-external-link"></i>](https://github.com/middleman/middleman-livereload) )
Automatycznie przeładowuje stronę gdy jakiś plik w katalogu projektu się zmieni. Im mniej Alt-Tab tym lepiej.

~~~ ruby
gem "middleman-livereload", "~> 3.1.0"
~~~~

#### middleman-deploy ( [<i class="icon-external-link"></i>](https://github.com/tvaughan/middleman-deploy) )
Automagiczny deploy przez `$ middleman build && middleman deploy`. Wtyczka wspiera *rsync*, *git*, *ftp* i *sftp*. 

~~~ ruby
gem "middleman-deploy"
~~~~

#### middleman-minify-html ( [<i class="icon-external-link"></i>](https://github.com/middleman/middleman-minify-html) )
Kompresja wyjściowego HTMLa.

~~~ ruby
gem "middleman-minify-html"
~~~~

### Konfiguracja
Całą aplikację konfigurujemy przez odpowiednie wpisy w `config.rb`. Jako przykład niech posłuży plik z konfiguracją tego bloga:

~~~ ruby
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
set :markdown, :fenced_code_blocks => true, :smartypants => true, :autolink => true

# Create an RFC4122 UUID http://www.ietf.org/rfc/rfc4122.txt
set :uuid, UUID.create_sha1('malik.pro', UUID::NameSpace_URL)

 # Blog settings - GLOBAL
def blog_set (obj, name, prefix="")
  obj.sources = "articles/"+name+"/:year-:month-:day-:title.html"
  obj.default_extension = ".markdown"

  obj.permalink = prefix+"/:title.html"
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
~~~~

### Layouty i szablony

#### Helpery
...czyli fukncje wspomagające w szablonach. Oprócz kilku [gotowych](http://middlemanapp.com/helpers/) (standardowych w Raisach typu `stylesheet_link_tag`) możemy zdefiniować własne. Umieszczamy je w pliku `custom_helpers` w klasie `CustomHelpers` w katalogu `helpers` lub w innym zdefiniowanym w `config.rb` przez `set :helpers_dir, "__KATALOG__"`.

### Dane
Istnieje możliwość zaczytania danych z plików YAML przez wszystkie podstrony w systemie. Pliki te umieszczamy w katalogu `data`. Przyklad (plik `data/main.yml`):

~~~ yml
---
author: Łukasz Malik
description: Developers Blog
keywords: "php, python, django, ruby, ruby on rails"
title: malik.pro
~~~

Teraz dane w szabonie będą dostępne przez `data.main` czyli np `data.main.title`.

### Treść
Każdy plik z katalogu `source` będzię przetworzony na HTML. Na Przykład plik `/source/faq.haml.html` będzie przetworzony na `/faq.html`, chyba, że każemy systemowi go zignorować przez odpowiedni wpis w `config.rb` np.

~~~ ruby
ignore "/faq.html"
~~~

Przydatne przy tworzeniu szablonów. 

**Wpisy na blogu** tworzymy przez

~~~ shell
    $ middleman article "Tytuł artykułu" [-D _data_]
~~~

Co stworzy plik podobny do `/source/_prefix_bloga_/_sciezka_artykułów_/2013-10-08.tytul-artykulu-html.markdown`. `_prefix_bloga_` ustawiamy przez `blog.prefix = '__PREFIX__` a `_sciezka_artykułów_` przez `blog.sources` w `config.rb` w sekcji 

~~~ ruby
    activate :blog do |blog|
      ...
    end
~~~

Data domyślnie jest dzisiejsza. Wpisy z przyszłą datą nie są publikowane. Przydatne gdy mamy zadanie w cronie budujące stronę co jakiś czas.

Powstały plik markdown będzie mieć podobny nagłówek do tego:

~~~ markdown
---
title: "Middleman: Strony statyczne na przykładzie dwujęzycznego bloga"
description: ""
date: 2013-10-08 14:52 UTC
tags: ruby, middleman
---
~~~

Gdzie `tags` to tagi/kategorie wpisu. Dane te są dostępne przez `current_page.data` możemy tam wpisać wszystko to co się potem może przydać np do szablonów. Dodatkowo można pisać notki np w *.erb, jeżeli będą nam potrzebne funkcje Rubiego, wtedy plik z notką będzie musiał mieć końcówkę **\*.markdown.erb**, dodatkowo należy dopisać odpowiednią opcję do `config.rb`:

~~~ ruby
set :markdown, :layout_engine => :erb, 
~~~

### Budowanie strony
Pliki które będą wysyłane na serwer znajdują się w `/build`. Generujemy to pliki poleceniem

~~~ shell

~~~

### Deploy

## Dwa blogi i dwa języki w jednej aplikacji 

### Dwa języki...

### ...i dwa blogi...

~~~ markdown
---
title: "Middleman: Strony statyczne na przykładzie dwujęzycznego bloga"
description: "- Hostuj swoją stronę za darmo, nie martwiąc się o efekt wykopu i błedy programistyczne"
date: 2013-10-08 14:52 UTC
tags: ruby, middleman
blog: pl
lang: pl
---
~~~

### ...jednocześnie.

## Dodatki

### Komentarze
Jedno słowo: [Disqus](http://disqus.com/). Rejestrujemy się w serwisie, pobieramy odpowieni javascript do wstawienia na stronę i już możemy gromadzić naszą społecznośc.

### Wyszukiwarka
Tu też za bardzo nie mamy wyjścia. Zostaje [Google Custom Search](https://www.google.com/cse), ewentualnie możemy się pokusić o przeszukiwanie Javascriptem JSONa stworzonego z bazy wspisów (podobnie jak robiliśmy SiteMapę) albo o jakieś [rozwiązanie](https://github.com/reyesr/fullproof) na [Local Storage](http://www.w3schools.com/html/html5_webstorage.asp) ale to już wychodzi po za temat tej notki.

## Podsumowanie
Tak oto niewielkim sumptem zbudowaliśmy bloga. Mi całość zajęła 10h, ale to tylko dlatego, że nie wszystko było udokumentowane. Podobnym sposobem możemy zbudować też inne strony: wizytówke firmową, katalog pełnometrażówek z Youtube, preclowe zaplecze SEO, statystyki naszego serwera albo aplikację mobilną na [PhoneGapie](https://github.com/pixelsonly/middleman-phonegap). Bez martwienia się o hosting, bezpieczeńswto naszej aplikacji, wydajność i bazy danych. Ogólnie - całkiem nieźle.

Nie jest to oczywiście wszystko co należy o tym systemie wiedzieć, nie było min. o pisaniu własnych rozszerzeń i o co ciekawszym wykorzystaniu Rack Middleware, ale na początek wystarczy. W razie czego odsyłam do dokumentacji projektu.

## Źródła
1. [middlemanapp.com](http://middlemanapp.com) - strona projektu.
2. [Repozytorium](https://github.com/malik-pro/blog) tego bloga.
3. [Repozytorium](https://github.com/DarrenN/darrenknewton.com) darrenknewton.com.
4. [Repozytorium](https://github.com/epochwolf/epochwolf.com) epochwolf.com.
5. [Repozytorium](https://github.com/timurvafin/timurv.ru) timurv.ru.