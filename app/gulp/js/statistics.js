$('body.statistics.index').ready(() => {
  function draw(data) {
    const h = $('#graph').height();
    const th = $('#title').outerHeight(true);
    $('#graph').height(h - th);
    const element = document.getElementById('graph');

    const margin = { top: 20, right: 20, bottom: 30, left: 40 };
    const width = element.clientWidth - margin.left - margin.right;
    const height = element.clientHeight - margin.top - margin.bottom;

    const svg = d3.select(element)
      .append('g')
        .attr('transform',
              `translate(${margin.left},${margin.top})`);

    const div = d3.select('body').append('div')
        .attr('class', 'tooltip')
        .style('opacity', 0);

    const xScale = d3.scaleBand()
      .range([0, width])
      .padding(0.1);

    const yScale = d3.scaleLinear()
      .range([height, 0]);

    const color = d3.scaleOrdinal(d3.schemeCategory10);

    const xAxis = d3.axisBottom(xScale);
    const integers = [];
    for (let i = 0; i < 1000; i += 1) {
      integers.push(i);
    }
    const yAxis = d3.axisLeft(yScale).tickValues(integers);

    const stack = d3.stack()
      .keys(['correct', 'incorrect']);

    const layers = stack(data);

    xScale.domain(data.map(d => d.label));
    yScale.domain([0, d3.max(layers[layers.length - 1], d => d[0] + d[1])]).nice();

    const layer = svg.selectAll('.layer')
      .data(layers)
      .enter().append('g')
      .attr('class', 'layer')
      .style('fill', (d, i) => color(i));

    layer.selectAll('rect')
        .data(d => d)
      .enter().append('rect')
        .attr('x', d => xScale(d.data.label))
        .attr('y', d => yScale(d[1]))
        .attr('width', xScale.bandwidth())
        .attr('height', d => (yScale(d[0]) - yScale(d[1])))
        .on('mousemove', function tooltipMove(d) {
          d3.select(this).attr('opacity', 0.5);
          div.transition()
            .duration(20)
            .style('opacity', 0.9);
          if (d[0] === 0 && d[1] === d.data.correct) {
            div.html(`Q: ${d.data.label}<br/>Correct:${
                d[1] - d[0]}`);
          } else {
            div.html(`Q: ${d.data.label}<br/>Incorrect:${
                d[1] - d[0]}`);
          }
          div.style('left', `${d3.event.pageX + 15}px`)
            .style('top', `${d3.event.pageY - 20}px`);
        })
        .on('mouseout', function tooltipHide() {
          d3.select(this).attr('opacity', 1);
          div.transition()
            .duration(20)
            .style('opacity', 0);
        });

    svg.append('g')
        .attr('class', 'axis axis--x')
        .attr('transform', `translate(0,${height + 5})`)
        .call(xAxis);

    svg.append('g')
        .attr('class', 'axis axis--y')
        .attr('transform', 'translate(0,0)')
        .call(yAxis);

    svg.append('text')
        .attr('class', 'y label')
        .attr('text-anchor', 'end')
        .attr('y', 6)
        .attr('dy', '.75em')
        .attr('transform', 'rotate(-90)')
        .text('Total Answers');

    svg.append('text')
        .attr('class', 'x label')
        .attr('text-anchor', 'end')
        .attr('x', width)
        .attr('y', height - 6)
        .text('Questions');
  }

  function showStats() {
    const statsData = $('.stats-data');
    if (statsData.length === 0) { return; }

    const rawData = statsData.data();
    const results = rawData.results;
    const q = rawData.questions;
    const questions = {};

    for (let i = 0; i < q.length; i += 1) {
      questions[q[i].id] = q[i];
    }

    const qstats = {};
    for (let i = 0; i < results.length; i += 1) {
      if (results[i].question_id) {
        if (!qstats[results[i].question_id]) {
          qstats[results[i].question_id] = { label: questions[results[i].question_id].content,
            correct: 0,
            incorrect: 0 };
        }
        if (results[i].correct) {
          qstats[results[i].question_id].correct += 1;
        } else {
          qstats[results[i].question_id].incorrect += 1;
        }
      }
    }
    const data = $.map(qstats, v => [v]);
    draw(data);
  }

  showStats();
});
