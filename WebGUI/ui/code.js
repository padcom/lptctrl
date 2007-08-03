
function load_ui()
{
//  load_ui_element("main_menu", "ui/main_menu.php");
  load_ui_element("main_content", "ui/status_grid.php", GetStatus);
  StartAutomaticUpdates();
}

function load_ui_element(item, url, action)
{
  var request = GetRequestObject(); 
  request.onreadystatechange = function() 
  { 
    if (request.readyState == 4)
    {
      if (request.status == 200)
      {
        document.getElementById(item).innerHTML = request.responseText;
        if (action) action();
      }
      else	
        window.alert("Error: returned status code " + request.status + " " + request.statusText);
    } 
  }
  request.open("GET", url, true); 
  request.send(null); 
}

