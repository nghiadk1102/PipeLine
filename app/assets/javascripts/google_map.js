function initMap() {
  var uluru = {lat: 21.043285, lng: 105.793673};
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: uluru,
    gestureHandling: 'greedy'
  });
  list_line = [];
}

function createLine(arr, pipelineName){
  var newline = new google.maps.Polyline({
    path: arr,
    geodesic: true,
    strokeColor: getRandomColor(),
    strokeOpacity: 1.0,
    strokeWeight: 4,
    actived: false
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
    this.setOptions({strokeColor: 'blue', strokeWeight: 6, actived: true});
    line = this;
    this.infomationLine.open(map);
  } else {
    this.setOptions({strokeWeight: 4, strokeColor: '#FF0000', actived: false});
    this.infomationLine.close();
  }
}

function getRandomColor() {
  var letters = '0123456789ABCDEF';
  var color = '#';
  for (var i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}