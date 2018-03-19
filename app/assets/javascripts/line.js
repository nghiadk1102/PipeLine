var mark_index = true;
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  if(mark_index == true){
    $(link).parent().find(".colum_one").append(content.replace(regexp, new_id));
  } else {
    $(link).parent().find(".colum_two").append(content.replace(regexp, new_id));
  }
  swap_index();
}
$(document).ready(function() {
  $('body').on('click', '.delete_mark_field', function(){
    $(this).parent().remove();
  });

  $('body').on('click', '.show-line', function() {
    var line_id = $(this).data('id');
    if (map_line['line'] != null) {
      map_line['line'].setMap(null);
    }
    $.ajax({
      url: '/lines/' + line_id,
      type: 'GET',
      dataType: 'json',
      data: {id: line_id}
    })
    .done(function(result) {
      console.log("success");
      if(result['message'] === 'success'){
        map_line['line'] = createLine(result['data']['marks'], '', result['data']['color']);
        map_line['line'].setMap(map_line);
      }

    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });
    
  });
});

function swap_index(){
  mark_index = !mark_index;
}
