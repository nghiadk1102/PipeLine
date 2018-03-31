module ApplicationHelper
  def link_to_add_fields(name, f, association, cssClass, title)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association.to_s + "_attributes[]", new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to name, "#", :onclick => h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), :class => cssClass, :title => title
  end

  def list_posts
    Post.all
  end
end
