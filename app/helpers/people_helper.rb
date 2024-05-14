module PeopleHelper
  def active_inactive_nav_links(person)
    if person.active
      content_tag(:span, class: "text-success") do
        content_tag(:i, nil, class: "bi bi-check-circle")
      end
    else
      content_tag(:span, class: "text-danger") do
        content_tag(:i, nil, class: "bi bi-x-circle")
      end
    end
  end
end
