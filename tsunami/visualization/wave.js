var data = [
  { x: 1,  y: 0.10 },
  { x: 10, y: 0.19 },
  { x: 20, y: 0.30 },
  { x: 30, y: 0.50 },
  { x: 40, y: 0.67 },
  { x: 50, y: 0.90 },
  { x: 60, y: 0.98 },
  { x: 70, y: 0.81 },
  { x: 80, y: 0.60 },
  { x: 90, y: 0.43 },
  { x: 99, y: 0.12 },
];

var width = 600;
var height = 400;

var x = d3.scaleLinear()
  .domain([0, d3.max(data, d => d.x)])
  .range([0, width]);

var y = d3.scaleLinear()
  .domain([0, d3.max(data, d => d.y)])
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
  .data([data]).enter()
  .append('path')
  .attr('d', d3.line()
    .x(function(d) { return x(d.x); })
    .y(function(d) { return y(d.y); })
    .curve(d3.curveBasis))
  .attr('fill', '#007cc4');
