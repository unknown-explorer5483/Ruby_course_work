# Generated by Selenium IDE
require 'selenium-webdriver'
require 'json'
describe 'Editroom' do
  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @vars = {}
  end
  after(:each) do
    @driver.quit
  end
  it 'editroom' do
    @driver.get('http://localhost:3000/en')
    @driver.find_element(:link_text, 'Log in').click
    @driver.find_element(:id, 'username').click
    @driver.find_element(:id, 'username').send_keys('admin')
    @driver.find_element(:id, 'password').click
    @driver.find_element(:id, 'password').send_keys('12345678')
    @driver.find_element(:name, 'commit').click
    @driver.find_element(:link_text, 'Check rooms').click
    @driver.find_element(:link_text, 'Check room').click
    @driver.find_element(:link_text, 'Edit this room').click
    @driver.find_element(:id, 'room_name').click
    @driver.action.key_down(:left_control).send_keys('a').key_up(:left_control).perform
    @driver.find_element(:id, 'room_name').send_keys('newroom700')
    @driver.find_element(:id, 'room_description').click
    @driver.action.key_down(:left_control).send_keys('a').key_up(:left_control).perform
    @driver.find_element(:id, 'room_description').send_keys('big room with big balcony700')
    @driver.find_element(:id, 'room_cost_per_night').click
    @driver.action.key_down(:left_control).send_keys('a').key_up(:left_control).perform
    @driver.find_element(:id, 'room_cost_per_night').send_keys('250.0')
    @driver.find_element(:name, 'commit').click
    expect(@driver.find_element(:css, '.card-title').text).to eq('newroom700')
    expect(@driver.find_element(:css, '.card-text:nth-child(2)').text).to eq('big room with big balcony700')
    expect(@driver.find_element(:css, 'small').text).to eq('Cost per night: 250.0')
    @driver.find_element(:link_text, 'Edit this room').click
    @driver.find_element(:id, 'room_description').click
    @driver.action.key_down(:left_control).send_keys('a').key_up(:left_control).perform
    @driver.find_element(:id, 'room_description').send_keys('big room with big balcony')
    @driver.find_element(:id, 'room_name').click
    @driver.action.key_down(:left_control).send_keys('a').key_up(:left_control).perform
    @driver.find_element(:id, 'room_name').send_keys('newroom')
    @driver.find_element(:id, 'room_cost_per_night').click
    @driver.action.key_down(:left_control).send_keys('a').key_up(:left_control).perform
    @driver.find_element(:id, 'room_cost_per_night').send_keys('300.0')
    @driver.find_element(:name, 'commit').click
    expect(@driver.find_element(:css, '.card-title').text).to eq('newroom')
    expect(@driver.find_element(:css, '.card-text:nth-child(2)').text).to eq('big room with big balcony')
    expect(@driver.find_element(:css, 'small').text).to eq('Cost per night: 300.0')
    @driver.find_element(:link_text, 'Log out').click
  end
end
