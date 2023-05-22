# Photogram Final

Look around [the target](http://photogram-final.matchthetarget.com/) and try to identify the new things, as compared to our previous version of Photogram.

Refer to [the chapter](https://chapters.firstdraft.com/chapters/837) for hints along the way.


## Specs
<details>
  <summary>Click here to see names of each test</summary>

<li>/users lists the usernames of all users </li>

<li>/users lists the private status of all users (Yes/No) </li>

<li>/users has an additional column for follow/unfollow when signed in. </li>

<li>/users hides column for follow/unfollow when signed out. </li>

<li>/users shows a 'Follow' button next to a user when you haven't sent a follow request </li>

<li>/users shows an 'Unfollow' link next to a user when you have sent a follow request and it was accepted </li>

<li>/users shows 'Request sent' and 'Cancel' link when you have sent a follow request and it's pending </li>

<li>/users shows nothing when you have sent a follow request and it was rejected </li>

<li>/users/[USERNAME]/feed has the photos posted by the people the user is following </li>

<li>/users/[USERNAME]/liked_photos has the photos the user has liked </li>

<li>/users/[USERNAME]/discover has the photos that are liked by the people the user is following </li>

<li>/users/[USERNAME] has a link with the text of the username of the signed in user </li>

<li>/users/[USERNAME] displays the value of the private column for the related User record </li>

<li>/users/[USERNAME] displays the follower count for the related User record </li>

<li>/users/[USERNAME] displays the number of users that the User is following </li>

<li>/users/[USERNAME] displays the number of Photos that the related User has added </li>

<li>/users/[USERNAME] displays each of the  Photos that the related User has added in <img> tags </li>

<li>/users/[USERNAME] has a link to the details page for each of the Photos that the related User has added </li>

<li>/users/[USERNAME] displays the caption for each of the Photos that the related User has added </li>

<li>/users/[USERNAME] displays the likes count for each of the Photos that the related User has added </li>

<li>/users/[USERNAME] displays the posted time for each of the Photos that the related User has added </li>

<li>/users/[USERNAME] has a link to the User's feed </li>

<li>/users/[USERNAME] has a link to the User's liked photos </li>

<li>/users/[USERNAME] has a link to the User's discover </li>

<li>/users/[USERNAME] has a 'Follow' button when the details page does not belong to the current user </li>

<li>/users/[USERNAME] has a 'Unfollow' link when the details page does not belong to the current user and the user is following </li>

<li>/users/[USERNAME] has form to edit the User when you are the user </li>

<li>/users/[USERNAME] does not have form to edit the User when you are not the user </li>

<li>/users/[USERNAME] has the usernames of the user's pending follow requests </li>

<li>/users/[USERNAME] has the photos posted by the user </li>

<li>/photos shows photos added by non-private users </li>

<li>/photos has a form element </li>

<li>/photos has a label element with text 'Image' </li>

<li>/photos has a label element with text 'Caption' </li>

<li>/photos has a button element with text 'Add photo' </li>

<li>/photos has a form to add a new Photo if signed in </li>

<li>/photos/[ID] displays the image of the Photo in an <img> element </li>

<li>/photos/[ID] - Delete this photo link displays 'Delete this photo' link when photo belongs to current user </li>

<li>/photos/[ID] displays the caption of the Photo </li>

<li>/photos/[ID] displays the username of the User who added the Photo </li>

<li>/photos/[ID] displays the count of comments for the Photo </li>

<li>/photos/[ID] displays the posted time of the Photo </li>

<li>/photos/[ID] displays all the comments on the photo </li>

<li>/photos/[ID] displays the usernames of the Users who commented on the photo </li>

<li>/photos/[ID] - Delete this photo button displays Delete this photo button when photo belongs to current user </li>

<li>/photos/[ID] - Update photo form displays Update photo form when photo belongs to current user </li>

<li>/photos/[ID] - Like Form automatically populates photo_id and fan_id with current photo and signed in user </li>

<li>/photos/[ID] - Unlike link automatically associates like with signed in user </li>

<li>/photos/[ID] — Add comment form automatically associates comment with signed in user and current photo </li>

<li>The home page has a link to /users </li>

<li>The home page has a link to /photos </li>

<li>The home page has a link to /user_sign_in when no user is signed in </li>

<li>The home page has a link to /user_sign_up when no user is signed in </li>

<li>The home page has a link to /user_sign_out when user is signed in </li>

<li>/edit_user_profile can update the signed in user </li>

<li>The home page has a notice when you sign in successfully </li>

<li>The home page has a notice when you signed out successfully </li>

<li>The home page has a notice when you add a Photo successfully </li>

<li>The home page has a notice when you Like a Photo successfully </li>

<li>The home page has an alert when you Unlike a Photo </li>

<li>The home page has an alert when you try to visit a page you're not allowed to. </li>

<li>User has a class defined in app/models/ </li>

<li>User has an underlying table </li>

<li>Photo has a class defined in app/models/ </li>

<li>Photo has an underlying table </li>

<li>Comment has a class defined in app/models/ </li>

<li>Comment has an underlying table </li>

<li>Like has a class defined in app/models/ </li>

<li>Like has an underlying table </li>

<li>FollowRequest has a class defined in app/models/ </li>

<li>FollowRequest has an underlying table </li>

<li>User has an column called 'username' of type 'string' </li>

<li>User has an column called 'email' of type 'string' </li>

<li>User has an column called 'password_digest' of type 'string' </li>

<li>User has an column called 'comments_count' of type 'integer' </li>

<li>User has an column called 'likes_count' of type 'integer' </li>

<li>User has an column called 'private' of type 'boolean' </li>

<li>Photo has an column called 'caption' of type 'text' </li>

<li>Photo has an column called 'comments_count' of type 'integer' </li>

<li>Photo has an column called 'likes_count' of type 'integer' </li>

<li>Photo has an column called 'owner_id' of type 'integer' </li>

<li>Photo has an column called 'image' of type 'string' </li>

<li>Comment has an column called 'author_id' of type 'integer' </li>

<li>Comment has an column called 'photo_id' of type 'integer' </li>

<li>Comment has an column called 'body' of type 'text' </li>

<li>Like has an column called 'photo_id' of type 'integer' </li>

<li>Like has an column called 'fan_id' of type 'integer' </li>

<li>FollowRequest has an column called 'sender_id' of type 'integer' </li>

<li>FollowRequest has an column called 'recipient_id' of type 'integer' </li>

<li>FollowRequest has an column called 'status' of type 'string' </li>

</details>