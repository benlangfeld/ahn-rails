Given /^a new Rails app$/ do
  Given "I run `rails new rails_app`"
  And "I run `ln -s ../../lib/generators rails_app/lib/generators`"
end
