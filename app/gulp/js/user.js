onPage('users', 'show', () => {
  $('#student-answers-table').DataTable();

  const pageData = $('#student-data').data();
  const dataset = [
    { label: 'correct', count: pageData.numcorrect },
    { label: 'incorrect', count: pageData.numincorrect },
  ];

  const color = d3.scaleOrdinal(d3.schemeCategory20b);

  const width = 300;
  const height = 300;
  const donutSize = 50;
  const radius = Math.min(width, height) / 2;

  const legendRectSize = 18;
  const legendSpacing = 4;

  // Construct the initial SVG and center the coordinates
  const svg = d3.select('#num-correct-chart')
    .append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
    .attr('transform', `translate(${width / 2}, ${height / 2})`);

  const arc = d3.arc()
    .innerRadius(radius - donutSize)
    .outerRadius(radius);

  const pie = d3.pie()
    .value(d => d.count)
    .sort(null);

  // Path with the actual chart arcs
  svg.selectAll('path')
    .data(pie(dataset))
    .enter()
    .append('path')
    .attr('d', arc)
    .attr('fill', d => color(d.data.label));

  const legend = svg.selectAll('.legend')
    .data(color.domain())
    .enter()
    .append('g')
    .attr('class', 'legend')
    .attr('transform', (d, i) => {
      // Center the margin in the middle of the figure
      const legendHeight = legendRectSize + legendSpacing;
      const offset = legendHeight * color.domain().length / 2;
      // If the margin isn't centered horizontally, try adjusting the multiplier here
      const horz = -2.6 * legendRectSize;
      const vert = i * legendHeight - offset;
      return `translate(${horz}, ${vert})`;
    });

  legend.append('rect')
    .attr('width', legendRectSize)
    .attr('height', legendRectSize)
    .style('fill', color)
    .style('stroke', color);

  legend.append('text')
    .attr('x', legendRectSize + legendSpacing)
    .attr('y', legendRectSize - legendSpacing)
    .text((d, i) => `${d} (${dataset[i].count})`);
});
