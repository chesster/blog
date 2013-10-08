module CustomHelpers

  def tplvar key, data, page
    data['main'][key] ? data['main'][key] : page['data'][key]
  end
  
  def get_root_tag page
    (page.data.lang if page.data.lang and page.data.lang != 'en').to_s
  end

  def get_root_url page
    '/' + (get_root_tag page)
  end

  def delocalized_date date
    I18n.l date, :format => '%e %B %Y'
  end

  def force_locale page
    (I18n.locale = current_page.data.lang.to_sym) if current_page.data.lang
  end

  def skill_stars stars, max_stars
    r=[]
    stars.times{r.push(content_tag(:i, "", class: 'icon-star'))}
    (max_stars-stars).times{r.push(content_tag(:i, "", class: 'icon-star-empty'))}
    r.join(' ')
  end
end
