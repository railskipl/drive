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
    @resource ||= User.create
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

    def build_photo_tag(photo_file, alt_text)
        photo_tag(photo_file, :size =>"20x20", :alt => alt_text)
    end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.create
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
  def rate_count(carprofile_id)
   
    carprofile = Carprofile.find(carprofile_id)

    count = 0
    count += carprofile.send_gifts.count
    count += carprofile.comments_count
    count += Like.find_by_likeable_type_and_likeable_id("Carprofile",carprofile_id).count
    count += carprofile.logbooks.count
    count += carprofile.favourites.count
    count += Subscriber.find_all_by_subscribable_id(carprofile_id).count
    count += Carprofile.find(carprofile_id).spotlighted ? 1 : 0
    return rating_star(count), send_noti(carprofile,count)
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

  def send_noti(carprofile,count)

    case count
      when 0..5
        @notification = Notification.find_or_create_by_rate_count(:user_id => carprofile.user_id, :notification_type => "rate_carprofile", :notifiable_id  => carprofile.user_id, :rate_count => "half_star")
      when 5..10
        @notification = Notification.find_or_create_by_rate_count(:user_id => carprofile.user_id, :notification_type => "rate_carprofile", :notifiable_id  => carprofile.user_id, :rate_count => "one_star")
      when 10..20
        @notification = Notification.find_or_create_by_rate_count(:user_id => carprofile.user_id, :notification_type => "rate_carprofile", :notifiable_id  => carprofile.user_id, :rate_count => "one_half_star")
      when 20..30
        @notification = Notification.find_or_create_by_rate_count(:user_id => carprofile.user_id, :notification_type => "rate_carprofile", :notifiable_id  => carprofile.user_id, :rate_count => "two_star")
      when 30..40
        @notification = Notification.find_or_create_by_rate_count(:user_id => carprofile.user_id, :notification_type => "rate_carprofile", :notifiable_id  => carprofile.user_id, :rate_count => "two_half_star")
      when 40..50
        @notification = Notification.find_or_create_by_rate_count(:user_id => carprofile.user_id, :notification_type => "rate_carprofile", :notifiable_id  => carprofile.user_id, :rate_count => "three_star")
     when 50..60
        @notification = Notification.find_or_create_by_rate_count(:user_id => carprofile.user_id, :notification_type => "rate_carprofile", :notifiable_id  => carprofile.user_id, :rate_count => "three_half_star")
      when 60..70
        @notification = Notification.find_or_create_by_rate_count(:user_id => carprofile.user_id, :notification_type => "rate_carprofile", :notifiable_id  => carprofile.user_id, :rate_count => "four_star")
      when 70..80
        @notification = Notification.find_or_create_by_rate_count(:user_id => carprofile.user_id, :notification_type => "rate_carprofile", :notifiable_id  => carprofile.user_id, :rate_count => "four_half_star")
      else
        
        @notification = Notification.find_or_create_by_rate_count(:user_id => carprofile.user_id, :notification_type => "rate_carprofile", :notifiable_id  => carprofile.user_id, :rate_count => "five_star")
    end
  end

   def top_cars(carprofile_ids=[])
     top_cars = {}
     carprofile_ids.each do |carprofile_id|
     carprofile = Carprofile.find(carprofile_id)
     count = 0
     count += carprofile.send_gifts.count
     count += carprofile.comments_count
     count += Like.find_by_likeable_type_and_likeable_id("Carprofile",carprofile_id).count rescue 0
     count += carprofile.logbooks.count
     count += carprofile.favourites.count
     count += Subscriber.find_all_by_subscribable_id(carprofile_id).count rescue 0
     count += Carprofile.find(carprofile_id).spotlighted ? 1 : 0
     top_cars.merge!({carprofile.id => count})
    end
   return Hash[top_cars.sort_by{|car, count| count }.reverse]
 end


end