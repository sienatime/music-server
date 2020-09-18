module Import
  class ImportResult

    attr_reader :errors, :not_processed, :totals

    def initialize(errors, not_processed, totals)
      @errors = errors
      @not_processed = not_processed
      @totals = totals
    end
  end
end
