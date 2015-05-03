module ApplicationHelper

  def app_title
    "Inside / Human Resources System"
  end

  # employee search condition field helper
  def link_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  # add resource allocation fields helper
  def link_to_add_associations(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  # Generates a set of checkboxes for a HABTM assignment in a form.  Labels are properly assigned
  # to the checkboxes and markup is valid HTML.
  #
  #   habtm_checkboxes(@organizer, :event_ids, @events, :name)
  #
  #   <%= hidden_field_tag "organizer[event_ids][]", "" %>
  #   <% @events.each do |event| -%>
  #     <%= check_box_tag "organizer[event_ids][]", event.id, @organizer.event_ids.include?(event.id), :id => "organizer_events_id_#{event.id}" %>
  #     <%= label_tag "organizer_events_id_#{event.id}", h(event.name) %>
  #   <% end -%>
  def habtm_checkboxes(obj, column, assignment_objects, assignment_object_display_column)
    obj_to_s    = obj.class.to_s.split("::").last.underscore
    field_name  = "#{obj_to_s}[#{column}][]"

    html = hidden_field_tag(field_name, "")
    assignment_objects.each do |assignment_obj|
      cbx_id = "#{obj_to_s}_#{column}_#{assignment_obj.id}"
      html += check_box_tag field_name, assignment_obj.id, obj.send(column).include?(assignment_obj.id), :id => cbx_id
      html += label_tag cbx_id, h(assignment_obj.send(assignment_object_display_column))
      html += content_tag(:br)
    end
    html
  end

end
