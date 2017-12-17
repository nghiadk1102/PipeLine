function initMap() {
  var uluru = {lat: 21.043285, lng: 105.793673};
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: uluru,
    gestureHandling: 'greedy'
  });
  var path_electric = [
    {lat: 21.041651, lng: 105.790629},
    {lat: 21.041617, lng: 105.790835},
    {lat: 21.041606, lng: 105.790987},
    {lat: 21.041603, lng: 105.791075},
    {lat: 21.041608, lng: 105.791182},
    {lat: 21.041606, lng: 105.791280},
    {lat: 21.041609, lng: 105.791395},
    {lat: 21.041612, lng: 105.791510},
    {lat: 21.041611, lng: 105.791581},
    {lat: 21.041624, lng: 105.791774},
    {lat: 21.041716, lng: 105.791771},
    {lat: 21.041824, lng: 105.791767},
    {lat: 21.041897, lng: 105.791766},
    {lat: 21.042025, lng: 105.791762}
  ];
  var electric_path = new google.maps.Polyline({
    path: path_electric,
    geodesic: true,
    strokeColor: '#FF0000',
    strokeOpacity: 1.0,
    strokeWeight: 2
  });
  electric_path.addListener('click', function () {
     getPathVariableCode(electric_path);
 });
  electric_path.setMap(map);
}
