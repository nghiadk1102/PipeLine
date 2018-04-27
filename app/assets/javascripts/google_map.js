function initMap() {
  var uluru = {lat: 21.043285, lng: 105.793673};
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: uluru,
    gestureHandling: 'greedy'
  });
  list_line = [];
  list_mark = [];
  var isClosed = false;
  var enablePolygon = true;
  var polygonMarkers = [];
  var poly = new google.maps.Polyline({ map: map, path: [], strokeColor: "#FF0000", strokeOpacity: 1.0, strokeWeight: 2 });
  google.maps.event.addListener(map, 'click', function (clickEvent) {
    var enablePolygon = $('#enable-polygon')[0].checked;
    if (isClosed || !enablePolygon){
      return;
    }
    var markerIndex = poly.getPath().length;
    var isFirstMarker = markerIndex === 0;
    var marker = new google.maps.Marker({ map: map, position: clickEvent.latLng, draggable: true });
    polygonMarkers.push(marker);
    if (isFirstMarker) {
      google.maps.event.addListener(marker, 'click', function () {
        if (isClosed)
          return;
        var path = poly.getPath();
        poly.setMap(null);
        poly = new google.maps.Polygon({ map: map, path: path, strokeColor: "#FF0000", strokeOpacity: 0.8, strokeWeight: 2, fillColor: "#FF0000", fillOpacity: 0.35 });
        isClosed = true;
      });
    }
    google.maps.event.addListener(marker, 'drag', function (dragEvent) {
      poly.getPath().setAt(markerIndex, dragEvent.latLng);
    });
    poly.getPath().push(clickEvent.latLng);
  });

  $('.reset-poly').click(function(){
    debugger;
    poly.setMap(null);
    poly = new google.maps.Polyline({ map: map, path: [], strokeColor: "#FF0000", strokeOpacity: 1.0, strokeWeight: 2 });
    isClosed = false;
    polygonMarkers.forEach(function(mark, index) {
      mark.setMap(null);
    });
  });

  $('.checking-poly').click(function(event) {
    if(!(isClosed && enablePolygon)) {
      return;
    }

    $.ajax({
      url: '/lines',
      method: 'GET',
      dataType: 'JSON'
    }).done(function(result){
      debugger;
      //each do all line
      //check intersect
      //check inside
    });

  });
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
             '<p><strong>Name: </strong>' + lineName + '</p>' +
             '<p><strong>type: </strong>' + pipelineName + '</p>' +
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

function intersects(a,b,c,d,p,q,r,s) {
  var det, gamma, lambda;
  det = (c - a) * (s - q) - (r - p) * (d - b);
  if (det === 0) {
    return false;
  } else {
    lambda = ((s - q) * (r - a) + (p - r) * (s - b)) / det;
    gamma = ((b - d) * (r - a) + (c - a) * (s - b)) / det;
    return (0 < lambda && lambda < 1) && (0 < gamma && gamma < 1);
  }
};
