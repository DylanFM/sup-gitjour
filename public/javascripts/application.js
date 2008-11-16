function setup_jours ()
{
  $("input.url").focus(function() 
  {
    this.select();
  });
}

function get_apps_count ()
{
  return $("#apps > li").length;
}

function update_message (old_count, new_count)
{
  var diff = new_count - old_count;
  var msg = '';
  if (diff != 0) 
  {
    msg = (diff > 0 ? '+':'')+diff+' repositor';
    msg += (diff == 1 || diff == -1) ? 'y' : 'ies' ;
  }
  else
  {
    msg = 'No change';
  }
  return msg;
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
    var old_count = get_apps_count();
    $("#apps").html(apps);
    var new_count = get_apps_count();
    setup_jours();
    $.choones(update_message(old_count, new_count));
    console.log("Old count: "+old_count+", new count: "+new_count);
    setTimeout(update_jours, 6000);
  });
}

$(document).ready(function() {
  setup_jours();
  update_jours();
});
