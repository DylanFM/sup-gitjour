class Gitjours < Application
  provides :xml, :js

  def list
    @list = Gitjour.list
    render
  end
  
end
