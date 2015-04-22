When(/^I click the "(.*?)" link$/) do |link_text|
  click_link link_text
end

When(/^fill in the following attributes:$/) do |table|
  table.rows_hash.each do |attr, value|
    fill_in(attr, with: value)
  end
end

When(/^I click the "(.*?)" button$/) do |button_text|
  click_button button_text
end

Then(/^there should be a success notice stating "(.*?)"$/) do |success_message|
  expect(page).to have_selector('.flashes .success', text: success_message)
end

Then(/^I should see the text "(.*?)"$/) do |text|
  expect(page).to have_text(text)
end

