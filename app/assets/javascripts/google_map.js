function initMap() {
  var uluru = {lat: 21.043285, lng: 105.793673};
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: uluru,
    gestureHandling: 'greedy'
  });
  list_line = [];
  list_mark = [];
}

function createLine(arr, pipelineName, color, id, lineName){
  var newline = new google.maps.Polyline({
    path: arr,
    geodesic: true,
    strokeColor: color,
    strokeOpacity: 1.0,
    strokeWeight: 5,
    actived: false,
    defaultColor: color,
    id: id
  });
  var infomationLine = new google.maps.InfoWindow({
    content: '<div>' +
             '<p>Name: ' + lineName + '</p>' +
             '<p>type: ' + pipelineName + '</p>' +
             '</div>'

  });
  infomationLine.setPosition(arr[0]);
  newline["infomationLine"] = infomationLine;
  newline.addListener('click', showInfomationPolyline);
  return newline;
}

function showInfomationPolyline() {
  if(this.actived == false){
    this.setOptions({strokeColor: '#FF0000', strokeWeight: 6, actived: true});
    if(typeof(map) == "undefined"){
      return;
    }
    line = this;
    this.infomationLine.open(map);
    $.ajax({
      url: '/intersect_marks',
      type: 'GET',
      dataType: 'json',
      data: {line_id: this.id}
    })
    .done(function(result) {
      if(result['status'] == 'success') {
        resetmark();
        $.each(result['data'], function(index, val) {
          var mark = createMark(val, map);
          mark.setMap(map);
          list_mark.push(mark);
        });
      }
    })
    .fail(function() {
      console.log("error");
    });
  } else {
    this.setOptions({strokeWeight: 4, strokeColor: this.defaultColor, actived: false});
    this.infomationLine.close();
    resetmark();
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

function createMark(arr, map) {
  var marker = new google.maps.Marker({
    position: {lat: parseFloat(arr[1]), lng: parseFloat(arr[2])},
    map: map,
    title: 'intersect marks id' + arr[0]
  });

  var contentString = '<div id="content">' +
                      '<p>' +
                      '[' + arr[1] + ',' + arr[2] + ']' +
                      '</p>' +
                      '</div>'
  var infowindow = new google.maps.InfoWindow({
    content: contentString
  });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });
  return marker;
}

function resetmark() {
  list_mark.forEach(function(mark, index) {
    mark.setMap(null);
  });
}
