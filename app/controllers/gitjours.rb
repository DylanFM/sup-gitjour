class Gitjours < Application
  provides :json

  def list
    jour = Gitjour.new
    jour.request
    @response = jour.response
    display @response
  end
  
end
