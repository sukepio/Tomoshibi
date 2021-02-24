require 'rails_helper'

describe 'login', type: :system do
  describe 'resident login' do
    before do
      visit root_path
    end

    describe 'resident login page(root_path)' do
      describe 'correct page display' do
        it 'has a URL' do
          expect(current_path).to eq '/'
        end

        it 'has resident_login link' do
          log_in_link = find_all('a')[1].native.inner_text
          expect(log_in_link).to match(/住民ログイン/i)
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
  end
end
