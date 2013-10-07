module CustomHelpers
  def get_root_url page
    '/' + (page.data.lang if page.data.lang and page.data.lang != 'en').to_s
  end

  def delocalized_date date
    I18n.l date, :format => '%e %B %Y'
  end

  def force_locale page
    (I18n.locale = current_page.data.lang.to_sym) if current_page.data.lang
  end
end
