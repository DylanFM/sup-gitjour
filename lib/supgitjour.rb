class Supgitjour
  attr_reader :response

  def request
    list, jours, repo = gitjour_list.split("\n")[1...-1], {}, nil
    list.each do |l|
      l.strip!
      if l =~ /=== / # This is a new app
        repo = :"#{$'}"
        jours[repo] = {}
      else # This is a repo for an existing app
        /\s/.match(l) # i.e. l = 'nathan-gitjour git://macbookpoo.local/gitjour'
        jours[repo][:"#{$~.pre_match}"] = $~.post_match unless repo.nil?
      end
    end
    @response = jours.sort_by { |r| r[1].size }.reverse #Sort apps by number of repositories shared
  end

  def gitjour_list
    # fpath = File.join(File.dirname(__FILE__), '..', 'public', 'gitjour_list') # This is the list and is updated every 25 seconds (or later if there's no request)
    # File.new(fpath, 'w+').write(`gitjour list`) if Time.now-File.new(fpath).mtime > 25 # If the last time the list was updated is over 25 seconds ago, update the list file
    # File.new(fpath).read # And return the list
    `gitjour list`
  end

end