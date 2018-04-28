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
  var lineInside = [];
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
    poly.setMap(null);
    poly = new google.maps.Polyline({ map: map, path: [], strokeColor: "#FF0000", strokeOpacity: 1.0, strokeWeight: 2 });
    isClosed = false;
    polygonMarkers.forEach(function(mark, index) {
      mark.setMap(null);
    });
    polygonMarkers = [];
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
      lineInside = [];
      result.data.forEach(function(line, index){
        for(var i = 0; i < line.marks.length; i++){
          var googleMark = new google.maps.LatLng(line.marks[i][0], line.marks[i][1]);
          if (google.maps.geometry.poly.containsLocation(googleMark, poly)) {
            if(!isInclude(lineInside, line.id)){
                lineInside.push(line);
              }
            break;
          }
        };
      });
      polygonMarkers.forEach(function(mark, index){
        var firstMark = mark.position;
        var secondMark = index == (polygonMarkers.length - 1) ? polygonMarkers[0].position : polygonMarkers[index + 1].position;
        result.data.forEach(function(line, index){
          for(var i = 0; i < line.marks.length - 1; i++){
            var firsrLineMark = line.marks[i];
            var secondLineMark = line.marks[i+1];
            if(intersects(firstMark.lat(), firstMark.lng(), secondMark.lat(), secondMark.lng(), firsrLineMark[0], firsrLineMark[1], secondLineMark[0], secondLineMark[1])) {
              if(!isInclude(lineInside, line.id)){
                lineInside.push(line);
              }
              break;
            }
          }
        });
      });
      var content = '<ul class="list-group">';
      _.map(lineInside, function(line){
        content += '<li class="list-group-item"><p><strong>Line ID:</strong>' + line.id + '</p>'
                + '<p><p><strong>Line Name:</strong>' + line.name + '</p>'
                + '</li>';
      });
      content += '</ul>';
      $('body').find('.list-line-area').html(content);
      $('body').find('.count-line').html('<span>Count Line:' + lineInside.length + '</span>');
    });
  });
}

function isInclude(arr, id) {
  return _.includes(_.map(arr, function(attr){
          return attr.id;
        }), id)
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


function intersects(p0_x, p0_y, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y) {

  var s1_x, s1_y, s2_x, s2_y;
  s1_x = p1_x - p0_x;
  s1_y = p1_y - p0_y;
  s2_x = p3_x - p2_x;
  s2_y = p3_y - p2_y;

  var s, t;
  s = (-s1_y * (p0_x - p2_x) + s1_x * (p0_y - p2_y)) / (-s2_x * s1_y + s1_x * s2_y);
  t = ( s2_x * (p0_y - p2_y) - s2_y * (p0_x - p2_x)) / (-s2_x * s1_y + s1_x * s2_y);

  if (s >= 0 && s <= 1 && t >= 0 && t <= 1){
    // Collision detected
    return true;
  }

  return false; // No collision
}
