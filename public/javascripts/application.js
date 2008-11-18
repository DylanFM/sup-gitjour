function setup_jours ()
{
  $("#apps input").focus(function() 
  {
    $.copy('gitjour clone '+$(this).attr('value'));
    $.choones('Copied',{type: 'notice'});
  });
}

function get_apps_count ()
{
  return $("#apps > li").length;
}

function update_message (old_count, new_count)
{
  var diff = new_count - old_count;
  if (diff != 0) 
  {
    msg = (diff > 0 ? '+':'')+diff+' repositor';
    msg += (diff == 1 || diff == -1) ? 'y' : 'ies';
    $.choones(msg,{type: 'success'});
  }
}

function update_jours ()
{
  setTimeout(update_jours, 12000);
  if (!$('#auto-refresh').attr('checked')) return;
	$.getJSON('/gitjours/list.json',{},
  function(json){
    var apps = '';
    for (var i=0; i < json.length; i++) 
    {
      var app = json[i];
      apps += '<li><h4>'+app.name+'</h4><ul>';
      $(app.repos).each(function(j){
        apps += '<li><strong>'+app.repos[j].name+'</strong> <input type="text" value="'+app.repos[j].url+'" size="50" readonly="readonly" /></li>';
      });
      apps += '</ul></li>';
    }
    var old_count = get_apps_count();
    $("#apps").html(apps);
    var new_count = get_apps_count();
    setup_jours();
    update_message(old_count, new_count);
    // console.log("Old count: "+old_count+", new count: "+new_count);
  });
}

$(document).ready(function() {
  setup_jours();
  update_jours();
});
