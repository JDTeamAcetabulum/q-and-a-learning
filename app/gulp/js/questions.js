// Code to control adding/removing answer choices
// onPage('questions', 'edit', () => {
// Needs to be on both edit AND new
let num = 10000; // We only support 10000 answers per question, get over it
$(document).on('click', '#add-answer', (e) => {
  num -= 1;
  e.preventDefault();
  // Regexes here modify the duplicated div to create a unique hash
  // (by decrementing 1 from 10000)
  let newAnswer = $('#wrong-answers div:last-child').prop('outerHTML');
  newAnswer = newAnswer.replace(/_[0-9]+_/g, `_${num}_`);
  newAnswer = newAnswer.replace(/\[[0-9]+\]/g, `[${num}]`);
  newAnswer = newAnswer.replace(/value="*."/g, 'value=""');
  $('#wrong-answers').append(newAnswer);
});

$(document).on('click', 'button.remove-answer', (e) => {
  e.preventDefault();
  $(e.target).parent().remove();
});
// });

$('body.questions.export').ready(() => {
  $('#by-lecture').click((e) => {
    e.preventDefault();
    $('#lecture-options').show();
  });

  $('#by-topic').click((e) => {
    e.preventDefault();
    $('#topic-options').show();
  });

  $('#by-question').click((e) => {
    e.preventDefault();
    $('#question-options').show();
  });
});

// Code to initialize datatables in question list
onPage('questions', 'index', () => {
  $('#question-table').DataTable();
});

onPage('questions', 'show', () => {
  function draw(data) {
    const color = d3.scaleOrdinal(d3.schemeCategory20b);
    const margin = { top: 20, right: 20, bottom: 30, left: 80 };
    const width = 480 - margin.left - margin.right;
    const height = 250 - margin.top - margin.bottom;

    const y = d3.scaleBand()
    .range([height, 0])
    .padding(0.1);

    const x = d3.scaleLinear()
    .range([0, width]);

    const svg = d3.select('#graph')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
    .append('g')
      .attr('transform',
            `translate(${margin.left},${margin.top})`);

    x.domain([0, d3.max(data, d => d.value)]);
    y.domain(data.map(d => d.label));

    svg.selectAll('.bar')
      .data(data)
    .enter().append('rect')
      .attr('class', 'bar')
      .attr('width', d => x(d.value))
      .attr('y', d => y(d.label))
      .attr('height', y.bandwidth())
      .style('fill', d => color(d));

    svg.append('g')
      .attr('transform', `translate(0,${height})`)
      .call(d3.axisBottom(x));

    svg.append('g')
      .call(d3.axisLeft(y));
  }

  function answerQuestion() {
    const results = $('.question_class').data('results');
    const answers = $('.question_class').data('answers');
    const values = [];
    for (let i = 0; i <= answers.length; i += 1) {
      if (answers[i]) {
        const id = answers[i].id;
        if (results[id]) {
          values.push({ label: answers[i].content, value: results[id] });
        } else {
          values.push({ label: answers[i].content, value: 0 });
        }
      }
    }
    draw(values);
    $('#review').show();
  }
  $('#show-results').click((e) => {
    e.preventDefault();
    answerQuestion();
  });
});
