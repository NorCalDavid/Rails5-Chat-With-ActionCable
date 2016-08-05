class FriendshipsController < ApplicationController

	def create
	  @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
	  
	  if @friendship.save
	  	respond_to do |format|
	      format.html { redirect_to profile_url(current_user), notice: 'Friendship was successfully destroyed.' }
	      format.json { render json: { url: profile_url }, status: 202 }
	    end
	  else
	  	respond_to do |format|
	      format.html { redirect_to profile_url(current_user), alert: 'Unable to Create Friendship.' }
	      format.json { render json: { url: profile_url }, status: 400 }
	    end
	  end
	end

	# DELETE /friendships/1/block
	def block
	  @friendship = User.find(params[:friend_id]).friendships.find_by(friend_id: current_user.id)
	  @friendship.destroy

	  @other_friendship = current_user.friendships.find_by(friend_id: params[:friend_id])
	  @other_friendship.destroy unless @other_friendship.nil?

	  @block = current_user.blocks.create(:friend_id => params[:friend_id])

    respond_to do |format|
      format.html { redirect_to profile_url, notice: 'Friendship was successfully destroyed.' }
      format.json { render json: { url: profile_url }, status: 202 }
    end
  end

	# DELETE /friendships/1/destroy
	def destroy
	  @friendship = current_user.friendships.find_by(friend_id: params[:id])
	  @friendship.destroy

    respond_to do |format|
      format.html { redirect_to profile_url, notice: 'Friendship was successfully destroyed.' }
      format.json { render json: { url: profile_url }, status: 202 }
    end
  end

end
