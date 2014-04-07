# coding: utf-8

module SettingsStep
  step 'テスト対象は :device 端末' do |device|
    @device = device
  end

  step ':target をタップする' do |target|
    about = find_first_element('//text[@text="' + target + '"]')
    about.click
  end

  step 'Android Version は :expected が表示されていること' do |expected|
    version_setting = find_first_element('//list/linear[4]/relative')
    version_value = version_setting.find_element(:xpath, '//text[2]')

    expect(version_value.text).to eq(expected)
  end

  def find_first_element xpath
    #flick the screen until find the target item
    while driver.find_elements(:xpath, xpath).count == 0
      begin
        driver.execute_script 'mobile: flick', :startY => 0.9, :endY => 0.1
      rescue
      end
    end

    driver.find_elements(:xpath, xpath).first 
  end

  def driver
    case @device
    when 'android'
      desired_caps = {
		    'browserName' => 'android',
		    'platform' => 'linux',
		    'version' => '4.1',
        'app-activity'=> '.Settings',
        'app-package'=> 'com.android.settings'
#		    'app-activity'=> '.MainActivity',
#		    'app-package'=> 'cn.orz.pascal.mml'
	    }
      server_url = "http://127.0.0.1:4723/wd/hub"

      @driver ||= Selenium::WebDriver.for(:remote, :desired_capabilities => desired_caps, :url => server_url)
      @driver.manage.timeouts.implicit_wait = 3
    end
    @driver
  end

  def cleanup
    if @driver
      driver.quit
      @driver = nil
    end
  end
end

RSpec.configure do |conf|
  conf.include SettingsStep
  conf.after(:each) do
    cleanup
  end
end
