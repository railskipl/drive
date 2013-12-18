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


 def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
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
  
  def rate_count(carprofile_id)
    carprofile = Carprofile.find(params[:id])
    count = 0
    count += carprofile.send_gifts.count
    count += carprofile.comments_count
    count += carprofile.sum_counts(@count)
    count += Subscriber.find_all_by_subscribable_id(@carprofile.id).count
    count += Carprofile.find(carprofile_id).spotlighted ? 1 : 0
    return rating_star(count)
 end

  def rating_star(count)
    case count
      when 0..5
        "half_star"
      when 5..10
        "one_star"
      when 10..20
        "one_half_star"
      when 20..30
        "two_star"
      when 30..40
        "two_half_star"
      when 40..50
        "three_star"
     when 50..60
        "three_half_star"
      when 60..70
        "four_star"
      when 70..80
        "four_half_star"
      else
        "five_star"
    end
  end

end
