module ApplicationHelper


 def format_boolean(approved)
        if approved
          icon_tick
        else
          icon_cross
        end
      end
      
      def icon_tick(alt_text='Tick')
        build_image_tag("/assets/001_06.png", alt_text)
      end

      def icon_cross(alt_text='Cross')
        build_image_tag("/assets/001_05.png", alt_text)
      end
      
      def build_image_tag(image_file, alt_text)
        image_tag(image_file, :size =>"20x20", :alt => alt_text)
      end
      
        def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

    def build_photo_tag(photo_file, alt_text)
        photo_tag(photo_file, :size =>"20x20", :alt => alt_text)
    end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
