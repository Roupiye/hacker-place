require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  test "visit root and wait" do
    player = create(:player)
    sign_in_as(player)

    visit root_path

    debugger

    assert_selector "#content" # Waits up to 10 seconds
    assert_text "Welcome"
  end
end
