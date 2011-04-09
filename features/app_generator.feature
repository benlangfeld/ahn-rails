Feature: Adhearsion App Generator
  In order to integrate Adhearsion and Rails
  As a rails developer
  I want to generate an Adhearsion app inside my Rails app

  @announce
  Scenario: Generate railsified application layout
    Given a new Rails app
    When I cd to "rails_app"
    And I run `rails g ahn:app -f`
