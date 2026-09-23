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
    Clipboard.copy("v = input(\"owo\")\nprint(\"lol\" .. v)")
    Clipboard.copy("v = input(\"owo\")\nprint(\"lol\" .. v)")
    send_keys([:control, 'v'])
    click_on "run"
    sleep 2
    find("##{LgoProcess.last.pid}-run-stdin-input").send_keys("uwu")
    click_on "send input"

    assert_text "loluwu"
  end
end
