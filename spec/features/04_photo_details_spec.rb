require "rails_helper"

describe "/photos/[ID]" do
  it "redirects to sign in page when user is signed out", points: 0 do
    drew_mc = User.new
    drew_mc.password = "password"
    drew_mc.username = "drew_mc"
    drew_mc.email = "drew_mc@example.com"
    drew_mc.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = drew_mc.id
    photo.save

    visit "/photos/#{photo.id}"
    current_url = page.current_path

    expect(current_url).to eq("/user_sign_in")
  end
end

describe "/photos/[ID]" do
  it "displays the image of the Photo in an <img> element", points: 1, hint: h("real_image_uploads") do
    drew_mc = User.new
    drew_mc.password = "password"
    drew_mc.username = "drew_mc"
    drew_mc.email = "drew_mc@example.com"
    drew_mc.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = drew_mc.id
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: drew_mc.email
      fill_in "Password", with: drew_mc.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/photos/#{photo.id}"

    expect(page).to have_tag("img[src*='#{photo.image_identifier}']"),
      "Expected page to have an <img> tag with a 'src' attribute of #{photo.image_identifier}, but didn't find one."

  end
end

describe "/photos/[ID] - Delete this photo link" do
  it "displays 'Delete this photo' link when photo belongs to current user", points: 2 do
    first_user = User.new
    first_user.password = "password"
    first_user.username = "alice"
    first_user.email = "alice@example.com"
    first_user.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = first_user.id
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: first_user.email
      fill_in "Password", with: first_user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/photos/#{photo.id}"

    expect(page).to have_content(first_user.username),
      "Expected page to have text '#{first_user.username}, but didn't find it."

    expect(page).to have_tag("a", :text => /Delete this photo/i),
      "Expected page to have a link with the text 'Delete this photo', but didn't find one."
  end
end


describe "/photos/[ID]" do
  it "displays the caption of the Photo", points: 1 do
    nancy_drew = User.new
    nancy_drew.password = "password"
    nancy_drew.username = "nancy_drew"
    nancy_drew.email = "nancy_drew@example.com"
    nancy_drew.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = nancy_drew.id
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: nancy_drew.email
      fill_in "Password", with: nancy_drew.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/photos/#{photo.id}"

    expect(page).to have_text(photo.caption),
      "Expected page to have text #{photo.caption}, but didn't find it."
  end
end

describe "/photos/[ID]" do
  it "displays the username of the User who added the Photo", points: 1 do
    phil_lamar = User.new
    phil_lamar.password = "password"
    phil_lamar.username = "phil_lamar"
    phil_lamar.email = "phil_lamar@example.com"
    phil_lamar.save

    cameron_diaz = User.new
    cameron_diaz.password = "password"
    cameron_diaz.username = "cameron_diaz"
    cameron_diaz.email = "cameron_diaz@example.com"
    cameron_diaz.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = cameron_diaz.id
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: phil_lamar.email
      fill_in "Password", with: phil_lamar.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/photos/#{photo.id}"

    expect(page).to have_text(cameron_diaz.username),
      "Expected page to have text #{cameron_diaz.username}, but didn't find it."
  end
end

describe "/photos/[ID]" do
  it "displays the count of comments for the Photo", points: 1 do
    famous_bacon = User.new
    famous_bacon.password = "password"
    famous_bacon.username = "famous_bacon"
    famous_bacon.email = "famous_bacon@example.com"
    famous_bacon.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.likes_count = 0
    photo.comments_count = 0
    photo.owner_id = famous_bacon.id
    photo.save

    comment = Comment.new
    comment.author_id = famous_bacon.id
    comment.photo_id = photo.id
    comment.body = "Nice photo"
    comment.save

    second_comment = Comment.new
    second_comment.author_id = famous_bacon.id
    second_comment.photo_id = photo.id
    second_comment.body = "Buy my stock"
    second_comment.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: famous_bacon.email
      fill_in "Password", with: famous_bacon.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/photos/#{photo.id}"

    comments_count = Comment.where({:photo_id => photo.id}).count
    expect(page).to have_text(comments_count),
      "Expected page to have text #{comments_count}, but didn't find it."
  end
end

describe "/photos/[ID]" do
  it "displays the posted time of the Photo", points: 1 do
    famous_bacon = User.new
    famous_bacon.password = "password"
    famous_bacon.username = "famous_bacon"
    famous_bacon.email = "famous_bacon@example.com"
    famous_bacon.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = famous_bacon.id
    photo.created_at = 50.minutes.ago
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: famous_bacon.email
      fill_in "Password", with: famous_bacon.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/photos/#{photo.id}"

    expect(page).to have_text(/about 1 hour ago/i),
      "Expected page to have text 'about 1 hour ago', but didn't find it."
  end
end

describe "/photos/[ID]" do
  it "displays all the comments on the photo", points: 1 do
    user = User.new
    user.username = "bagel_muncher"
    user.email = "bagel_muncher@example.com"
    user.password = "password"
    user.private = false
    user.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.save

    other_photo = Photo.new
    other_photo.owner_id = user.id
    other_photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    other_photo.save

    first_commenter = User.new
    first_commenter.username = "first_mate"
    first_commenter.email = "first_mate@example.com"
    first_commenter.password = "password"
    first_commenter.private = false
    first_commenter.save

    first_comment = Comment.new
    first_comment.author_id = first_commenter.id
    first_comment.photo_id = photo.id
    first_comment.body = "First some comment #{rand(100)}"
    first_comment.save

    second_commenter = User.new
    second_commenter.username = "commmenter2"
    second_commenter.email = "commmenter2@example.com"
    second_commenter.password = "password"
    second_commenter.private = false
    second_commenter.save

    second_comment = Comment.new
    second_comment.author_id = second_commenter.id
    second_comment.photo_id = photo.id
    second_comment.body = "Second some comment #{rand(100)}"
    second_comment.save

    third_comment = Comment.new
    third_comment.author_id = second_commenter.id
    third_comment.photo_id = other_photo.id
    third_comment.body = "This Comment should not be displayed"
    third_comment.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/photos/#{photo.id}"

    expect(page).to have_text(first_comment.body),
      "Expected to find #{first_comment.body}, but didn't"
    expect(page).to have_text(second_comment.body),
      "Expected to find #{second_comment.body}, but didn't"
    expect(page).to_not have_text(third_comment.body),
      "Expected to not find #{third_comment.body}, but did"
  end
end

describe "/photos/[ID]" do
  it "displays the usernames of the Users who commented on the photo", points: 1 do
    user = User.new
    user.username = "strong_bad"
    user.email = "strong_bad@sbemail.net"
    user.password = "password"
    user.private = false
    user.save

    ignore_me = User.new
    ignore_me.username = "hacker_on_main"
    ignore_me.email = "hacker@hack.net"
    ignore_me.password = "password"
    ignore_me.private = false
    ignore_me.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.save

    first_commenter = User.new
    first_commenter.username = "bob_#{rand(100)}"
    first_commenter.email = "bob@example.com"
    first_commenter.password = "password"
    first_commenter.private = false
    first_commenter.save

    first_comment = Comment.new
    first_comment.author_id = first_commenter.id
    first_comment.body = "Love this photo!"
    first_comment.photo_id = photo.id
    first_comment.save

    second_commenter = User.new
    second_commenter.username = "carol_#{rand(100)}"
    second_commenter.email = "carold@example.com"
    second_commenter.password = "password"
    second_commenter.private = false
    second_commenter.save

    second_comment = Comment.new
    second_comment.author_id = second_commenter.id
    second_comment.photo_id = photo.id
    second_comment.body = "Hate this photo!"
    second_comment.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      
      find("button", :text => /Sign in/i ).click
    end

    visit "/photos/#{photo.id}"

    expect(page).to have_text(first_commenter.username),
      "Expected page to have text #{first_commenter.username}, but didn't find it."
    expect(page).to have_text(second_commenter.username),
      "Expected page to have text #{second_commenter.username}, but didn't find it."
    expect(page).to_not have_text(ignore_me.username),
      "Expected page to not have text #{ignore_me.username}, but found it anyway."
  end
end

describe "/photos/[ID] - Delete this photo button" do
  it "displays Delete this photo button when photo belongs to current user", points: 1 do
    first_user = User.new
    first_user.password = "password"
    first_user.username = "alice"
    first_user.email = "alice@example.com"
    first_user.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = first_user.id
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: first_user.email
      fill_in "Password", with: first_user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/photos/#{photo.id}"

    expect(page).to have_content(first_user.username),
      "Expected page to display #{first_user.username}, but didn't find it."    
      
    expect(page).to have_tag("a", :text => /Delete this photo/i),
      "Expected page to have link with text 'Delete this photo', but didn't find it."    
  end
end

describe "/photos/[ID] - Update photo form" do
  it "displays Update photo form when photo belongs to current user", points: 1 do
    first_user = User.new
    first_user.password = "password"
    first_user.username = "alice"
    first_user.email = "alice@example.com"
    first_user.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = first_user.id
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: first_user.email
      fill_in "Password", with: first_user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/photos/#{photo.id}"

    expect(page).to have_tag("button", :text => /Update photo/i),
      "Expected page to have a <button> with the text, 'Update photo', but didn't find one."
  end
end

describe "/photos/[ID] - Like Form" do
  it "automatically populates photo_id and fan_id with current photo and signed in user", points: 1 do
    first_user = User.new
    first_user.password = "password"
    first_user.username = "alice"
    first_user.email = "alice@example.com"
    first_user.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = first_user.id
    photo.likes_count = 0
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: first_user.email
      fill_in "Password", with: first_user.password
      find("button", :text => /Sign in/i ).click
    end
    
    old_likes_count = photo.likes_count

    visit "/photos/#{photo.id}"
    
    find("button", :text => /Like/i ).click
    likes_count = Like.where({ :photo_id => photo.id }).count
    expect(likes_count).to be >= (old_likes_count + 1),
      "Expected clicking the 'Like' button to add a record to the Likes table, but it didn't."
  end
end

describe "/photos/[ID] - Unlike link" do
  it "automatically associates like with signed in user", points: 1 do
    first_user = User.new
    first_user.password = "password"
    first_user.username = "alice"
    first_user.email = "alice@example.com"
    first_user.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = first_user.id
    photo.likes_count = 1
    photo.save

    like = Like.new
    like.fan_id = first_user.id
    like.photo_id = photo.id
    like.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: first_user.email
      fill_in "Password", with: first_user.password
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/photos/#{photo.id}"
    old_likes_count = photo.likes_count

    # Should only display "Unlike" when the signed in user has liked the photo
    find("a", :text => /Unlike/i ).click
    likes_count = Like.where({ :photo_id => photo.id }).count
    expect(likes_count).to eql(old_likes_count - 1),
      "Expected clicking the 'Unlike' link to remove a record to the Likes table, but it didn't."
  end
end

describe "/photos/[ID] — Add comment form" do
  it "automatically associates comment with signed in user and current photo", points: 1 do
    first_user = User.new
    first_user.password = "password"
    first_user.username = "alice"
    first_user.email = "alice@example.com"
    first_user.likes_count = 0
    first_user.comments_count = 0
    first_user.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = first_user.id
    photo.likes_count = 0
    photo.comments_count = 0
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: first_user.email
      fill_in "Password", with: first_user.password
      find("button", :text => /Sign in/i ).click
    end

    test_comment = "Hey, what a nice app you're building!"

    visit "/photos/#{photo.id}"

    fill_in "Comment", with: test_comment

    # click_on "Add comment"
    find("button", :text => /Add comment/i ).click

    added_comment = Comment.where({ :author_id => first_user.id, :photo_id => photo.id, :body => test_comment }).at(0)

    expect(added_comment).to_not be_nil,
      "Expected clicking the 'Add comment' button to add a record to the Comment table, but it didn't."
  end
end
