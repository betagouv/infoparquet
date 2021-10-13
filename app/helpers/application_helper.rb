module ApplicationHelper
    def tab_link(link_text, link_path)
        content_tag(:li, :class => "fr-nav__item") do
            if request.path.start_with?(link_path)
                link_to link_text, link_path, class: "fr-nav__link", "aria-current": "page"
            else
                link_to link_text, link_path, class: "fr-nav__link"
            end
        end
    end
end
