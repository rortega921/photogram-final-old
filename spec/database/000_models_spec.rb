require "rails_helper"
RSpec::Expectations.configuration.on_potential_false_positives = :nothing

describe "User" do
  it "has a class defined in app/models/", points: 0 do
    expect{ User }.to_not raise_error(NameError),
      "Expected a User class to be defined in the app/models/ folder, but didn't find one."
  end
end

describe "User" do
  it "has an underlying table", points: 0 do
    user_migrations_exists = false
   
    if ActiveRecord::Base.connection.table_exists? "users"
      user_migrations_exists = true
    end
    expect(user_migrations_exists).to be(true),
      "Expected there to be a SQL table called 'users', but didn't find one."
  end
end

describe "Photo" do
  it "has a class defined in app/models/", points: 0 do
    expect{ Photo }.to_not raise_error(NameError),
    "Expected a Photo class to be defined in the app/models/ folder, but didn't find one."
  end
end

describe "Photo" do
  it "has an underlying table", points: 0 do
    photo_migrations_exists = false
   
    if ActiveRecord::Base.connection.table_exists? "photos"
      photo_migrations_exists = true
    end
    expect(photo_migrations_exists).to be(true),
      "Expected there to be a SQL table called 'photos', but didn't find one."
  end
end

describe "Comment" do
  it "has a class defined in app/models/", points: 0 do
    expect{ Comment }.to_not raise_error(NameError),
      "Expected a Comment class to be defined in the app/models/ folder, but didn't find one."
  end
end

describe "Comment" do
  it "has an underlying table", points: 0 do
    comment_migrations_exists = false
   
    if ActiveRecord::Base.connection.table_exists? "comments"
      comment_migrations_exists = true
    end
    expect(comment_migrations_exists).to be(true),
      "Expected there to be a SQL table called 'comments', but didn't find one."
  end
end

describe "Like" do
  it "has a class defined in app/models/", points: 0 do
    expect{ Like }.to_not raise_error(NameError),
      "Expected a Like class to be defined in the app/models/ folder, but didn't find one."
  end
end

describe "Like" do
  it "has an underlying table", points: 0 do
    like_migrations_exists = false
   
    if ActiveRecord::Base.connection.table_exists? "likes"
      like_migrations_exists = true
    end
    expect(like_migrations_exists).to be(true),
      "Expected there to be a SQL table called 'likes', but didn't find one."
  end
end

describe "FollowRequest" do
  it "has a class defined in app/models/", points: 0 do
    expect{ FollowRequest }.to_not raise_error(NameError),
      "Expected a FollowRequest class to be defined in the app/models/ folder, but didn't find one."
  end
end

describe "FollowRequest" do
  it "has an underlying table", points: 0 do
    follow_request_migrations_exists = false
   
    if ActiveRecord::Base.connection.table_exists? "follow_requests"
      follow_request_migrations_exists = true
    end
    expect(follow_request_migrations_exists).to be(true),
      "Expected there to be a SQL table called 'follow_requests', but didn't find one."
  end
end
