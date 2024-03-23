# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groups', type: :system do
  describe 'creating a new group' do
    context 'with valid input' do
      it 'creates the group' do
        visit root_path
        click_link 'New group'
        expect(page).to have_current_path(new_group_path)

        expect do
          fill_in 'イベントのハッシュタグ', with: 'rubykaigi'
          fill_in '2次会グループ名', with: 'みんなで飲みましょう!!'
          fill_in '募集内容', with: '誰でも参加OK!!'
          fill_in '定員', with: 10
          fill_in '会場', with: '未定'
          fill_in '会計方法', with: '割り勘'
          click_button '登録する'

          expect(page).to have_content '2次会グループが作成されました'
          expect(page).to have_content 'rubykaigi'
          expect(page).to have_current_path(group_path(Group.last))
        end.to change(Group, :count).by(1)
      end
    end

    context 'with invalid input' do
      it 'displays an error message' do
        visit root_path
        click_link 'New group'
        expect(page).to have_current_path(new_group_path)

        fill_in 'イベントのハッシュタグ', with: ''
        fill_in '2次会グループ名', with: 'みんなで飲みましょう!!'
        fill_in '募集内容', with: '誰でも参加OK!!'
        fill_in '定員', with: 10
        fill_in '会場', with: '未定'
        fill_in '会計方法', with: '割り勘'
        click_button '登録する'

        expect(page).to have_content '2次会グループに1個のエラーが発生しました'
        expect(page).to have_content 'イベントのハッシュタグを入力してください'
        expect(page).to have_current_path(new_group_path)
      end
    end
  end

  describe 'updating a group' do
    let(:group) { FactoryBot.create(:group) }

    context 'with valid input' do
      it 'updates the group' do
        visit group_path(group)
        click_link 'Edit this group'
        expect(page).to have_current_path(edit_group_path(group))

        fill_in '会場', with: 'とある居酒屋'
        click_button '更新する'

        expect(page).to have_content '2次会グループが更新されました'
        expect(page).to have_content 'とある居酒屋'
        expect(page).to have_current_path(group_path(group))
      end
    end

    context 'with invalid input' do
      it 'displays an error message' do
        visit group_path(group)
        click_link 'Edit this group'
        expect(page).to have_current_path(edit_group_path(group))

        fill_in '会場', with: ''
        click_button '更新する'

        expect(page).to have_content '2次会グループに1個のエラーが発生しました'
        expect(page).to have_content '会場を入力してください'
        expect(page).to have_current_path(edit_group_path(group))
      end
    end
  end
end
