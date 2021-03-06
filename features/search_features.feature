Feature: Search features
  In order to have fast access to features and scenarios
  As a stakeholder
  I want to be able to search features

  Scenario Outline: Search feature name
    Given a feature file named "sample.feature" with the contents:
    """
    @QA
    Feature: Sample Feature
    """
    And I am on the search page
    When I search for "<query>"
    Then I should see a search result link to "<feature name>" with the url "<url>"

    Examples:
      | query        | feature name   | url                      |
      | Sample       | Sample Feature |/projects/project/features/sample-feature  |
      | sAmPlE       | Sample Feature |/projects/project/features/sample-feature  |
      | @QA          | Sample Feature |/projects/project/features/sample-feature  |

  Scenario: Search feature narrative
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
      In order to bla bla bla
      As donkey
      I want ermm I dunno.
    """
    And I am on the search page
    When I search for "donkey"
    Then I should see a search result link to "Sample Feature" with the url "/projects/project/features/sample-feature"

  Scenario: Search scenario name
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
    Scenario: Sample Scenario
    """
    And I am on the search page
    When I search for "Sample Scenario"
    Then I should see a search result link to "Sample Scenario" with the url "/projects/project/features/sample-feature/scenario/sample-scenario"

  Scenario: Search scenario steps
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Sample Feature
    Scenario: Sample Scenario
      Given I do something
    """
    And I am on the search page
    When I search for "I do something"
    Then I should see a search result link to "Sample Scenario" with the url "/projects/project/features/sample-feature/scenario/sample-scenario"

  Scenario: Search suggests other searches
    Given a feature file named "sample.feature" with the contents:
    """
    Feature: Batman
    """
    And I am on the search page
    When I search for "btman"
    Then I should see "Did you mean"
    And I should see a search result link to "Batman" with the url "/projects/project/search?q=Batman"

  Scenario: Search displays tags
    Given a feature file named "sample.feature" with the contents:
    """
    @feature_tag
    Feature: Batman

    @scenario_tag
    Scenario: Batman?
    """
    And I am on the search page
    When I search for "Batman"
    Then I should see "feature_tag" in the search results
    And I should see "scenario_tag" in the search results

  Scenario: Higlighted search result
    Given a feature file named "sample.feature" with the contents:
    """
    @feature_tag
    Feature: Some <long WORD feature word name
    Scenario: Some <long WORD scenario word name
    """
    And I am on the search page
    When I search for "word"
    Then I should see the html:
    """
    Some &lt;long <span class="search-result">WORD</span> feature <span class="search-result">word</span> name
    """
    And I should see the html:
    """
    Some &lt;long <span class="search-result">WORD</span> scenario <span class="search-result">word</span> name
    """
