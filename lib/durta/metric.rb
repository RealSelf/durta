module Durta

  class Metric
    DEFAULT_PERIOD = 900 # 15 minutes

    def initialize(name)
      @name = name
      @records = []
    end

    def record(value, time = Time.now)
      raise ArgumentError unless value.is_a? Numeric
      @records << { time: time, value: value }
    end

    # Total of all values recorded in the last x seconds
    def total(seconds = DEFAULT_PERIOD)
      records = records_newer_than(Time.now - seconds)
      records.inject(0) do |sum,record|
        sum += record[:value]
      end
    end

    def average(seconds = DEFAULT_PERIOD)
      records = records_newer_than(Time.now - seconds)
      if records.count == 0
        avg = 0
      else
        avg = total(seconds) / records.count
      end
      avg
    end

    def count(seconds = DEFAULT_PERIOD)
      records = records_newer_than(Time.now - seconds)
      records.count
    end

    def records_newer_than(time)
      @records.reject do |record|
        record[:time] < time
      end
    end

    alias_method :avg, :average
  end

end