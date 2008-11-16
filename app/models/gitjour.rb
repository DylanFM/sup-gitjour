class Gitjour
  attr_reader :response
  
  def request
    list = gitjour_list.split("\n")[1...-1]
    jours, repo = {}, nil
    p list
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
    fpath = Merb.root+'/public/gitjour_list'
    if Time.now-File.new(fpath).mtime > 15
      list = `gitjour list`
      File.new(fpath, 'w+').write(list)
    else
      list = File.new(fpath).read
    end
    list
  end

end