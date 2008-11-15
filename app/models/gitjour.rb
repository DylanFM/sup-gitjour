class Gitjour
  attr_reader :response
  
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
    @response = jours.sort_by { |r| r[1].size }.reverse #Sort by number of repositories shared
  end
  
  def gitjour_list
    # `gitjour list`
    #"Gathering for up to 5 seconds...\n=== ambition \n\tben-ambition git://zaphod.local/ambition\n=== hammock (2 copies)\n\tnick-hammock git://nick.local/hammock\n\tben-hammock git://zaphod.local/hammock\n=== how_does (3 copies)\n\tglen-how_does git://glen.local/how_does\n\tnick-how_does git://nick.local/how_does\n\tkef-how_does git://trousers.local/how_does\n=== lachlanhardy-gemjour \n\tjosh-lachlanhardy-gemjour git://sphere.local/\n=== mohole (2 copies)\n\tglen-mohole git://glen.local/mohole\n\tkef-mohole git://trousers.local/mohole\n=== sausage \n\tnick-sausage git://nick.local/sausage\n10 repositories shown.\n"
  end

end
