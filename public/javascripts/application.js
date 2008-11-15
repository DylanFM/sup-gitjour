function update_jours ()
{
	$.getJSON('/gitjours/list.json',{},
  function(json){
    clearTimeout();
    var apps = '';
    for (var i=0; i < json.length; i++) 
    {
      var app = json[i];
      apps += '<li><strong>'+app.name+'</strong><ul class="repos">';
      $(app.repos).each(function(j){
        apps += '<li class="repo">'+app.repos[j].name+' <a href="'+app.repos[j].url+'" title="git clone '+app.repos[j].url+'" class="url">'+app.repos[j].url+'</a></li>';
      });
      apps += '</ul></li>';
    }
    $("#apps").html(apps);
    setTimeout(update_jours, 6000);
  });
}

$(document).ready(function() {
  update_jours();
});
