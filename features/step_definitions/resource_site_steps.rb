Then(/^the resource sites list should include exactly the following resource sites:$/) do |table|
  expected_resource_sites = table.hashes
  actual_resource_sites = find('.resource-sites-list')
    .all('.resource-site-cell').map do |cell|
      {
        'name' => cell.find('.resource-site-name').text,
        'address' => cell.find('.resource-site-address').text
      }
    end

  expect(actual_resource_sites).to eq(expected_resource_sites)
end

Then(/^the resource sites list should be empty$/) do
  expect(find('.resource-sites-list')).to_not have_selector('.resource-site-cell')
end

And(/^the eligibilities list should include exactly the following eligibilities:$/) do |table|
  expected_eligibilites = table.hashes
  actual_eligibilities = find('.eligibilities-list')
  .all('.eligibility-cell').map do |cell|
    {
        'eligibility' => cell.find('.eligibility-name').text,
        'description' => cell.find('.eligibility-description').text
    }
  end
  expect(actual_eligibilities).to eq(expected_eligibilites)
end

