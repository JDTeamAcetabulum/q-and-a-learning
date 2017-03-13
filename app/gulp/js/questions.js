// Code to control adding/removing answer choices
$('body.questions.edit').ready(() => {
  let num = 10000; // We only support 10000 answers per question, get over it
  $('#add-answer').click((e) => {
    num -= 1;
    e.preventDefault();
    // Regexes here modify the duplicated div to create a unique hash
    // (by decrementing 1 from 10000)
    let newAnswer = $('#wrong-answers div:first-child').prop('outerHTML');
    newAnswer = newAnswer.replace(/_[0-9]+_/g, `_${num}_`);
    newAnswer = newAnswer.replace(/\[[0-9]+\]/g, `[${num}]`);
    newAnswer = newAnswer.replace(/value="*."/g, 'value=""');
    $('#wrong-answers').append(newAnswer);
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
