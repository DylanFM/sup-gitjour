class Gitjours < Application
  provides :js

  def list
    jour = Gitjour.new
    jour.request
    @response = jour.response
    render
  end
  
end
