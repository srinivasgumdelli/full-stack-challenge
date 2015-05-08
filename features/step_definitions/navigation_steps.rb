def create_user
  FactoryGirl.create(:user, {email: 'srinivasgumdelli@gmail.com', password: 'srinivasgumdelli',
                             password_confirmation: 'srinivasgumdelli'})
end

def create_admin
  FactoryGirl.create(:user, {email: 'user@healthify.com', password: 'healthify',
                             password_confirmation: 'healthify', admin: true})
end

def create_eligibility
  FactoryGirl.create(:eligibility, {eligibility: 'Men', description: 'Men Only'})
end

def create_resource_site eligibility
  visit '/resource_sites/new'
  fill_in 'resource_site_name', with: 'Food Pantry'
  fill_in 'resource_site_address', with: '222 Broadway, New York, NY 10038'
  fill_in 'resource_site_description', with: 'A food pantry at the Healthify office.'
  choose eligibility
  click_button 'Save'
end

def sign_in_user
  visit '/users/sign_in'
  fill_in 'user_email', with: 'srinivasgumdelli@gmail.com'
  fill_in 'user_password', with: 'srinivasgumdelli'
  click_button 'Log in'
end

def sign_in_admin
  visit '/users/sign_in'
  fill_in 'user_email', with: 'user@healthify.com'
  fill_in 'user_password', with: 'healthify'
  click_button 'Log in'
end

Given(/^I visit the All Resource Sites page and I am not authenticated$/) do
  ResourceSite.delete_all
  Eligibility.delete_all
  visit resource_sites_path
end

Then(/^I should be redirected to User Signin page$/) do
  expect(current_path).to eq(new_user_session_path)
  expect(page).to have_selector('div', text: 'You need to sign in or sign up before continuing.')
  expect(page).to have_selector('legend', text: 'Login')
end

Then(/^I should be on the New Resource Site page$/) do
  create_user
  sign_in_user
  expect(current_path).to eq(new_resource_site_path)
  expect(page).to have_selector('legend', text: 'New Resource')
end

Then(/^I should be on the All Resource Sites page$/) do
  expect(current_path).to eq(resource_sites_path)
  # expect(page).to have_selector('div', text: 'ELIGIBILITY')
end

Then(/^I should be on the Resource Site Details page for the resource site "(.*?)"$/) do |resource_site_name|
  resource_site = ResourceSite.find_by!(name: resource_site_name)
  expect(current_path).to eq(resource_site_path(resource_site))
  expect(page).to have_selector('legend', text: resource_site_name)
end

Then(/^I should be on the Edit Resource Site page for the resource site "(.*?)"$/) do |resource_site_name|
  resource_site = ResourceSite.find_by!(name: resource_site_name)
  expect(current_path).to eq(edit_resource_site_path(resource_site))
  expect(page).to have_selector('legend', text: "Edit #{resource_site_name}")
end

Then(/^The Resource Site should be created$/) do
  eligibility = create_eligibility
  create_resource_site eligibility.eligibility
end

Given(/^I visit the All Eligibilities page and I am not authenticated$/) do
  ResourceSite.delete_all
  Eligibility.delete_all
  visit eligibilities_path
end

Then(/^I should be on All Eligibilities page as admin$/) do
  create_admin
  sign_in_admin
  expect(current_path).to eq(eligibilities_path)
  expect(page).to have_selector('div', text: '')
end

When(/^I visit Eligibilities admin page$/) do
  visit new_eligibility_path
end

Then(/^I should be redirected to All Resource Sites Page$/) do
  expect(current_path).to eq(root_path)
end

Then(/^I should be New Eligibility page$/) do
  expect(current_path).to eq(new_eligibility_path)
end

Then(/^I should be on the Eligibility Details page for the eligibility "([^"]*)"$/) do |eligibility_name|
  eligibility = Eligibility.find_by!(eligibility: eligibility_name)
  expect(current_path).to eq(eligibility_path(eligibility))
  expect(page).to have_selector('legend', text: eligibility_name)
end

Then(/^I should be on the All Eligibilities page$/) do
  expect(current_path).to eq(eligibilities_path)
end

Then(/^I should be on the Edit Eligibility page for the eligibility "([^"]*)"$/) do |eligibility_name|
  eligibility = Eligibility.find_by!(eligibility: eligibility_name)
  expect(current_path).to eq(edit_eligibility_path(eligibility))
  expect(page).to have_selector('legend', text: "Edit #{eligibility_name}")
end

Then(/^I should be on All Eligibilities page as normal user$/) do
  create_user
  sign_in_user
  expect(current_path).to eq(eligibilities_path)
end