$('body.statistics.index').ready(() => {
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

    x.domain([0, d3.max(data, d => d.correct + d.incorrect)]);
    y.domain(data.map(d => d.label));

    svg.selectAll('.bar')
        .data(data)
      .enter().append('rect')
        .attr('class', 'bar')
        .attr('width', d => d.correct)
        .attr('y', d => y(d.label))
        .attr('height', y.bandwidth())
        .style('fill', d => color(d.label + 1));

    svg.append('g')
        .attr('transform', `translate(0,${height})`)
        .call(d3.axisBottom(x));

    svg.append('g')
        .call(d3.axisLeft(y));
  }

  function showStats() {
    const results = $('.stats_class').data('results');
    console.log(results);
    if (!results) {
      return;
    }
    const qstats = {};
    for (let i = 0; i < results.length; i += 1) {
      if (results[i].question_id) {
        if (!qstats[results[i].question_id]) {
          qstats[results[i].question_id] = [0, 0];
        }
        if (results[i].correct) {
          qstats[results[i].question_id][0] += 1;
        } else {
          qstats[results[i].question_id][1] += 1;
        }
      }
    }
    console.log(qstats);
    draw([
      { label: 'test', correct: '120', incorrect: '200' },
    ]);
  }
  showStats();
});
