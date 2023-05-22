require "rails_helper"

describe "User" do
  it "has an column called 'username' of type 'string'", points: 0 do
    new_user = User.new
    expect(new_user.attributes).to include("username"),
      "Expected to have a column called 'username', but didn't find one."
    expect(User.column_for_attribute('username').type).to be(:string),
      "Expected column to be of type 'string' but wasn't."
  end
end

describe "User" do
  it "has an column called 'email' of type 'string'", points: 0 do
    new_user = User.new
    expect(new_user.attributes).to include("email"),
      "Expected to have a column called 'email', but didn't find one."
    expect(User.column_for_attribute('email').type).to be(:string),
      "Expected column to be of type 'string' but wasn't."
  end
end

describe "User" do
  it "has an column called 'password_digest' of type 'string'", points: 0 do
    new_user = User.new
    expect(new_user.attributes).to include("password_digest"),
      "Expected to have a column called 'password_digest', but didn't find one."
    expect(User.column_for_attribute('password_digest').type).to be(:string),
      "Expected column to be of type 'string' but wasn't."
  end
end

describe "User" do
  it "has an column called 'comments_count' of type 'integer'", points: 0 do
    new_user = User.new
    expect(new_user.attributes).to include("comments_count"),
      "Expected to have a column called 'comments_count', but didn't find one."
    expect(User.column_for_attribute('comments_count').type).to be(:integer),
      "Expected column to be of type 'integer' but wasn't."
  end
end

describe "User" do
  it "has an column called 'likes_count' of type 'integer'", points: 0 do
    new_user = User.new
    expect(new_user.attributes).to include("likes_count"),
      "Expected to have a column called 'likes_count', but didn't find one."
    expect(User.column_for_attribute('likes_count').type).to be(:integer),
      "Expected column to be of type 'integer' but wasn't."
  end
end

describe "User" do
  it "has an column called 'private' of type 'boolean'", points: 0 do
    new_user = User.new
    expect(new_user.attributes).to include("private"),
      "Expected to have a column called 'private', but didn't find one."
    expect(User.column_for_attribute('private').type).to be(:boolean),
      "Expected column to be of type 'boolean' but wasn't."
  end
end

describe "Photo" do
  it "has an column called 'caption' of type 'text'", points: 0 do
    new_photo = Photo.new
    expect(new_photo.attributes).to include("caption"),
      "Expected to have a column called 'caption', but didn't find one."
    expect(Photo.column_for_attribute('caption').type).to be(:text),
      "Expected column to be of type 'text' but wasn't."
  end
end

describe "Photo" do
  it "has an column called 'comments_count' of type 'integer'", points: 0 do
    new_photo = Photo.new
    expect(new_photo.attributes).to include("comments_count"),
      "Expected to have a column called 'comments_count', but didn't find one."
    expect(Photo.column_for_attribute('comments_count').type).to be(:integer),
      "Expected column to be of type 'integer' but wasn't."
  end
end

describe "Photo" do
  it "has an column called 'likes_count' of type 'integer'", points: 0 do
    new_photo = Photo.new
    expect(new_photo.attributes).to include("likes_count"),
      "Expected to have a column called 'likes_count', but didn't find one."
    expect(Photo.column_for_attribute('likes_count').type).to be(:integer),
      "Expected column to be of type 'integer' but wasn't."
  end
end

describe "Photo" do
  it "has an column called 'owner_id' of type 'integer'", points: 0 do
    new_photo = Photo.new
    expect(new_photo.attributes).to include("owner_id"),
      "Expected to have a column called 'owner_id', but didn't find one."
    expect(Photo.column_for_attribute('owner_id').type).to be(:integer),
      "Expected column to be of type 'integer' but wasn't."
  end
end

describe "Photo" do
  it "has an column called 'image' of type 'string'", points: 0 do
    new_photo = Photo.new
    expect(new_photo.attributes).to include("image"),
      "Expected to have a column called 'image', but didn't find one."
    expect(Photo.column_for_attribute('image').type).to be(:string),
      "Expected column to be of type 'string' but wasn't."
  end
end


describe "Comment" do
  it "has an column called 'author_id' of type 'integer'", points: 0 do
    new_comment = Comment.new
    expect(new_comment.attributes).to include("author_id"),
      "Expected to have a column called 'author_id', but didn't find one."
    expect(Comment.column_for_attribute('author_id').type).to be(:integer),
      "Expected column to be of type 'string' but wasn't."
  end
end

describe "Comment" do
  it "has an column called 'photo_id' of type 'integer'", points: 0 do
    new_comment = Comment.new
    expect(new_comment.attributes).to include("photo_id"),
      "Expected to have a column called 'photo_id', but didn't find one."
    expect(Comment.column_for_attribute('photo_id').type).to be(:integer),
      "Expected column to be of type 'integer' but wasn't."
  end
end

describe "Comment" do
  it "has an column called 'body' of type 'text'", points: 0 do
    new_comment = Comment.new
    expect(new_comment.attributes).to include("body"),
      "Expected to have a column called 'body', but didn't find one."
    expect(Comment.column_for_attribute('body').type).to be(:text),
      "Expected column to be of type 'text' but wasn't."
  end
end

describe "Like" do
  it "has an column called 'photo_id' of type 'integer'", points: 0 do
    new_like = Like.new
    expect(new_like.attributes).to include("photo_id"),
      "Expected to have a column called 'photo_id', but didn't find one."
    expect(Like.column_for_attribute('photo_id').type).to be(:integer),
      "Expected column to be of type 'integer' but wasn't."
  end
end

describe "Like" do
  it "has an column called 'fan_id' of type 'integer'", points: 0 do
    new_like = Like.new
    expect(new_like.attributes).to include("fan_id"),
      "Expected to have a column called 'fan_id', but didn't find one."
    expect(Like.column_for_attribute('fan_id').type).to be(:integer),
      "Expected column to be of type 'integer' but wasn't."
  end
end

describe "FollowRequest" do
  it "has an column called 'sender_id' of type 'integer'", points: 0 do
    new_follow_request = FollowRequest.new
    expect(new_follow_request.attributes).to include("sender_id"),
      "Expected to have a column called 'sender_id', but didn't find one."
    expect(FollowRequest.column_for_attribute('sender_id').type).to be(:integer),
      "Expected column to be of type 'integer' but wasn't."
  end
end

describe "FollowRequest" do
  it "has an column called 'recipient_id' of type 'integer'", points: 0 do
    new_follow_request = FollowRequest.new
    expect(new_follow_request.attributes).to include("recipient_id"),
      "Expected to have a column called 'recipient_id', but didn't find one."
    expect(FollowRequest.column_for_attribute('recipient_id').type).to be(:integer),
      "Expected column to be of type 'integer' but wasn't."
  end
end

describe "FollowRequest" do
  it "has an column called 'status' of type 'string'", points: 0 do
    new_follow_request = FollowRequest.new
    expect(new_follow_request.attributes).to include("status"),
      "Expected to have a column called 'status', but didn't find one."
    expect(FollowRequest.column_for_attribute('status').type).to be(:string),
      "Expected column to be of type 'string' but wasn't."
  end
end

