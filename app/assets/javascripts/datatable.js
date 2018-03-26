$(document).ready(function() {
  $('#dataTable').DataTable({
    destroy: true,
    order: [],
    columnDefs: [
      {orderable: false, targets: 'id', width: '5%'},
      {orderable: false, targets: 'action', width: '9%', className: 'dt-center'},
      {targets: 'size-safe', width: '10%', className: 'dt-center'},
      {targets: 'create_date', width: '20%'}
    ],
    pageLength: 10
  });
});
