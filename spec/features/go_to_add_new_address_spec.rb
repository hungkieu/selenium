# frozen_string_literal: true

RSpec.shared_context 'account signed in' do
  before do
    driver.get(HOST)

    cookie_value = 'eyJfcmFpbHMiOnsibWVzc2FnZSI6IlcxczVNelZkTENKWGMyUnBZVlZvZVRGR1ZEUndablZmVTBwbVNDSXNJakUyTURBM016WXdNakl1T0Rrd05ERXdOQ0pkIiwiZXhwIjoiMjAyMC0xMC0wNlQwMDo1Mzo0Mi44OTBaIiwicHVyIjoiY29va2llLnJlbWVtYmVyX3NwcmVlX3VzZXJfdG9rZW4ifX0%3D--ff2eb882fe42b4897c21fc6969a96102fa803088'

    driver.manage.add_cookie(
      name: 'remember_spree_user_token',
      value: cookie_value,
      path: '/'
    )

    driver.navigate.refresh
  end
end

RSpec.describe 'Go to add new address page' do
  let(:driver) { Selenium::WebDriver::Driver.for :chrome }
  let(:waiter) { Selenium::WebDriver::Wait.new }

  context 'account signed in' do
    include_context 'account signed in'

    before do
      driver.get('https://demo.spreecommerce.org/account')
    end

    it 'success' do
      account_page_new_address_link_element = waiter.until do
        driver.find_element(:class, 'account-page-new-address-link')
      end

      account_page_new_address_link_element.click

      spree_header_element = waiter.until do
        driver.find_element(:css, '.spree-header')
      end

      expect(spree_header_element.text.downcase).to eq('new shipping address')
    end
  end
end
