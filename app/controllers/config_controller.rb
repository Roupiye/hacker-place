class ConfigController < ApplicationController
  def index
    render Config::IndexView.new()
  end
end
