Given(/^I am on the homepage$/) do
  visit "/"
end

When(/^I sign in with "(.*?)"$/) do |provider|
  click_link "Sign in with Twitter" if provider == "Twitter"
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end