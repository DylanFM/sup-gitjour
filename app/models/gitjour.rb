require 'pathname'

class Gitjour
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
    fpath = Merb.root
    unless Merb.env == 'development' # If in prodution we want the real list
      fpath += '/public/gitjour_list' # This is the list and is updated every 25 seconds (or later if there's no request)
      File.new(fpath, 'w+').write(`gitjour list`) if Time.now-File.new(fpath).mtime > 25 # If the last time the list was updated is over 25 seconds ago, update the list file
    else # Otherwise, just use these lists as they don't take 5 secs to load
      fpath += "/spec/fixtures/gitjour_list_#{rand < 0.5 ? 'a' : 'b'}" # Alternate between 2 which have different contents
    end
    File.new(fpath).read # And return the list
  end

end