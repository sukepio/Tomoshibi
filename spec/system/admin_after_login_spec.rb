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
  
  describe 'Admin top page' do
    before do
      visit admin_events_path
    end
    
    it 'has a correct url' do
      expect(current_path).to eq '/admin/events'
    end
    
    describe 'Display' do
      subject { page }

      it 'shows correct welcome container' do
        is_expected.to have_content "こんにちは、#{admin.full_name}さん！"
        is_expected.to have_content "ともしび避難所"

      end

      it 'shows today\'s admin\'s event' do
        within ".myevent-container" do
          is_expected.to have_content admin_event.time
          is_expected.to have_content admin_event.title
          is_expected.to have_content admin_event.body
        end
      end

      # it 'does not show other day\'s event in today\'s events'do
      #   within ".myevent-container" do
      #     other_event = create(:admin_event, start: 2.days.ago, end: 2.days.ago)
      #     is_expected.to have_no_content other_event.time
      #     is_expected.to have_no_content other_event.title
      #     is_expected.to have_no_content other_event.body
      #   end
      # end

      it 'shows "イベント作成ボタン" and redirects new admin event page' do
        find_link('イベント作成').click
        expect(current_path).to eq '/admin/events/new'
      end
    end
  end
end