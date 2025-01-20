# frozen_string_literal: true

class ConsoleReflex < ApplicationReflex
  def exec
    command = params[:command]
    puts command
    debugger
    morph :nothing
  end
end
