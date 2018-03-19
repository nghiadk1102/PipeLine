function initMap() {
  var uluru = {lat: 21.043285, lng: 105.793673};
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: uluru,
    gestureHandling: 'greedy'
  });
  list_line = [];
}

function createLine(arr, pipelineName, color){
  var newline = new google.maps.Polyline({
    path: arr,
    geodesic: true,
    strokeColor: color,
    strokeOpacity: 1.0,
    strokeWeight: 4,
    actived: false,
    defaultColor: color
  });
  var infomationLine = new google.maps.InfoWindow({
    content: pipelineName
  });
  infomationLine.setPosition(arr[0]);
  newline["infomationLine"] = infomationLine;
  newline.addListener('click', showInfomationPolyline);
  return newline;
}

function showInfomationPolyline() {
  if(this.actived == false){
    this.setOptions({strokeColor: '#FF0000', strokeWeight: 6, actived: true});
    line = this;
    this.infomationLine.open(map);
  } else {
    this.setOptions({strokeWeight: 4, strokeColor: this.defaultColor, actived: false});
    this.infomationLine.close();
  }
}


function initMapLine() {
  var uluru = {lat: 21.043285, lng: 105.793673};
  var thisMap = document.getElementById('map-line');
  map_line = new google.maps.Map(thisMap, {
    zoom: 16,
    center: uluru,
    gestureHandling: 'greedy',
  });
  map_line['line'] = null;
}

