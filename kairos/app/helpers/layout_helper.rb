module LayoutHelper
  def page_title
    title_components = [configatron.app_name]

    saved_title = content_for(:title)
    title_components.unshift(saved_title) unless saved_title.blank?

    title_components.join(' • ')
  end

  def page_stylesheet_tag
    controller = params[:controller]

    @page_stylesheet_tags ||= {}
    @page_stylesheet_tags[controller] ||= begin
      css_path = Pathname.pwd.
          join('app/assets/stylesheets/pages').
          join("#{controller}.css.scss")
      css_path.exist? ? stylesheet_link_tag("pages/#{controller}") : ''
    end
  end

  def page_javascript_tag
    controller = params[:controller]

    @page_stylesheet_tags ||= {}
    @page_stylesheet_tags[controller] ||= begin
      css_path = Pathname.pwd.
          join('app/assets/javascripts/pages').
          join("#{controller}.js")
      css_path.exist? ? stylesheet_link_tag("pages/#{controller}") : ''
    end
  end
end