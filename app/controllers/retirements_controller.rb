# frozen_string_literal: true

class RetirementsController < ApplicationController
  def create
    return unless current_user.destroy

    reset_session
    redirect_to root_path, notice: 'アカウントが削除されました'
  end
end
