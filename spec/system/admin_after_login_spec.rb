require 'rails_helper'

describe 'After login as an admin', type: :system do
  let(:admin) { create(:admin) }
  let!(:admin_event) { create(:admin_event, end: DateTime.now) }
  let!(:post) { create(:post) }

  before do
    visit new_admin_session_path
    fill_in 'ログインID', with: admin.login_id
    fill_in 'パスワード', with: admin.password
    click_button 'ログイン'
  end

  describe 'Side menu' do
    subject { current_path }

    it 'redirects 避難所カレンダー' do
      within ".overlay" do
        find_link('避難所カレンダー').click
      end
      is_expected.to eq '/admin/events'
    end

    it 'redirects 避難者一覧' do
      within ".overlay" do
        find_link('避難者一覧').click
      end
      is_expected.to eq '/admin/residents'
    end

    it 'redirects 避難所通信一覧' do
      within ".overlay" do
        find_link('避難所通信一覧').click
      end
      is_expected.to eq '/admin/posts'
    end

    it 'redirects メッセージ' do
      within ".overlay" do
        find_link('メッセージ').click
      end
      is_expected.to eq '/admin/messages'
    end

    it 'redirects 献立' do
      within ".overlay" do
        find_link('献立').click
      end
      is_expected.to eq '/meals'
    end

    it 'redirects 管理者一覧' do
      within ".overlay" do
        find_link('管理者一覧').click
      end
      is_expected.to eq '/admins'
    end

    it 'redirects 避難所情報' do
      within ".overlay" do
        find_link('避難所情報').click
      end
      is_expected.to eq '/information'
    end
  end
end