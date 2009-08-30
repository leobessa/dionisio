Feature: Make Reviews
  In order to expose my opinions about products
  As an user
  I want make reviews
                     
  Scenario: 
    Given the following user records
    | username | password |
    | rato     | rato     |
    And the following product records
    | name |
    | wii  | 
    And I am logged in as "rato" with password "rato"
    When I go to "wii" product page
    And I follow "Make a review"  
    And I fill in "review_rating" with "5" 
    And I fill in "review_summary" with "Revolutionary controller design offers unique motion-sensitive gameplay options"
    And I fill in "review_description" with "It lacks the graphical prowess and rich media features of the Xbox 360 and the PS3, but the Nintendo Wii's combination of unique motion-sensitive controllers and emphasis on fun gameplay make the ultra-affordable console hard to resist."
    And I press "Create"
    Then I should see "Review was successfully created." 
    And I should see "rato"
    And I should see "5.0 out of 5"
    And I should see "Revolutionary controller design offers unique motion-sensitive"
    When I follow "Show"
    Then I should see "It lacks the graphical prowess and rich media features of the Xbox 360 and the PS3, but the Nintendo Wii's combination of unique motion-sensitive controllers and emphasis on fun gameplay make the ultra-affordable console hard to resist."
    And I should see "5.0 out of 5"
    And I should see "Revolutionary controller design offers unique motion-sensitive gameplay options"
  
  
  
  

