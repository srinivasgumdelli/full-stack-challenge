Healthify Fullstack Engineer Coding Challenge
=============================================

## Background
One of Healthify's main products is a platform from which
a social worker may search for resource sites – homeless shelters, food pantries,
substance abuse clinics – for their patients. In this coding challenge, we've built
a minimal version of that platform; the app currently provides a (nonsearchable)
listing of resource sites as well as a few pages to provide CRUD functionality.

The resource sites do not serve all segments of the population; some are only for women,
some only for men, some only for children, some only for HIV positive persons, etc.
We would like our app to reflect this eligibility property of resource sites.

## Assignment
Your assignment comes in a few parts:

1. Implement functionality to permit filtering our list of resource sites by eligibilities.
We want to have a bank of eligibilities, for example `{'Men', 'Women', 'Children', 'Abuse Survivors', 'Cancer' }`, and on the page listing our resource sites, we want to be able to check off eligibilities and then filter (perhaps by clicking a 'Filter' button) the resource sites so that they're limited
to only those resource sites that offer services for the checked eligibilities. So if
we check off 'Children' and 'Abuse Survivors' and then filter, we want to only see resource
sites that offer services for 'Children', 'Abuse Survivors', or both.

2. Write tests to add coverage for the functionality implemented for the above. If
you're a TDD or BDD practitioner, then this step may come before or during the
prior step. If you're needing inspiration you can take a look at the Rspec and Cucumber tests we've
already written (the spec/ and features/ subdirectories) , but also feel free to take this in your own direction.
Importantly, your final submission should pass all unit and integration tests.

3. Develop a minimally stylized front end for the page listing the resource sites. You
can see the screenshot left in the Github comments for one inspiration, but feel free
to style this as you please. *One requirement for the frontend:* we want to remove the
'Filter' button from this page; instead, we want the page to automatically update
the list of resource sites when the user checks/unchecks an eligibility checkbox.

4. Deploy (A free Heroku instance is 100% acceptable).

## Other Things To Consider
1. `git` history: A consistent and accurate git history greatly aids in the code review process - which is core to Healthify's technical workflow.

2. Clarity & Documentation: Your code should be expressive and understandable. Solid unit tests usually provide enough documentation, but aren't always sufficient. Whether via unit tests, comments, exceptionally expressive code or all of the above, make sure you submit easy to understand code!



## Bonus
If you do all the above, pat yourself on the back – you've done well and that's all we need!
However, if you want to go the extra mile to show off your skills, feel free to implement some of the below features.
To repeat -- we don't expect candidates to spend more than a day working on this assignment or to implement any bonus features.
This is strictly optional.

1. A map for the list of resource sites. Our resource sites all have addresses. It would be nice to display this information
in a map on the resource sites index page. Add an integration with a geocoding API (e.g. Google Maps, SmartyStreetz) and display the resource sites as points on a map.

2. Business hours. It could be very valuable to know which of these resource sites are actually open right now (and whether
they'd be open on some hypothetical future date). Implement functionality to store a set of business hours on resource
sites such that we can query for resource sites open right now or at some other predetermined time.

3. Search by text. Right now we can filter by eligibility, but it would be nice to also be able to search by text queries.
Add functionality to permit searching or filtering by text queries on the resource sites index page.

4. Sorting resource sites on the client side. Implement functionality to permit sorting our list of resource
sites by (a) alphabetical order, and (b) the last `updated_at` date (you should be able to toggle sorting by ascending or
descending order for either of these). Ensure that re-sorting does not require a page reload (i.e. implement the
sorting logic on the client side).

5. Your own idea! If you have a particular talent, can spot something that would be a killer feature for this
app, or even if there were parts of the current codebase that you think should be refactored, feel free to
show off your stuff with your own new feature or refactoring of the current codebase.
