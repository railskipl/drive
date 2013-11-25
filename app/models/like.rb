class Like < Socialization::ActiveRecordStores::Like

	def self.like!(liker, likeable)
    
      unless likes?(liker, likeable)
       self.create! do |like|
          like.liker = liker
           like.likeable = likeable
           like.count = 1
        end
       call_after_create_hooks(liker, likeable)
       true
       else
       like = Like.find_by_liker_id_and_likeable_id(liker.id,likeable.id)
        raise like.inspect
        unless liker.credit == 0
          like.count = like.count + 1

          like.save 
        end
        
       end
   end
end
