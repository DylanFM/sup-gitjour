class Supgitjour
  class << self
    def list
      parse_list self.run('list')
      # Old cacheing stuff
      # fpath = File.join(File.dirname(__FILE__), '..', 'public', 'gitjour_list') # This is the list and is updated every 25 seconds (or later if there's no request)
      # File.new(fpath, 'w+').write(`gitjour list`) if Time.now-File.new(fpath).mtime > 25 # If the last time the list was updated is over 25 seconds ago, update the list file
      # File.new(fpath).read # And return the list
    end

    private
    def run(command)
      old_stdout, new_stdout = $stdout, StringIO.new
      $stdout = new_stdout
      Gitjour::Application.run command
      response = new_stdout.string
      $stdout = old_stdout
    end

    def parse_list(response)
      list, jours, repo = response.split("\n")[1...-1], {}, nil
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
      jours.sort_by { |r| r[1].size }.reverse #Sort apps by number of repositories shared
    end
  end
end
