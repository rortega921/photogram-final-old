require "rails_helper"

describe "/photos" do
  it "can be visited when user is signed out", points: 0 do
    visit "/photos"
    current_url = page.current_path

    expect(current_url).to eq("/photos")
  end
end

describe "/photos" do
  it "shows photos added by non-private users", :points => 1, hint: h("real_image_uploads") do
    
    aj_mickayla = User.new
    aj_mickayla.password = "password"
    aj_mickayla.username = "aj_mickayla"
    aj_mickayla.private = false
    aj_mickayla.email = "aj_mickayla@example.com"
    aj_mickayla.save

    anonymous = User.new
    anonymous.password = "password"
    anonymous.username = "anonymous"
    anonymous.private = true
    anonymous.email = "anonymous@example.com"
    anonymous.save

    ajs_photo = Photo.new
    ajs_photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    ajs_photo.caption = "Some test caption #{Time.now.to_i}"
    ajs_photo.owner_id = aj_mickayla.id
    ajs_photo.save

    anon_photo = Photo.new
    anon_photo.image = File.open(Rails.root + "spec/support/red.png")
    anon_photo.caption = "another test caption #{Time.now.to_i}"
    anon_photo.owner_id = anonymous.id
    anon_photo.save

    visit "/photos"

    # expect(page).to have_tag("img", :with => { :src => ajs_photo.image }),
    expect(page).to have_tag("img[src*='#{ajs_photo.image_identifier}']"),
    "Expect page to have an <img> with a src attribute of '#{ajs_photo.image_identifier}', but didn't find it."
    expect(page).to_not have_tag("img[src*='#{anon_photo.image_identifier}']"),
    # expect(page).to_not have_tag("img", :with => { :src => anon_photo.image }),
      "Expect page to NOT have an <img> with a src attribute of '#{anon_photo.image_identifier}', but found it."

  end
end


describe "/photos" do
  it "has a form element", :points => 1 do

    busdriver = User.new
    busdriver.password = "password"
    busdriver.username = "busdriver"
    busdriver.email = "busdriver@example.com"
    busdriver.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = busdriver.id
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: busdriver.email
      fill_in "Password", with: busdriver.password
      
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/photos"

    expect(page).to have_tag("form", :count => 1),
      "Expect page to have one <form>, but didn't find it."
  end
end

describe "/photos" do
  it "has a label element with text 'Image'", :points => 1 do

    busdriver = User.new
    busdriver.password = "password"
    busdriver.username = "busdriver"
    busdriver.email = "busdriver@example.com"
    busdriver.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = busdriver.id
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: busdriver.email
      fill_in "Password", with: busdriver.password
      
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/photos"

 
    expect(page).to have_tag("label", :text => /Image/, :count => 1),
      "Expect page to have a <label> with the text 'Image', but didn't find it."

  end
end

describe "/photos" do
  it "has a label element with text 'Caption'", :points => 1 do

    busdriver = User.new
    busdriver.password = "password"
    busdriver.username = "busdriver"
    busdriver.email = "busdriver@example.com"
    busdriver.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = busdriver.id
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: busdriver.email
      fill_in "Password", with: busdriver.password
      
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/photos"

 
    expect(page).to have_tag("label", :text => /Caption/, :count => 1),
      "Expect page to have a <label> with the text 'Caption', but didn't find it."

  end
end

describe "/photos" do
  it "has a button element with text 'Add photo'", :points => 1 do

    busdriver = User.new
    busdriver.password = "password"
    busdriver.username = "busdriver"
    busdriver.email = "busdriver@example.com"
    busdriver.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = busdriver.id
    photo.save

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: busdriver.email
      fill_in "Password", with: busdriver.password
      
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/photos"

    expect(page).to have_tag("button", :text => /Add photo/i, :count => 1),
      "Expect page to have <button> with the text 'Add photo', but didn't find it."

  end
end


describe "/photos" do
  it "has a form to add a new Photo if signed in", :points => 1, hint: h("real_image_uploads") do

    busdriver = User.new
    busdriver.password = "password"
    busdriver.username = "busdriver"
    busdriver.email = "busdriver@example.com"
    busdriver.save

    photo = Photo.new
    photo.image = File.open(Rails.root + "spec/support/kirb.gif")
    photo.caption = "Some test caption #{Time.now.to_i}"
    photo.owner_id = busdriver.id
    photo.save

    old_photo_count = Photo.all.count

    visit "/user_sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: busdriver.email
      fill_in "Password", with: busdriver.password
      
      find("button", :text => /Sign in/i ).click
    end
    
    visit "/photos"
    
    within(:css, "form") do
      attach_file "Image", "#{Rails.root}/spec/support/kirb.gif"
      fill_in "Caption", with: "Real time fan dubs"

      find("button", :text => /Add photo/i ).click
    end

    new_photo_count = Photo.all.count

    expect(old_photo_count).to be < new_photo_count

  end
end
