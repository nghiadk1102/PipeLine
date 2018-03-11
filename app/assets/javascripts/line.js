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
});

function swap_index(){
  mark_index = !mark_index;
}
