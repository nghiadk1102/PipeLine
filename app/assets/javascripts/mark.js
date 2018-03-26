$(document).ready(function() {
  $('body').on('click', '.show-mark', function(){
    var that = $(this);
    var mark = createMark(that.data('mark'), map_line);
    mark.setMap(map_line);
  });
});
