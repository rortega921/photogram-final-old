require "rails_helper"


describe "/users/[USERNAME]" do
  it "redirects to sign in page when user is signed out", points: 0 do
    user = User.new
    user.password = "password"
    user.username = "user"
    user.email = "user@example.com"
    user.save

    visit "/users/#{user.username}"
    current_url = page.current_path

    expect(current_url).to eq("/user_sign_in")
  end
end

describe "/users/[USERNAME]" do
  it "has a link with the text of the username of the signed in user", :points => 1 do
    user = User.new
    user.username = "alice_#{rand(100)}"
    user.email = "alice_#{rand(100)}@example.com"
    user.password = "password"
    user.save
    
    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users/#{user.username}"

    expect(page).to have_content(user.username),
      "Expect page to have text '#{user.username}', but didn't"
  end
end


describe "/users/[USERNAME]" do
  it "displays the value of the private column for the related User record", :points => 1 do
    user = User.new
    user.username = "alice_#{rand(100)}"
    user.email = "alice_#{rand(100)}@example.com"
    user.password = "password"
    user.private = false
    user.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users/#{user.username}"

    expect(page).to have_text(/false/i, :count => 1),
      "Expect page to have text 'false' one time, but didn't"

  end
end

describe "/users/[USERNAME]" do
  it "displays the follower count for the related User record", :points => 1 do
    user = User.new
    user.username = "battle_maniac"
    user.email = "battle_maniac@example.com"
    user.password = "password"
    user.private = false
    user.save

    kevin_camera = User.new
    kevin_camera.username = "kevin_camera"
    kevin_camera.email = "kevin_camera@example.com"
    kevin_camera.password = "password"
    kevin_camera.private = false
    kevin_camera.save
    
    esuna_g = User.new
    esuna_g.username = "esuna_gummi"
    esuna_g.email = "esuna_gummi@example.com"
    esuna_g.password = "password"
    esuna_g.private = false
    esuna_g.save
    
    user_follows_kevin = FollowRequest.new
    user_follows_kevin.sender_id = user.id
    user_follows_kevin.recipient_id = kevin_camera.id
    user_follows_kevin.status = "accepted"
    user_follows_kevin.save
    
    esuna_follows_kevin = FollowRequest.new
    esuna_follows_kevin.sender_id = esuna_g.id
    esuna_follows_kevin.recipient_id = kevin_camera.id
    esuna_follows_kevin.status = "accepted"
    esuna_follows_kevin.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users/#{kevin_camera.username}"

    expect(page).to have_text(/2/, :count => 1),
      "Expect page to have text '2' one time, but didn't"

  end
end

describe "/users/[USERNAME]" do
  it "displays the number of users that the User is following", :points => 1 do
    user = User.new
    user.username = "battle_maniac"
    user.email = "battle_maniac_#{rand(100)}@example.com"
    user.password = "password"
    user.private = false
    user.save

    kevin_camera = User.new
    kevin_camera.username = "kevin_camera_#{rand(100)}"
    kevin_camera.email = "kevin_camera_#{rand(100)}@example.com"
    kevin_camera.password = "password"
    kevin_camera.private = false
    kevin_camera.save
    
    esuna_g = User.new
    esuna_g.username = "esuna_gummi#{rand(100)}"
    esuna_g.email = "esuna_gummi#{rand(100)}@example.com"
    esuna_g.password = "password"
    esuna_g.private = false
    esuna_g.save
    
    user_follows_kevin = FollowRequest.new
    user_follows_kevin.sender_id = user.id
    user_follows_kevin.recipient_id = kevin_camera.id
    user_follows_kevin.status = "accepted"
    user_follows_kevin.save
    
    esuna_follows_kevin = FollowRequest.new
    esuna_follows_kevin.sender_id = user.id
    esuna_follows_kevin.recipient_id = esuna_g.id
    esuna_follows_kevin.status = "accepted"
    esuna_follows_kevin.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users/#{user.username}"

    expect(page).to have_text(/2/, :count => 1),
      "Expect page to have text '2' one time, but didn't"
  end
end

describe "/users/[USERNAME]" do
  it "displays the number of Photos that the related User has added", :points => 1 do
    dave_strider = User.new
    dave_strider.password = "password"
    dave_strider.username = "dave_strider"
    dave_strider.email = "dave_strider@example.com"
    dave_strider.save

    photo = Photo.new
    photo.image = File.open Rails.root + "spec/support/kirb.gif"
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = dave_strider.id
    photo.save

    ironic_selfie = Photo.new
    ironic_selfie.image = File.open Rails.root + "spec/support/kirb.gif"
    ironic_selfie.caption = "I told you about the Stairs"
    ironic_selfie.owner_id = dave_strider.id
    ironic_selfie.save

    austin_photo = Photo.new
    austin_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    austin_photo.caption = "I live in texas"
    austin_photo.owner_id = dave_strider.id
    austin_photo.save

    image_count = Photo.where({ :owner_id => dave_strider.id }).count

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: dave_strider.email
      fill_in "Password", with: dave_strider.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{dave_strider.username}"

    expect(page).to have_text("(#{image_count})", :count => 1),
      "Expect page to have text '(#{image_count})', but didn't"
  end
end

describe "/users/[USERNAME]" do
  it "displays each of the  Photos that the related User has added in <img> tags", :points => 1, hint: h("real_image_uploads") do
    john_egbert = User.new
    john_egbert.password = "password"
    john_egbert.username = "john_egbert"
    john_egbert.email = "john_egbert@example.com"
    john_egbert.save

    photo = Photo.new
    photo.image = File.open Rails.root + "spec/support/kirb.gif"
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = john_egbert.id
    photo.save

    ironic_selfie = Photo.new
    ironic_selfie.image = File.open Rails.root + "spec/support/kirb.gif"
    ironic_selfie.caption = "stack modus"
    ironic_selfie.owner_id = john_egbert.id
    ironic_selfie.save

    austin_photo = Photo.new
    austin_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    austin_photo.caption = "April 14th"
    austin_photo.owner_id = john_egbert.id
    austin_photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: john_egbert.email
      fill_in "Password", with: john_egbert.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{john_egbert.username}"

    expect(page).to have_tag("img[src*='#{photo.image_identifier}']"),
    "Expect page to have <img> with a 'src' attribute containing '#{photo.image_identifier}', but didn't"
    expect(page).to have_tag("img[src*='#{ironic_selfie.image_identifier}']"),
    "Expect page to have <img> with a 'src' attribute containing '#{ironic_selfie.image_identifier}', but didn't"
    expect(page).to have_tag("img[src*='#{austin_photo.image_identifier}']"),
      "Expect page to have <img> with a 'src' attribute containing '#{austin_photo.image_identifier}', but didn't"
  end
end

describe "/users/[USERNAME]" do
  it "has a link to the details page for each of the Photos that the related User has added", :points => 1 do
    john_egbert = User.new
    john_egbert.password = "password"
    john_egbert.username = "john_egbert"
    john_egbert.email = "john_egbert@example.com"
    john_egbert.save

    photo = Photo.new
    photo.image = File.open Rails.root + "spec/support/kirb.gif"
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = john_egbert.id
    photo.save

    ironic_selfie = Photo.new
    ironic_selfie.image = File.open Rails.root + "spec/support/kirb.gif"
    ironic_selfie.caption = "stack modus"
    ironic_selfie.owner_id = john_egbert.id
    ironic_selfie.save

    austin_photo = Photo.new
    austin_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    austin_photo.caption = "April 14th"
    austin_photo.owner_id = john_egbert.id
    austin_photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: john_egbert.email
      fill_in "Password", with: john_egbert.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{john_egbert.username}"

    expect(page).to have_tag("a", :text => /Show details/i, :with => { :href => "/photos/#{photo.id}" }),
      "Expect page to have an <a> tag with the text 'Show details' and an 'href' of '/photos/#{photo.id}'', but didn't"
    expect(page).to have_tag("a", :text => /Show details/i, :with => { :href => "/photos/#{ironic_selfie.id}" }),
      "Expect page to have an <a> tag with the text 'Show details' and an 'href' of '/photos/#{ironic_selfie.id}'', but didn't"
    expect(page).to have_tag("a", :text => /Show details/i, :with => { :href => "/photos/#{austin_photo.id}" }),
      "Expect page to have an <a> tag with the text 'Show details' and an 'href' of '/photos/#{austin_photo.id}'', but didn't"
  end
end

describe "/users/[USERNAME]" do
  it "displays the caption for each of the Photos that the related User has added", :points => 1 do
    carmen_sandiego = User.new
    carmen_sandiego.password = "password"
    carmen_sandiego.username = "carmen_sandiego"
    carmen_sandiego.email = "carmen_sandiego@example.com"
    carmen_sandiego.save

    photo = Photo.new
    photo.image = File.open Rails.root + "spec/support/kirb.gif"
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = carmen_sandiego.id
    photo.save

    dinner_photo = Photo.new
    dinner_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    dinner_photo.caption = "Jules"
    dinner_photo.owner_id = carmen_sandiego.id
    dinner_photo.save

    group_photo = Photo.new
    group_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    group_photo.caption = "Stealing stuff"
    group_photo.owner_id = carmen_sandiego.id
    group_photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: carmen_sandiego.email
      fill_in "Password", with: carmen_sandiego.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{carmen_sandiego.username}"

    expect(page).to have_text(photo.caption),
      "Expect page to have text '#{photo.caption}', but didn't"
    expect(page).to have_text(dinner_photo.caption),
      "Expect page to have text '#{dinner_photo.caption}', but didn't"
    expect(page).to have_text(group_photo.caption)
      "Expect page to have text '#{group_photo.caption}', but didn't"
  end
end

describe "/users/[USERNAME]" do
  it "displays the likes count for each of the Photos that the related User has added", :points => 1 do
    drew_mc = User.new
    drew_mc.password = "password"
    drew_mc.username = "drew_mc"
    drew_mc.email = "drew_mc@example.com"
    drew_mc.save

    larry = User.new
    larry.password = "password"
    larry.username = "larry"
    larry.email = "larry@example.com"
    larry.save

    photo = Photo.new
    photo.image = File.open Rails.root + "spec/support/kirb.gif"
    photo.caption = "Some test caption"
    photo.owner_id = drew_mc.id
    photo.likes_count = 0
    photo.comments_count = 0
    photo.save
    
    like = Like.new
    like.fan_id = drew_mc.id
    like.photo_id = photo.id
    like.save
    
    other_like = Like.new
    other_like.fan_id = larry.id
    other_like.photo_id = photo.id
    other_like.save
    
    photo.likes_count = 2
    photo.save
    
    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: drew_mc.email
      fill_in "Password", with: drew_mc.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{drew_mc.username}"

    expect(page).to have_text(/2/),
      "Expect page to have text '2', but didn't find it."
  end
end

describe "/users/[USERNAME]" do
  it "displays the posted time for each of the Photos that the related User has added", :points => 1 do
    famous_bacon = User.new
    famous_bacon.password = "password"
    famous_bacon.username = "famous_bacon"
    famous_bacon.email = "famous_bacon@example.com"
    famous_bacon.save

    photo = Photo.new
    photo.image = File.open Rails.root + "spec/support/kirb.gif"
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = famous_bacon.id
    photo.created_at = 31.minutes.ago
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: famous_bacon.email
      fill_in "Password", with: famous_bacon.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{famous_bacon.username}"
    
    expect(page).to have_text(/31 minutes ago/i),
      "Expected page to have text '31 minutes ago', but didn't find it."
  end
end

describe "/users/[USERNAME]" do
  it "has a link to the User's feed", :points => 0 do
    drew_mc = User.new
    drew_mc.password = "password"
    drew_mc.username = "drew_mc"
    drew_mc.email = "drew_mc@example.com"
    drew_mc.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: drew_mc.email
      fill_in "Password", with: drew_mc.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{drew_mc.username}"

    expect(page).to have_tag("a", :with => { :href => "/users/#{drew_mc.username}/feed" }, :text => /Feed/i ),
      "Expect page to have <a> with text 'Feed' and an href of '/users/#{drew_mc}/feed', but didn't find it."
    
  end
end


describe "/users/[USERNAME]" do
  it "has a link to the User's liked photos", :points => 0 do
    drew_mc = User.new
    drew_mc.password = "password"
    drew_mc.username = "drew_mc"
    drew_mc.email = "drew_mc@example.com"
    drew_mc.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: drew_mc.email
      fill_in "Password", with: drew_mc.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{drew_mc.username}"

    expect(page).to have_tag("a", :with => { :href => "/users/#{drew_mc.username}/liked_photos"}, :text => /Liked photos/i),
      "Expect page to have <a> with text 'Liked photos' and an href of '/users/#{drew_mc}/liked_photos', but didn't find it."
    
  end
end

describe "/users/[USERNAME]" do
  it "has a link to the User's discover", :points => 0 do
    drew_mc = User.new
    drew_mc.password = "password"
    drew_mc.username = "drew_mc"
    drew_mc.email = "drew_mc@example.com"
    drew_mc.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: drew_mc.email
      fill_in "Password", with: drew_mc.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{drew_mc.username}"

    expect(page).to have_tag("a", :with => { :href => "/users/#{drew_mc.username}/discover" }, :text => /Discover/i),
      "Expect page to have <a> with text 'Discover' and an href of '/users/#{drew_mc}/discover', but didn't find it."
    
  end
end

describe "/users/[USERNAME]" do
  it "has a 'Follow' button when the details page does not belong to the current user", :points => 1 do
    drew_mc = User.new
    drew_mc.password = "password"
    drew_mc.username = "drew_mc"
    drew_mc.email = "drew_mc@example.com"
    drew_mc.save

    dylan_baker = User.new
    dylan_baker.password = "password"
    dylan_baker.username = "dylan_baker"
    dylan_baker.email = "dylan_baker@example.com"
    dylan_baker.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: drew_mc.email
      fill_in "Password", with: drew_mc.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{dylan_baker.username}"

    expect(page).to have_tag("button", :text => /Follow/i),
      "Expect page to have <button> with text 'Follow', but didn't find it."
    
  end
end

describe "/users/[USERNAME]" do
  it "has a 'Unfollow' link when the details page does not belong to the current user and the user is following", :points => 1 do
    drew_mc = User.new
    drew_mc.password = "password"
    drew_mc.username = "drew_mc"
    drew_mc.email = "drew_mc@example.com"
    drew_mc.save
    
    dylan_baker = User.new
    dylan_baker.password = "password"
    dylan_baker.username = "dylan_baker"
    dylan_baker.email = "dylan_baker@example.com"
    dylan_baker.save

    drew_follows_dylan = FollowRequest.new
    drew_follows_dylan.sender_id = drew_mc.id
    drew_follows_dylan.recipient_id = dylan_baker.id
    drew_follows_dylan.status = "accepted"
    drew_follows_dylan.save
    
    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: drew_mc.email
      fill_in "Password", with: drew_mc.password
      
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users/#{dylan_baker.username}"
    
    expect(page).to have_tag("a", :text => /Unfollow/i),
      "Expect page to have <a> with text 'Unfollow', but didn't find it."
  end
end

describe "/users/[USERNAME]" do
  it "has form to edit the User when you are the user", :points => 1 do
    drew_mc = User.new
    drew_mc.password = "password"
    drew_mc.username = "drew_mc"
    drew_mc.private = false
    drew_mc.email = "drew_mc@example.com"
    drew_mc.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: drew_mc.email
      fill_in "Password", with: drew_mc.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{drew_mc.username}"

    expect(page).to have_tag("button", :text => /Update user/i),
      "Expect page to have <button> with text 'Update user', but didn't find it."
    
    expect(page).to have_tag("input", :with => { :value => drew_mc.username }),
      "Expect page to have <input> with a value '#{drew_mc.username}', but didn't find it."
  
  end
end

describe "/users/[USERNAME]" do
  it "does not have form to edit the User when you are not the user", :points => 1 do
    drew_mc = User.new
    drew_mc.password = "password"
    drew_mc.username = "drew_mc"
    drew_mc.private = false
    drew_mc.email = "drew_mc@example.com"
    drew_mc.save

    joemama = User.new
    joemama.password = "password"
    joemama.username = "joemama"
    joemama.private = false
    joemama.email = "joemama@example.com"
    joemama.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: drew_mc.email
      fill_in "Password", with: drew_mc.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/users/#{joemama.username}"

    expect(page).to_not have_tag("button", :text => /Update user/i),
      "Expect page to have <button> with text 'Update user', but didn't find it."
    
    expect(page).to_not have_tag("input", :with => { :value => joemama.username } ),
      "Expect page to not have <input> with value '#{joemama.username}', but found one."
  
  end
end

describe "/users/[USERNAME]" do
  it "has the usernames of the user's pending follow requests", :points => 1 do
    user = User.new
    user.username = "alice_#{rand(100)}"
    user.email = "alice_#{rand(100)}@example.com"
    user.password = "password"
    user.save

    alice = User.new
    alice.username = "ALICE #{rand(99)}"
    alice.email = "ALICE #{rand(99)}@example.com"
    alice.password = "password"
    alice.save 

    bob = User.new
    bob.username = "bob #{rand(99)}"
    bob.email = "bob #{rand(99)}@example.com"
    bob.password = "password"
    bob.save

    carol = User.new
    carol.username = "carol #{rand(99)}"
    carol.email = "carol #{rand(99)}@example.com"
    carol.password = "password"
    carol.save

    alice_fr = FollowRequest.new
    alice_fr.sender_id = alice.id
    alice_fr.recipient_id = user.id
    alice_fr.status = "pending"
    alice_fr.save
    
    bob_fr = FollowRequest.new
    bob_fr.sender_id = bob.id
    bob_fr.recipient_id = user.id
    bob_fr.status = "pending"
    bob_fr.save
    
    carol_fr = FollowRequest.new
    carol_fr.sender_id = carol.id
    carol_fr.recipient_id = user.id
    carol_fr.status = "accepted"
    carol_fr.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users/#{user.username}"

    expect(page).to have_content(alice.username),
      "Expect page to have text '#{alice.username}', but didn't find it."
    expect(page).to have_content(bob.username),
      "Expect page to have text '#{bob.username}', but didn't find it."
    expect(page).to_not have_content(carol.username),
      "Expect page to not have text '#{carol.username}', but did find it."
  end
end

describe "/users/[USERNAME]" do
  it "has the photos posted by the user", :points => 1 do
    user = User.new
    user.username = "paul_bunyun"
    user.email = "paul_bunyun@example.com"
    user.password = "password"
    user.save

    other_user = User.new
    other_user.username = "codnot"
    other_user.email = "codnot@example.com"
    other_user.password = "password"
    other_user.save

    first_photo = Photo.new
    first_photo.owner_id = user.id
    first_photo.caption = "First caption #{rand(100)}"
    first_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    first_photo.save

    second_photo = Photo.new
    second_photo.owner_id = other_user.id
    second_photo.caption = "Second caption #{rand(100)}"
    second_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    second_photo.save

    third_photo = Photo.new
    third_photo.owner_id = user.id
    third_photo.caption = "Third caption #{rand(100)}"
    third_photo.image = File.open Rails.root + "spec/support/kirb.gif"
    third_photo.save

    visit "/user_sign_in"
    
    
    within(:css, "form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/users/#{user.username}"

    expect(page).to have_content(first_photo.caption),
      "Expect page to have text '#{first_photo.caption}', but didn't find it."
    expect(page).to have_content(third_photo.caption),
      "Expect page to have text '#{third_photo.caption}', but didn't find it."
    expect(page).to have_no_content(second_photo.caption),
      "Expect page to not have text '#{second_photo.caption}', but found it."
  end
end
