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
    `gitjour list`
    # if rand() > 0.5
    #       "Gathering for up to 5 seconds...\n=== ambition \n\tben-ambition git://zaphod.local/ambition\n=== hammock (2 copies)\n\tnick-hammock git://nick.local/hammock\n\tben-hammock git://zaphod.local/hammock\n=== how_does (3 copies)\n\tglen-how_does git://glen.local/how_does\n\tnick-how_does git://nick.local/how_does\n\tkef-how_does git://trousers.local/how_does\n=== lachlanhardy-gemjour \n\tjosh-lachlanhardy-gemjour git://sphere.local/\n=== mohole (2 copies)\n\tglen-mohole git://glen.local/mohole\n\tkef-mohole git://trousers.local/mohole\n=== sausage \n\tnick-sausage git://nick.local/sausage\n10 repositories shown.\n"
    #     else
    #       "Gathering for up to 5 seconds...\n===  (24 copies)\n\tdbrown-git-plugin git://LachstockMBP.local/\n\tgemjour git://LachstockMBP.local/\n\tgitman git://LachstockMBP.local/\n\txmpp4em git://LachstockMBP.local/\n\tambitious_activerecord git://LachstockMBP.local/\n\ttest git://LachstockMBP.local/\n\tdneighman-merb-plugins git://LachstockMBP.local/\n\tevil git://LachstockMBP.local/\n\tpastejour git://LachstockMBP.local/\n\tdneighman-merb git://LachstockMBP.local/\n\tgitnotify git://LachstockMBP.local/\n\tstarjour git://LachstockMBP.local/\n\tinjour git://LachstockMBP.local/\n\tdneighman-extlib git://LachstockMBP.local/\n\thostjour git://LachstockMBP.local/\n\tdejour git://LachstockMBP.local/\n\tgitjour git://LachstockMBP.local/\n\txmpp4r git://LachstockMBP.local/\n\tappjour git://LachstockMBP.local/\n\ttwitter git://LachstockMBP.local/\n\tnogoth-gitjour git://LachstockMBP.local/\n\thijack git://LachstockMBP.local/\n\thaml git://LachstockMBP.local/\n\tfireeagle git://LachstockMBP.local/\n=== active-matchers \n\tpat-active-matchers git://freelancing-god.local/active-matchers\n=== address-book \n\tpat-address-book git://freelancing-god.local/address-book\n=== ambition \n\tben-ambition git://zaphod.local/ambition\n=== captcha_with_question \n\tpat-captcha_with_question git://freelancing-god.local/captcha_with_question\n=== clickatell \n\tpat-clickatell git://freelancing-god.local/clickatell\n=== collective \n\tpat-collective git://freelancing-god.local/collective\n=== cows-not-kittens \n\tpat-cows-not-kittens git://freelancing-god.local/cows-not-kittens\n=== cucumber \n\tpat-cucumber git://freelancing-god.local/cucumber\n=== dejour \n\tpat-dejour git://freelancing-god.local/dejour\n=== delayed_job \n\tpat-delayed_job git://freelancing-god.local/delayed_job\n=== duke \n\tpat-duke git://freelancing-god.local/duke\n=== freebase \n\tpat-freebase git://freelancing-god.local/freebase\n=== garlic \n\tpat-garlic git://freelancing-god.local/garlic\n=== gemjour \n\tpat-gemjour git://freelancing-god.local/gemjour\n=== ginger \n\tpat-ginger git://freelancing-god.local/ginger\n=== gitman \n\tpat-gitman git://freelancing-god.local/gitman\n=== haml \n\tpat-haml git://freelancing-god.local/haml\n=== hammock (2 copies)\n\tnick-hammock git://nick.local/hammock\n\tben-hammock git://zaphod.local/hammock\n=== how_does (3 copies)\n\tglen-how_does git://glen.local/how_does\n\tnick-how_does git://nick.local/how_does\n\tkef-how_does git://trousers.local/how_does\n=== jrails \n\tben-jrails git://zaphod.local/jrails\n=== lachlanhardy-gemjour \n\tjosh-lachlanhardy-gemjour git://sphere.local/\n=== mohole (3 copies)\n\tglen-mohole git://glen.local/mohole\n\tkef-mohole git://trousers.local/mohole\n\tben-mohole git://zaphod.local/mohole\n=== mute \n\tpat-mute git://freelancing-god.local/mute\n=== muxtape-rb \n\tpat-muxtape-rb git://freelancing-god.local/muxtape-rb\n=== not_a_mock \n\tpat-not_a_mock git://freelancing-god.local/not_a_mock\n=== pain-point \n\tpat-pain-point git://freelancing-god.local/pain-point\n=== peepcode-sphinx-address-book \n\tpat-peepcode-sphinx-address-book git://freelancing-god.local/peepcode-sphinx-address-book\n=== prohax \n\tnick-prohax git://nick.local/prohax\n=== radiant \n\tpat-radiant git://freelancing-god.local/radiant\n=== rails-math-captcha \n\tpat-rails-math-captcha git://freelancing-god.local/rails-math-captcha\n=== resources_controller \n\tpat-resources_controller git://freelancing-god.local/resources_controller\n=== riddle \n\tpat-riddle git://freelancing-god.local/riddle\n=== sabsurvey \n\tpat-sabsurvey git://freelancing-god.local/sabsurvey\n=== sausage \n\tnick-sausage git://nick.local/sausage\n=== starjour \n\tpat-starjour git://freelancing-god.local/starjour\n=== thinking_sphinx \n\tpat-thinking_sphinx git://freelancing-god.local/thinking_sphinx\n=== ts_datamapper \n\tpat-ts_datamapper git://freelancing-god.local/ts_datamapper\n=== twetter \n\tpat-twetter git://freelancing-god.local/twetter\n67 repositories shown.\n"
    #     end
  end

end