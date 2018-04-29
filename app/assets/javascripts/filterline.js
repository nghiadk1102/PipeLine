$(document).ready(function() {

  $('body').on('click', '.filterline .btn-submit', function(e){
    e.preventDefault();
    form_data = new FormData($(this).closest('.filterline')[0]);
    resetMap();
    $.ajax({
      url: '/filterline',
      method: 'POST',
      dataType: 'JSON',
      processData: false,
      contentType: false,
      data: form_data
    }).done(function(result){
      if(result.message == "successfully"){
        var data = result.data; //list pipeline
        $.each(data, function(key, value){ //each pipelines
          var pipelineName = key;
          $.each(value, function(key, value){ //each lines
            $.each(value, function(key, value){ //each marks
              var lineName = key;
              var line = createLine(value['marks'], pipelineName, value['color'], value['id'], lineName);
              line.setMap(map);
              list_line.push(line);
            });
          });
        });
      }
    });
  });

  function resetMap(){
    if(list_line != null){
      list_line.forEach(function(line, index) {
        line.setMap(null);
      });
    }
  }

  $('.hide-filter').click(function(){
    $(this).closest('.filter').find('.filter-content').toggle('slow');
  })
});
