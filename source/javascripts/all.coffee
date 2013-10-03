# google maps 
center_map = ->
  window.setTimeout (->
    map.panTo marker.getPosition()
  ), 500
myLatlng = new google.maps.LatLng(40.758890, -73.979366)
mapInitOpts =
  mapTypeId: google.maps.MapTypeId.ROADMAP
  center: myLatlng
  zoom: 12

map = new google.maps.Map(document.getElementById("my-location"), mapInitOpts)
marker = new google.maps.Marker(
  position: myLatlng
  map: map
  title: "My Office"
)
$(window).on "resize", (e) ->
  center_map()