module FriendshipsHelper

def friendship_status(user, friend)
  friendship = Friendship.find_by_user_id_and_friend_id(user, friend)
  return "#{friend.nickname} is not your friend (yet)." if friendship.nil?
  case friendship.flag
    when 'requested'
     "#{friend.nickname} would like to be your friend."
    when 'pending'
     "Friendship requested"
    when 'accepted'
     "#{friend.nickname} is your friend."
    end
  end

end
  