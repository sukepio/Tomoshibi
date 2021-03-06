require 'rails_helper'

describe 'Login', type: :system do
  describe 'resident login' do
    before do
      visit root_path
    end

    describe 'Resident login page(root_path)' do
      describe 'Page display' do
        it 'has a correct URL' do
          expect(current_path).to eq '/'
        end

        it 'has resident_login link' do
          log_in_link = find_all('a')[1].native.inner_text
          expect(log_in_link).to match(/住民さんログイン/i)
        end

        it 'has a correct resident_login link' do
          log_in_link = find_all('a')[1].native.inner_text
          expect(page).to have_link log_in_link, href: new_resident_session_path
        end

        it 'has admin_login link' do
          log_in_link = find_all('a')[2].native.inner_text
          expect(log_in_link).to match(/管理者ログイン/i)
        end

        it 'has a correct admin_login link' do
          log_in_link = find_all('a')[2].native.inner_text
          expect(page).to have_link log_in_link, href: new_admin_session_path
        end
      end
    end

    describe 'Log in to resident' do
      let(:resident) { create(:resident) }
      let!(:post) { create(:post) }

      context 'with valid inputs' do
        before do
          fill_in 'ログインID', with: resident.login_id
          fill_in 'パスワード', with: resident.password
          click_button 'ログイン'
        end

        it 'succeeds and redirects mypage' do
          expect(current_path).to eq '/mypage'
        end
      end

      context 'with invalid inputs' do
        before do
          fill_in 'ログインID', with: ''
          fill_in 'パスワード', with: ''
          click_button 'ログイン'
        end

        it 'fails and redirects resident login page' do
          expect(current_path).to eq '/residents/sign_in'
        end
      end
    end
  end

  describe 'Admin login' do
    before do
      visit new_admin_session_path
    end

    describe 'page display' do
      it 'has a correct URL' do
        expect(current_path).to eq '/admins/sign_in'
      end

      it 'has resident_login link' do
        log_in_link = find_all('a')[1].native.inner_text
        expect(log_in_link).to match(/住民さんログイン/i)
      end

      it 'has a correct resident_login link' do
        log_in_link = find_all('a')[1].native.inner_text
        expect(page).to have_link log_in_link, href: new_resident_session_path
      end

      it 'has admin_login link' do
        log_in_link = find_all('a')[2].native.inner_text
        expect(log_in_link).to match(/管理者ログイン/i)
      end

      it 'has a correct admin_login link' do
        log_in_link = find_all('a')[2].native.inner_text
        expect(page).to have_link log_in_link, href: new_admin_session_path
      end
    end

    describe 'Log in to admin' do
      let(:admin) { create(:admin) }

      context 'with valid inputs' do
        before do
          fill_in 'ログインID', with: admin.login_id
          fill_in 'パスワード', with: admin.password
          click_button 'ログイン'
        end

        it 'succeeds and redirects mypage' do
          expect(current_path).to eq '/admin/events'
        end
      end

      context 'with invalid inputs' do
        before do
          fill_in 'ログインID', with: ''
          fill_in 'パスワード', with: ''
          click_button 'ログイン'
        end

        it 'fails and redirects resident login page' do
          expect(current_path).to eq '/admins/sign_in'
        end
      end
    end
  end
end
