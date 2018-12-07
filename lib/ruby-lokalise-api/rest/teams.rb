module Lokalise
  class Client
    def teams(params = {})
      Lokalise::Collections::Team.all self, params
    end
  end
end
