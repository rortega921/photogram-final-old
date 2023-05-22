require "rails_helper"

describe "/users" do
  it "can be visited when user is signed out", points: 0 do
    visit "/users"
    current_url = page.current_path

    expect(current_url).to eq("/users")
  end
end

describe "/users" do
  it "lists the usernames of all users", :points => 1 do
    first_user = User.new
    first_user.username = "alice_#{rand(100)}"
    first_user.email = "alice_#{rand(100)}@example.com"
    first_user.private = false
    first_user.password = "password"
    first_user.save

    second_user = User.new
    second_user.username = "bob_#{rand(100)}"
    second_user.email = "bob_#{rand(100)}@example.com"
    second_user.private = false
    second_user.password = "bob_#{rand(100)}"
    second_user.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: first_user.email
      fill_in "Password", with: first_user.password
      # click_on "Sign in"
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users"

    expect(page).to have_content(first_user.username),
      "Expected /users to display #{first_user.username}, but didn't."
    expect(page).to have_content(second_user.username),
      "Expected /users to display #{second_user.username}, but didn't."
  end
end

describe "/users" do
  it "lists the private status of all users (Yes/No)", :points => 1 do
    first_user = User.new
    first_user.username = "alice_#{rand(100)}"
    first_user.email = "alice_#{rand(100)}@example.com"
    first_user.private = false
    first_user.password = "password"
    first_user.save

    second_user = User.new
    second_user.username = "bob_#{rand(100)}"
    second_user.email = "bob_#{rand(100)}@example.com"
    second_user.private = false
    second_user.password = "bob_#{rand(100)}"
    second_user.save

    thrid_user = User.new
    thrid_user.username = "lorren_#{rand(100)}"
    thrid_user.email = "lorren_#{rand(100)}@example.com"
    thrid_user.private = true
    thrid_user.password = "lorren_#{rand(100)}"
    thrid_user.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: first_user.email
      fill_in "Password", with: first_user.password
      # click_on "Sign in"
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users"

    expect(page).to have_text(/Yes/i, :count => 1),
      "Expect page to have text 'Yes' once, but didn't"
    expect(page).to have_text(/No/i, :count => 2),
      "Expect page to have text 'No' twice, but didn't"
    
  end
end

describe "/users" do
  it "has an additional column for follow/unfollow when signed in.", :points => 1 do
    first_user = User.new
    first_user.username = "joemama"
    first_user.email = "joemama@example.com"
    first_user.private = false
    first_user.password = "password"
    first_user.save

    second_user = User.new
    second_user.username = "downwithit"
    second_user.email = "downwithit@example.com"
    second_user.private = false
    second_user.password = "password"
    second_user.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: first_user.email
      fill_in "Password", with: first_user.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users"

    expect(page).to have_tag("button", :text => /Follow/i),
      "Expected page to have a <button> with the text, 'Follow', but didn't find one."

  end
end

describe "/users" do
  it "hides column for follow/unfollow when user is signed out.", :points => 1 do
    first_user = User.new
    first_user.username = "joemama"
    first_user.email = "joemama@example.com"
    first_user.private = false
    first_user.password = "password"
    first_user.save

    visit "/users"

    expect(page).to_not have_tag("button", :text => /Follow/i),
      "Expected page to NOT have a <button> with the text, 'Follow', but found one."
  end
end

describe "/users" do
  it "shows a 'Follow' button next to a user when you haven't sent a follow request", :points => 1 do
    wavy_david = User.new
    wavy_david.username = "wavy_david"
    wavy_david.email = "wavy_david@example.com"
    wavy_david.private = false
    wavy_david.password = "password"
    wavy_david.save

    chum_bucket = User.new
    chum_bucket.username = "chum_bucket"
    chum_bucket.email = "chum_bucket@example.com"
    chum_bucket.private = false
    chum_bucket.password = "password"
    chum_bucket.save
    
    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: wavy_david.email
      fill_in "Password", with: wavy_david.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users"

    expect(page).to have_tag("button", :text => /Follow/i, :count => 2),
      "Expected to find two <button> with the text 'Follow', but didn't find one."
  end
end

describe "/users" do
  it "shows an 'Unfollow' link next to a user when you have sent a follow request and it was accepted", :points => 1 do
    barry_bluejeans = User.new
    barry_bluejeans.username = "barry_bluejeans"
    barry_bluejeans.email = "barry_bluejeans@example.com"
    barry_bluejeans.private = false
    barry_bluejeans.password = "password"
    barry_bluejeans.save

    florence_farmer = User.new
    florence_farmer.username = "florence_farmer"
    florence_farmer.email = "florence_farmer@example.com"
    florence_farmer.private = false
    florence_farmer.password = "password"
    florence_farmer.save
    
    follow = FollowRequest.new
    follow.sender_id = barry_bluejeans.id
    follow.recipient_id = florence_farmer.id
    follow.status = "accepted"
    follow.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: barry_bluejeans.email
      fill_in "Password", with: barry_bluejeans.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users"

    expect(page).to have_tag("a", :text => /Unfollow/i, :count => 1),
      "Expected to find a link with the text 'Unfollow, but didn't find one."
  end
end

describe "/users" do
  it "shows 'Request sent' and 'Cancel' link when you have sent a follow request and it's pending", :points => 1 do
    wavy_david = User.new
    wavy_david.username = "wavy_david"
    wavy_david.email = "wavy_david@example.com"
    wavy_david.private = false
    wavy_david.password = "password"
    wavy_david.save

    chum_bucket = User.new
    chum_bucket.username = "chum_bucket"
    chum_bucket.email = "chum_bucket@example.com"
    chum_bucket.private = false
    chum_bucket.password = "password"
    chum_bucket.save
    
    follow = FollowRequest.new
    follow.sender_id = wavy_david.id
    follow.recipient_id = chum_bucket.id
    follow.status = "pending"
    follow.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: wavy_david.email
      fill_in "Password", with: wavy_david.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users"

    expect(page).to have_text(/Request sent/i),
      "Expected page to have text 'Request sent', but didn't find it."
    expect(page).to have_tag("a", :text => /Cancel/i, :count => 1),
      "Expected page to have one link with the text 'Cancel', but didn't find one."
  end
end

describe "/users" do
  it "shows nothing when you have sent a follow request and it was rejected", :points => 1 do
    camel_suitcase = User.new
    camel_suitcase.username = "camel_suitcase"
    camel_suitcase.email = "camel_suitcase@example.com"
    camel_suitcase.private = false
    camel_suitcase.password = "password"
    camel_suitcase.save

    new_bob = User.new
    new_bob.username = "new_bob"
    new_bob.email = "new_bob@example.com"
    new_bob.private = false
    new_bob.password = "password"
    new_bob.save
    
    follow = FollowRequest.new
    follow.sender_id = camel_suitcase.id
    follow.recipient_id = new_bob.id
    follow.status = "accepted"
    follow.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: camel_suitcase.email
      fill_in "Password", with: camel_suitcase.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users"

    expect(page).to_not have_text(/Request sent/i),
      "Expected page to not have the text 'Request sent', but found it anyway."
  end
end


describe "/users/[USERNAME]/feed" do
  it "has the photos posted by the people the user is following", :points => 3 do
    user = User.new
    user.username = "believe_in_yourself"
    user.email = "believe_in_yourself@example.com"
    user.password = "password"
    user.save

    first_other_user = User.new
    first_other_user.username = "the_girl_reading_this_is_beautiful"
    first_other_user.email = "the_girl_reading_this_is_beautiful@example.com"
    first_other_user.password = "the_boy_reading_this_is_beautiful"
    first_other_user.save

    first_other_user_first_photo = Photo.new
    first_other_user_first_photo.owner_id = first_other_user.id
    first_other_user_first_photo.caption = "Some caption z"
    first_other_user_first_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    first_other_user_first_photo.save

    first_other_user_second_photo = Photo.new
    first_other_user_second_photo.owner_id = first_other_user.id
    first_other_user_second_photo.caption = "Some caption y"
    first_other_user_second_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    first_other_user_second_photo.save

    second_other_user = User.new
    second_other_user.username = "who_is_bernie_mac"
    second_other_user.email = "who_is_bernie_mac@example.com"
    second_other_user.password = "thenbpersionisbeautiful"
    second_other_user.save

    second_other_user_first_photo = Photo.new
    second_other_user_first_photo.owner_id = second_other_user.id
    second_other_user_first_photo.caption = "Some caption a"
    second_other_user_first_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    second_other_user_first_photo.save
    
    second_other_user_second_photo = Photo.new
    second_other_user_second_photo.owner_id = second_other_user.id
    second_other_user_second_photo.caption = "Some caption b"
    second_other_user_second_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    second_other_user_second_photo.save

    third_other_user = User.new
    third_other_user.username = "jeporday"
    third_other_user.email = "jeporday@example.com"
    third_other_user.password = "jeporday"
    third_other_user.save

    third_other_user_first_photo = Photo.new
    third_other_user_first_photo.owner_id = third_other_user.id
    third_other_user_first_photo.caption = "Some caption c"
    third_other_user_first_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    third_other_user_first_photo.save

    third_other_user_second_photo = Photo.new
    third_other_user_second_photo.owner_id = third_other_user.id
    third_other_user_second_photo.caption = "Some caption d"
    third_other_user_second_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    third_other_user_second_photo.save

    fourth_other_user = User.new
    fourth_other_user.username = "nocat"
    fourth_other_user.email = "nocat@example.com"
    fourth_other_user.password = "nocat"
    fourth_other_user.save

    fourth_other_user_first_photo = Photo.new
    fourth_other_user_first_photo.owner_id = fourth_other_user.id
    fourth_other_user_first_photo.caption = "Some caption e"
    fourth_other_user_first_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    fourth_other_user_first_photo.save

    fourth_other_user_second_photo = Photo.new
    fourth_other_user_second_photo.owner_id = fourth_other_user.id
    fourth_other_user_second_photo.caption = "Some caption f"
    fourth_other_user_second_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    fourth_other_user_second_photo.save

    first_follow_request = FollowRequest.new
    first_follow_request.sender_id = user.id
    first_follow_request.recipient_id = first_other_user.id
    first_follow_request.status = "rejected"
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.sender_id = user.id
    second_follow_request.recipient_id = second_other_user.id
    second_follow_request.status = "accepted"
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.sender_id = user.id
    third_follow_request.recipient_id = third_other_user.id
    third_follow_request.status = "pending"
    third_follow_request.save

    fourth_follow_request = FollowRequest.new
    fourth_follow_request.sender_id = user.id
    fourth_follow_request.recipient_id = fourth_other_user.id
    fourth_follow_request.status = "accepted"
    fourth_follow_request.save

    visit "/user_sign_in"
    
    
    within(:css, "form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users/#{user.username}/feed"

    expect(page).to have_content(second_other_user_first_photo.caption),
      "Expected page to have text '#{second_other_user_first_photo.caption}', but didn't find it."
    expect(page).to have_content(second_other_user_second_photo.caption),
      "Expected page to have text '#{second_other_user_second_photo.caption}', but didn't find it."
    expect(page).to have_content(fourth_other_user_first_photo.caption),
      "Expected page to have text '#{fourth_other_user_first_photo.caption}', but didn't find it."
    expect(page).to have_content(fourth_other_user_second_photo.caption),
      "Expected page to have text '#{fourth_other_user_second_photo.caption}', but didn't find it."
      
    expect(page).to have_no_content(first_other_user_first_photo.caption),
      "Expected page to not have text '#{first_other_user_first_photo.caption}', but did find it."
    expect(page).to have_no_content(third_other_user_first_photo.caption),
      "Expected page to not have text '#{third_other_user_first_photo.caption}', but did find it."
  end
end

describe "/users/[USERNAME]/liked_photos" do
  it "has the photos the user has liked", :points => 0 do
    user = User.new
    user.username = "you_can_do_this"
    user.email = "you_can_do_this@example.com"
    user.password = "password"
    user.save

    other_user = User.new
    other_user.username = "camel_case"
    other_user.email = "camel_case@example.com"
    other_user.password = "camel_case"
    other_user.save

    first_photo = Photo.new
    first_photo.owner_id = other_user.id
    first_photo.caption = "First caption"
    first_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    first_photo.save

    second_photo = Photo.new
    second_photo.owner_id = user.id
    second_photo.caption = "Second caption"
    second_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    second_photo.save

    third_photo = Photo.new
    third_photo.owner_id = other_user.id
    third_photo.caption = "Third caption"
    third_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    third_photo.save

    first_like = Like.new
    first_like.photo_id = first_photo.id
    first_like.fan_id = user.id
    first_like.save

    second_like = Like.new
    second_like.photo_id = second_photo.id
    second_like.fan_id = other_user.id
    second_like.save

    third_like = Like.new
    third_like.photo_id = third_photo.id
    third_like.fan_id = user.id
    third_like.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users/#{user.username}/liked_photos"

    expect(page).to have_content(first_photo.caption),
      "Expect page to have text '#{first_photo.caption}', but didn't"
    expect(page).to have_content(third_photo.caption),
      "Expect page to have text '#{third_photo.caption}', but didn't"
    expect(page).to have_no_content(second_photo.caption),
      "Expect page to not have text '#{second_photo.caption}', but did."
  end
end

describe "/users/[USERNAME]/discover" do
  it "has the photos that are liked by the people the user is following", :points => 0 do
    user = User.new
    user.username = "jelani_is_the_best_ta"
    user.email = "jelani_is_the_best_ta@example.com"
    user.password = "password"
    user.save
    
    first_other_user = User.new
    first_other_user.username = "patrick_is_a_good_ta"
    first_other_user.email = "patrick_is_a_good_ta@example.com"
    first_other_user.password = "patrick_is_a_good_ta"
    first_other_user.save
    
    second_other_user = User.new
    second_other_user.username = "logan_is_a_ta"
    second_other_user.email = "logan_is_a_ta@example.com"
    second_other_user.password = "logan_is_a_ta"
    second_other_user.save
    
    third_other_user = User.new
    third_other_user.username = "give_me_free_cookies"
    third_other_user.email = "give_me_free_cookies@example.com"
    third_other_user.password = "give_me_free_cookies"
    third_other_user.save
    
    fourth_other_user = User.new
    fourth_other_user.username = "jelani_is_still_the_best_ta"
    fourth_other_user.email = "jelani_is_still_the_best_ta@example.com"
    fourth_other_user.password = "jelani_is_still_the_best_ta"
    fourth_other_user.save

    first_other_user_first_liked_photo = Photo.new
    first_other_user_first_liked_photo.owner_id = fourth_other_user.id
    first_other_user_first_liked_photo.caption = "Some caption #{1}"
    first_other_user_first_liked_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    first_other_user_first_liked_photo.save

    first_other_user_first_like = Like.new
    first_other_user_first_like.fan_id = first_other_user.id
    first_other_user_first_like.photo_id = first_other_user_first_liked_photo.id
    first_other_user_first_like.save

    first_other_user_second_liked_photo = Photo.new
    first_other_user_second_liked_photo.owner_id = fourth_other_user.id
    first_other_user_second_liked_photo.caption = "Some caption 2"
    first_other_user_second_liked_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    first_other_user_second_liked_photo.save

    first_other_user_first_like = Like.new
    first_other_user_first_like.fan_id = first_other_user.id
    first_other_user_first_like.photo_id = first_other_user_second_liked_photo.id
    first_other_user_first_like.save

    second_other_user_first_liked_photo = Photo.new
    second_other_user_first_liked_photo.owner_id = fourth_other_user.id
    second_other_user_first_liked_photo.caption = "Some caption 3"
    second_other_user_first_liked_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    second_other_user_first_liked_photo.save

    second_other_user_first_like = Like.new
    second_other_user_first_like.fan_id = second_other_user.id
    second_other_user_first_like.photo_id = second_other_user_first_liked_photo.id
    second_other_user_first_like.save

    second_other_user_second_liked_photo = Photo.new
    second_other_user_second_liked_photo.owner_id = fourth_other_user.id
    second_other_user_second_liked_photo.caption = "Some caption 4"
    second_other_user_second_liked_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    second_other_user_second_liked_photo.save

    second_other_user_first_like = Like.new
    second_other_user_first_like.fan_id = second_other_user.id
    second_other_user_first_like.photo_id = second_other_user_second_liked_photo.id
    second_other_user_first_like.save

    third_other_user_first_liked_photo = Photo.new
    third_other_user_first_liked_photo.owner_id = fourth_other_user.id
    third_other_user_first_liked_photo.caption = "Some caption 5"
    third_other_user_first_liked_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    third_other_user_first_liked_photo.save

    third_other_user_first_like = Like.new
    third_other_user_first_like.fan_id = third_other_user.id
    third_other_user_first_like.photo_id = third_other_user_first_liked_photo.id
    third_other_user_first_like.save

    third_other_user_second_liked_photo = Photo.new
    third_other_user_second_liked_photo.owner_id = fourth_other_user.id
    third_other_user_second_liked_photo.caption = "Some caption 6"
    third_other_user_second_liked_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    third_other_user_second_liked_photo.save

    third_other_user_first_like = Like.new
    third_other_user_first_like.fan_id = third_other_user.id
    third_other_user_first_like.photo_id = third_other_user_second_liked_photo.id
    third_other_user_first_like.save

    fourth_other_user_first_liked_photo = Photo.new
    fourth_other_user_first_liked_photo.owner_id = fourth_other_user.id
    fourth_other_user_first_liked_photo.caption = "Some caption 7"
    fourth_other_user_first_liked_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    fourth_other_user_first_liked_photo.save

    fourth_other_user_first_like = Like.new
    fourth_other_user_first_like.fan_id = fourth_other_user.id
    fourth_other_user_first_like.photo_id = fourth_other_user_first_liked_photo.id
    fourth_other_user_first_like.save

    fourth_other_user_second_liked_photo = Photo.new
    fourth_other_user_second_liked_photo.owner_id = fourth_other_user.id
    fourth_other_user_second_liked_photo.caption = "Some caption 8"
    fourth_other_user_second_liked_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    fourth_other_user_second_liked_photo.save

    fourth_other_user_first_like = Like.new
    fourth_other_user_first_like.fan_id = fourth_other_user.id
    fourth_other_user_first_like.photo_id = fourth_other_user_second_liked_photo.id
    fourth_other_user_first_like.save

    first_follow_request = FollowRequest.new
    first_follow_request.sender_id = user.id
    first_follow_request.recipient_id = first_other_user.id
    first_follow_request.status = "rejected"
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.sender_id = user.id
    second_follow_request.recipient_id = second_other_user.id
    second_follow_request.status = "accepted"
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.sender_id = user.id
    third_follow_request.recipient_id = third_other_user.id
    third_follow_request.status = "pending"
    third_follow_request.save

    fourth_follow_request = FollowRequest.new
    fourth_follow_request.sender_id = user.id
    fourth_follow_request.recipient_id = fourth_other_user.id
    fourth_follow_request.status = "accepted"
    fourth_follow_request.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users/#{user.username}/discover"

    expect(page).to have_content(second_other_user_first_liked_photo.caption),
      "Expect page to have text '#{second_other_user_first_liked_photo.caption}', but didn't"
    expect(page).to have_content(second_other_user_second_liked_photo.caption),
      "Expect page to have text '#{second_other_user_second_liked_photo.caption}', but didn't"
    expect(page).to have_content(fourth_other_user_first_liked_photo.caption),
      "Expect page to have text '#{fourth_other_user_first_liked_photo.caption}', but didn't"
    expect(page).to have_content(fourth_other_user_second_liked_photo.caption),
      "Expect page to have text '#{fourth_other_user_second_liked_photo.caption}', but didn't"

    expect(page).to have_no_content(first_other_user_first_liked_photo.caption),
      "Expect page to have text '#{first_other_user_first_liked_photo}', but didn't"
    expect(page).to have_no_content(third_other_user_first_liked_photo.caption),
      "Expect page to have text '#{third_other_user_first_liked_photo}', but didn't"
  end
end
