# Strategy 


This testing plan explains how our team makes sure the app TakeThat! works well. We use both unit tests and UI tests to check if everything runs properly.
We use tools like


- flutter_test for writing tests
- mockito to fake Firebase
- coverage to see how much code we tested

For UI tests, we test the design and layout. We check that:

- Buttons and text fields show up
- Pages look right and respond to taps
- The user can move between screens smoothly


For unit tests, we test key features like:

- Sign up (success,..)
- Login (correct and wrong password)
- Forget password (success and error)
- user_posts_page
- story_page
- user_home_page

We Wrote enough tests to hit 80 percent coverage and mostly focused on UI since not enough functionality is implemented to test. 

