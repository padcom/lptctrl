function GetRequestObject()
{
  var http_request = null;

  if (window.ActiveXObject) 
  {
    try 
    {
      http_request = new ActiveXObject("Msxml2.XMLHTTP");
    } 
    catch (e) 
    {
      try 
      {
        http_request = new ActiveXObject("Microsoft.XMLHTTP");
      } 
      catch (e) 
      {
      }
    }
  }
  else if (window.XMLHttpRequest)
  {
    http_request = new XMLHttpRequest();
    if (http_request.overrideMimeType) 
      http_request.overrideMimeType('text/xml');
  }

  if (!http_request)
    window.alert("Your browser does not support Ajax!");
    

  return http_request;
}
    
