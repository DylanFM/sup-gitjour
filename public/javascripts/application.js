function setup_jours ()
{
  $("input.url").focus(function() 
  {
    this.select();
  });
}

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
        apps += '<li class="repo">'+app.repos[j].name+' <input type="text" value="'+app.repos[j].url+'" class="url" size="50" readonly="readonly" /></li>';
      });
      apps += '</ul></li>';
    }
    $("#apps").html(apps);
    setup_jours();
    setTimeout(update_jours, 6000);
  });
}

$(document).ready(function() {
  setup_jours();
  update_jours();
});
