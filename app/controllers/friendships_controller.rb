class FriendshipsController < ApplicationController
	include UsersHelper
    require 'will_paginate/array'
before_filter  :setup_friends,:except => :index

def index
	@friends = current_user.friends
	@requested_friends = current_user.requested_friends
	@pending_friends = current_user.pending_friends
end

def create
	Friendship.request(@user, @friend)
	#raise @friend.id.inspect
	@notification = Notification.new(:user_id => current_user.id, :notification_type => "friendship", :notifiable_id  => @friend.id)
	@notification.save
	flash[:notice] = "Friend request sent."
	redirect_to(:back)
end

def accept
	if @user.requested_friends.include?(@friend)
	Friendship.accept(@user, @friend)
	flash[:notice] = "Friendship with #{@friend.nickname} accepted!"
	else
	flash[:notice] = "No friendship request from #{@friend.nickname}."
	end
	redirect_to(:back)
end

def decline
	if @user.requested_friends.include?(@friend)
	Friendship.breakup(@user, @friend)
	flash[:notice] = "Friendship with #{@friend.nickname} declined"
	else
	flash[:notice] = "No friendship request from #{@friend.nickname}."
	end
	redirect_to(:back)
end

def cancel
if @user.pending_friends.include?(@friend)
 Friendship.breakup(@user, @friend)
  flash[:notice] = "Friendship request canceled."
  else
  flash[:notice] = "No request for friendship with #{@friend.nickname}"
 end
 redirect_to(:back)
end


def delete
 if @user.friends.include?(@friend)
  Friendship.breakup(@user, @friend)
  flash[:notice] = "Friendship with #{@friend.nickname} deleted!"
 else
  flash[:notice] = "You aren't friends with #{@friend.nickname}"
 end
redirect_to(:back)
end


private

def setup_friends
	@user = current_user
	@friend = User.find(params[:id])
end
end
