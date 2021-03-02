require 'rails_helper'

describe 'admin_event', type: :system do
  let(:admin) { create(:admin) }

  before do

    visit new_admin_session_path
    fill_in 'ログインID', with: admin.login_id
    fill_in 'パスワード', with: admin.password
    click_button 'ログイン'
  end

  describe 'page display' do

    it 'has a correct URL' do
      expect(current_path).to eq '/admin/events'
    end

    describe 'side menu' do
      it 'has admin_event link' do
        admin_event_link = find_all('a')[0].native.inner_text
        expect(admin_event_link).to match(/避難所カレンダー/i)
      end

      it 'has a correct admin_event link' do
        admin_event_link = find_all('a')[0].native.inner_text
        expect(page).to have_link admin_event_link, href: admin_events_path
      end

      it 'has admin_residents link' do
        admin_residents_link = find_all('a')[1].native.inner_text
        expect(admin_residents_link).to match(/避難者一覧/i)
      end

      it 'has a correct admin_residents link' do
        admin_residents_link = find_all('a')[1].native.inner_text
        expect(page).to have_link admin_residents_link, href: admin_residents_path
      end

      it 'has admin_posts link' do
        admin_posts_link = find_all('a')[2].native.inner_text
        expect(admin_posts_link).to match(/避難所通信一覧/i)
      end

      it 'has a correct admin_posts link' do
        admin_posts_link = find_all('a')[2].native.inner_text
        expect(page).to have_link admin_posts_link, href: admin_posts_path
      end

      it 'has meal link' do
        meal_link = find_all('a')[3].native.inner_text
        expect(meal_link).to match(/献立/i)
      end

      it 'has a correct meal link' do
        meal_link = find_all('a')[3].native.inner_text
        expect(page).to have_link meal_link, href: meals_path
      end

      it 'has admin_messages link' do
        admin_messages_link = find_all('a')[4].native.inner_text
        expect(admin_messages_link).to match(/メッセージ/i)
      end

      it 'has a correct admin_messages link' do
        admin_messages_link = find_all('a')[4].native.inner_text
        expect(page).to have_link admin_messages_link, href: admin_messages_path
      end

      it 'has admins link' do
        admins_link = find_all('a')[5].native.inner_text
        expect(admins_link).to match(/管理者一覧/i)
      end

      it 'has a correct admins link' do
        admins_link = find_all('a')[5].native.inner_text
        expect(page).to have_link admins_link, href: admins_path
      end

      it 'has information link' do
        information_link = find_all('a')[6].native.inner_text
        expect(information_link).to match(/避難所情報/i)
      end

      it 'has a correct admins link' do
        information_link = find_all('a')[6].native.inner_text
        expect(page).to have_link information_link, href: information_path
      end

      it 'has admin_logout link' do
        admin_logout_link = find_all('a')[7].native.inner_text
        expect(admin_logout_link).to match(/ログアウト/i)
      end

      it 'has a correct admins link' do
        admin_logout_link = find_all('a')[7].native.inner_text
        expect(page).to have_link admin_logout_link, href: destroy_admin_session_path
      end
    end

    # describe do
    #   let!(:admin_event) { create(:admin_event, title: '物資受け取り', end: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)) }

    #   it 'has new_admin_event link' do
    #     expect(:page).to have_button 'イベント作成'
    #   end
    # end
  end
end