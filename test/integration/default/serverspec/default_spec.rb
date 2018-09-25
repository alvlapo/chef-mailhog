require 'spec_helper'

describe 'mailhog::default' do

  describe file('/usr/local/bin/mailhog') do
    it { should exist }
    it { should be_file }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end

  describe file('/etc/systemd/system/mailhog.service') do
    it { should exist }
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end

  describe service('mailhog') do
    it { should be_running }
  end

  describe port(1025) do
    it { should be_listening.on('127.0.0.1').with('tcp') }
  end

  describe port(8025) do
    #see: https://github.com/mailhog/MailHog/issues/87
    it { should be_listening.on('::').with('tcp6') }
  end

end
