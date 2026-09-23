require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  test "visit root and wait" do
    player = create(:player)
    sign_in_as(player)

    visit root_path

    click_on "Applications"
    click_on "ide"

    code = <<~EOS
      v = input("owo")
      print("lol" .. v)
      for i = 0, #params do
        print(params[i])
      end
    EOS

    sleep 1
    find('.view-lines').click
    send_keys([:control, 'a'])
    Clipboard.copy(code)
    send_keys([:control, 'v'])
    find('#code_params').click
    send_keys('myparams')
    click_on "run"
    sleep 2
    find("##{LgoProcess.last.pid}-run-stdin-input").send_keys("uwu")
    click_on "send input"

    assert_text "loluwu"
    assert_text "myparams"
  end
end
