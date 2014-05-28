$(document).ready ->

    $("a.title_tip").qtip
      position:
        my: 'bottom center'
        at: 'top center'
      style:
        classes: 'qtip-light qtip-rounded'
      content:
        text: (event, api) ->
          ($(this).attr "title") + ' ' + ($(this).attr "_desc")

    # google maps
    center_map = ->
      window.setTimeout (->
        map.panTo marker.getPosition()
      ), 500
    myLatlng = new google.maps.LatLng(50.2642, 19.0235)
    mapInitOpts =
      mapTypeId: google.maps.MapTypeId.ROADMAP
      center: myLatlng
      zoom: 12

    map = new google.maps.Map(document.getElementById("my-location"), mapInitOpts)
    marker = new google.maps.Marker(
      position: myLatlng
      map: map
    )
    $(window).on "resize", (e) ->
      center_map()
