require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  test "visit root and wait" do
    player = create(:player)
    sign_in_as(player)

    visit root_path

    click_on "Applications"
    click_on "ide"

    sleep 1
    find('.view-lines').click
    send_keys([:control, 'a'])
    Clipboard.copy("print(\"uwu\")")
    send_keys([:control, 'v'])
    click_on "run"

    assert_text "uwu"
  end
end
