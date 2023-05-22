require "rails_helper"

describe "/user_sign_in" do
  it "has a label element with text 'Email' that is connected to an input element", points: 0, hint: h("label_for_input copy_must_match") do

    visit "/user_sign_in"
  
    email_label = find("label", :text => /Email/)
    for_attribute = email_label[:for]

    if for_attribute.empty?
      expect(for_attribute).to_not be_empty,
        "Expected label's for attribute to be set to a non empty value, was '#{for_attribute}' instead."
    else
      all_inputs = all("input")
  
      all_input_ids = all_inputs.map { |input| input[:id] }
  
      expect(all_input_ids.count(for_attribute)).to eq(1),
        "Expected label's for attribute(#{for_attribute}) to match only 1 of the ids of an <input> tag (#{all_input_ids}), but found 0 or more than 1."
    end
  end
end

describe "/user_sign_in" do
  it "has a label element with text 'Password' that is connected to an input element", points: 0, hint: h("label_for_input copy_must_match") do

    visit "/user_sign_in"
  
    password_label = find("label", :text => /Password/)
    for_attribute = password_label[:for]

    if for_attribute.empty?
      expect(for_attribute).to_not be_empty,
        "Expected label's for attribute to be set to a non empty value, was '#{for_attribute}' instead."
    else
      all_inputs = all("input")
  
      all_input_ids = all_inputs.map { |input| input[:id] }
  
      expect(all_input_ids.count(for_attribute)).to eq(1),
        "Expected label's for attribute(#{for_attribute}) to match only 1 of the ids of an <input> tag (#{all_input_ids}), but found 0 or more than 1."
    end
  end
end

describe "/user_sign_in" do
  it "has a button with the text 'Sign in'", points: 0, hint: h("copy_must_match button_type")do

    visit "/user_sign_in"
  
    expect(page).to have_css("button", :text => /Sign in/)
  end
end
