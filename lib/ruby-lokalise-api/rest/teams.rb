module Lokalise
  class Client
    def teams(params = {})
      Lokalise::Collections::Team.all @token, params
    end
  end
end
