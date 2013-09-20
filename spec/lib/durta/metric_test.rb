require 'rspec'
require 'durta/metric'

describe Durta::Metric do

  before :each do
    @metric = Durta::Metric.new('requests')
  end

  describe '::new' do
    it 'takes a name and returns a new instance' do
      @metric.should be_an_instance_of Durta::Metric
    end
  end

  describe '#record' do
    it 'takes a value' do
      @metric.record(123)
    end

    it 'takes a value and an optional time' do
      @metric.record(123, Time.now)
    end

    it 'throws an exception when given a non numeric value' do
      expect{@metric.record('asdf')}.to raise_exception(ArgumentError)
    end
  end

  describe '#total' do
    it 'returns the sum of the values recorded within the default time period' do
      @metric.record(100)
      @metric.record(20.99)
      @metric.record(0)

      @metric.total.should eql 120.99
    end

    it 'returns the sum of the values recorded within the last X seconds' do
      @metric.record(99999, Time.now - 900) # 15 mins ago
      @metric.record(1,     Time.now - 60)  # 1 min ago
      @metric.record(1,     Time.now - 10)  # 10 sec ago
      @metric.record(80000)                 # Now (default)

      @metric.total(60).should eql 80001
    end
  end

  describe '#average' do
    it 'returns the average of the values recorded within the default time period' do
      @metric.record(88.9)
      @metric.record(1)
      @metric.record(80000)

      avg = (88.9 + 1 + 80000) / 3
      @metric.average.should eql avg
    end

    it 'returns the average of the values recorded within the last X seconds' do
      @metric.record(88.9, Time.now - 3600) # 1 hr ago
      @metric.record(1)
      @metric.record(80000)

      avg = (1 + 80000) / 2
      @metric.average(120).should eql avg
    end
  end

end