var width = 600;
var height = 400;

var datapoint = data['1'];

var x = d3.scaleLinear()
  .domain([0, d3.max(datapoint, d => d.x)])
  .range([0, width]);

var y = d3.scaleLinear()
  .domain([0, d3.max(datapoint, d => d.h)])
  .range([0, height]);

var svg = d3.select('#wave')
  .append('svg')
    .attr('width', width)
    .attr('height', height)
    .attr('transform', 'scale(1,-1)')
    .style('border', '1px solid #ccc')

var waterlevel = svg.append('g');
var wave = svg.append('g');

wave.selectAll('path.line')
  .data([datapoint]).enter()
  .append('path')
  .attr('d', d3.line()
    .x(function(d) { return x(d.x); })
    .y(function(d) { return y(d.h); })
    .curve(d3.curveBasis))
  .attr('fill', '#007cc4');
