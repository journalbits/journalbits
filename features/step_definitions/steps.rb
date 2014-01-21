Given(/^I am on the homepage$/) do
  visit "/"
end

When(/^I sign in with "(.*?)"$/) do |provider|
  click_link "Sign in with Twitter" if provider == "Twitter"
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end

When(/^I fill in "(.*?)" with "(.*?)" and click "(.*?)"$/) do |field, value, button|
  fill_in field, with: value
  click_button button
end

Given(/^I have signed up already signed up with "(.*?)"$/) do |provider|
  click_link "Sign in with Twitter" if provider == "Twitter"
  fill_in "Email", with: "test@tester.com"
  click_button "Sign up"
  click_link "Logout"
end

When(/^I click to sign in with "(.*?)"$/) do |provider|
  click_link "Sign in with Twitter" if provider == "Twitter"
end