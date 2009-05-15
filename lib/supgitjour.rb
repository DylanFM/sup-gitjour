class Supgitjour
  class << self
    def list
      response = Gitjour::Application.send(:service_list).to_a
      response.inject({}) do |repos,service|
        service_key = service.repository.empty? ? service.name.to_sym : service.repository.to_sym
        repos[service_key] = [] unless repos.has_key? service_key
        repos[service_key] << service
        repos
      end
    end
  end
end
