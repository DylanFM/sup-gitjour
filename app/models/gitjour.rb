class Gitjour
  attr_reader :response
  
  #include DataMapper::Resource
  
  def request
    list = `gitjour list`.split("\n")[1...-1]
    jours, repo = {}, nil
    list.each do |l|
      l.strip!
      if l =~ /=== /
        repo = :"#{$'}"
        jours[repo] = {}
      else
        /\s/.match(l)
        jours[repo][:"#{$~.pre_match}"] = $~.post_match unless repo.nil?
      end
    end
    @response = jours
  end
  
  def project_titles
    @response.keys
  end

end
