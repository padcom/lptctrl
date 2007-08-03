function ToggleStatusBit(bit)
{
  var request = GetRequestObject(); 

  request.onreadystatechange = function()
  { 
    document.getElementById("BIT"+bit).innerHTML = "???"; 
    if (request.readyState == 4)
    {
      if (request.status == 200)
      {
        var response = request.responseText;
        document.getElementById("BIT"+bit).innerHTML = (response & (1 << bit)) ? "ON" : "OFF"; 
      }
      else	
        window.alert("Error: returned status code " + request.status + " " + request.statusText);
    } 
  }; 

  request.open('POST', 'actions/toggle_status.php', true); 
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  request.send('bit=' + bit); 
}

function UpdateStatusBit(bit)
{
  var request = GetRequestObject(); 

  request.onreadystatechange = function()
  { 
    if (request.readyState == 4)
    {
      if (request.status == 200)
      {
        var response = request.responseText;
        document.getElementById("BIT"+bit).innerHTML = (response & (1 << bit)) ? "ON" : "OFF"; 
      }
      else	
        window.alert("Error: returned status code " + request.status + " " + request.statusText);
    } 
  }; 

  request.open('POST', 'actions/query_status.php', true); 
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  request.send('bit=' + bit); 
}

function GetStatus()
{ 
  var request = GetRequestObject(); 
  request.open('GET', 'actions/query_status.php', true); 
  request.onreadystatechange = function()
  { 
    if (request.readyState == 4)
    {
      if (request.status == 200)
      {
        var response = request.responseText;
        for (bit = 0; bit < 8; bit++)
        {
          document.getElementById("BIT"+bit).innerHTML = response & 1 ? "ON" : "OFF"; 
          response = response >> 1;
        }
      }
      else
        window.alert("Error: returned status code " + request.status + " " + request.statusText);
    } 
  }; 

  request.send(null); 
} 

var automatic_update_timer = 0;

function StartAutomaticUpdates()
{
  automatic_update_timer = setTimeout("PerformAutomaticUpdate()", 3000);
}

function StopAutomaticUpdates()
{
  if (automatic_update_timer)
  {
    clearTimeout(automatic_update_timer);
    automatic_update_timer = 0;
  }
}

function PerformAutomaticUpdate()
{
  GetStatus();
  automatic_update_timer = setTimeout("PerformAutomaticUpdate()", 3000);
}
