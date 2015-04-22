Given(/^I visit the All Resource Sites page$/) do
  visit resource_sites_path
end

Then(/^I should be on the New Resource Site page$/) do
  expect(current_path).to eq(new_resource_site_path)
  expect(page).to have_selector('h1', text: "New Resource Site")
end

Then(/^I should be on the All Resource Sites page$/) do
  expect(current_path).to eq(resource_sites_path)
  expect(page).to have_selector('h1', text: "All Resource Sites")
end

Then(/^I should be on the Resource Site Details page for the resource site "(.*?)"$/) do |resource_site_name|
  resource_site = ResourceSite.find_by!(name: resource_site_name)
  expect(current_path).to eq(resource_site_path(resource_site))
  expect(page).to have_selector('h1', text: resource_site_name)
end

Then(/^I should be on the Edit Resource Site page for the resource site "(.*?)"$/) do |resource_site_name|
  resource_site = ResourceSite.find_by!(name: resource_site_name)
  expect(current_path).to eq(edit_resource_site_path(resource_site))
  expect(page).to have_selector('h1', text: "Edit #{resource_site_name}")
end
