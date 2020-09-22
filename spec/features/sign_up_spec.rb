# frozen_string_literal: true

RSpec.describe 'Sign Up' do
  let(:driver) { Selenium::WebDriver::Driver.for :chrome }
  let(:waiter) { Selenium::WebDriver::Wait.new }

  context 'From home page to sign up page' do
    before do
      driver.get(HOST)

      account_button_element = waiter.until do
        driver.find_element(:id, 'account-button')
      end

      account_button_element.click

      sign_up_button_element = waiter.until do
        driver.find_element(:id, 'link-to-account')
              .find_element(:xpath, './/a[2]')
      end

      sign_up_button_element.click
    end

    it 'sign up successfully' do
      waiter.until do
        driver.find_element(:id, 'new_spree_user')
      end

      email_input_element = driver.find_element(:id, 'spree_user_email')
      password_input_element = driver.find_element(:id, 'spree_user_password')
      password_confirmation_input_element = driver.find_element(
        :id,
        'spree_user_password_confirmation'
      )
      submit_input = driver.find_element(:xpath, '//input[@value="Sign Up"]')

      email = "test9999+#{Time.now.to_i}@gmail.com"

      email_input_element.send_keys email
      password_input_element.send_keys '12345678'
      password_confirmation_input_element.send_keys '12345678'

      submit_input.click

      flash_element = waiter.until do
        text = 'Welcome! You have signed up successfully.'
        driver.find_element(:xpath, "//*[contains(text(), '#{text}')]")
      end

      expect(flash_element.displayed?).to be_truthy
    end
  end
end
