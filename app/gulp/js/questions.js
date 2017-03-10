// Code to control adding/removing answer choices
$('body.questions.edit').ready(() => {
  $('#add-answer').click((e) => {
    e.preventDefault();
    $('#wrong-answers').append($('#new-answer').html());
  });

  $('.remove-answer').click((e) => {
    e.preventDefault();
    $(e.target).parent().remove();
  });
});

// Code to initialize datatables in question list
$('body.questions.index').ready(() => {
  $('#question-table').DataTable();
});
