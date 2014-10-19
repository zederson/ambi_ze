require 'spec_helper'
require 'long_polling'
require 'eventmachine'

describe LongPolling do

  describe ".start" do

    it "when start without block" do
      expect(LongPolling.start).to be_nil
    end

    it "when start with block" do
      server = double('server')
      allow(server).to receive(:cancel)
      allow(EM).to receive(:run)

      LongPolling.server = server

      expect(server).to receive(:cancel)

      LongPolling.start { 2 }
    end
  end

  describe ".stop" do
    it "when server is not running" do
      server = double('server')
      allow(server).to receive(:cancel)

      LongPolling.server = server

      expect(server).to receive(:cancel)

      LongPolling.stop
    end

    it "when server is running" do
      LongPolling.server = nil
      LongPolling.stop
    end
  end

end
