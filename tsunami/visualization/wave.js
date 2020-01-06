var margin = 20;
var width = 600;
var height = 400;

var x = d3.scaleLinear()
  .domain([0, d3.max(data.get(1), d => d.x)])
  .range([0, width]);

var y = d3.scaleLinear()
  .domain([0, d3.max(data.get(1), d => d.h)])
  .range([0, height]);

var svg = d3.select('#wave')
  .append('svg')
    .attr('width', width + 2 * margin)
    .attr('height', height + 2 * margin)
    .attr('transform', 'scale(1,-1)')
    .style('border', '1px solid #ccc')

var waterlevel = svg.append('g');
var wave = svg.append('g');

var keys = Array.from(data.keys());
var t_first = keys[0];
var t_last = keys[keys.length - 1];

console.log(t_first + '...' + t_last);

wave.selectAll('path.line')
  .data([data.get(t_first)]).enter()
  .append('path')
  .attr('d', d3.line()
    .x(function(d) { return x(d.x) + margin; })
    .y(function(d) { return y(d.h) + margin; })
    .curve(d3.curveBasis))
  .attr('fill', '#007cc4');

var slider = svg.append('g')
    .attr('class', 'slider')
    .attr('transform', 'translate(5,20)')
    ;

slider.append('line')
    .attr('class', 'track')
    .attr('x1', x.range()[0] + margin)
    .attr('x2', x.range()[1] + margin)
  .select(function() { return this.parentNode.appendChild(this.cloneNode(true)); })
    .attr('class', 'track-inset')
  .select(function() { return this.parentNode.appendChild(this.cloneNode(true)); })
    .attr('class', 'track-overlay')
    .call(d3.drag()
        .on('start.interrupt', function() { slider.interrupt(); })
        .on('start drag', function() { makeWave(x.invert(d3.event.x)); }));

slider.insert('g', '.track-overlay')
    .attr('class', 'ticks');

var handle = slider.insert('circle', '.track-overlay')
    .attr('class', 'handle')
    .attr('r', 9);

function makeWave(t) {
  handle.attr('cx', x(t));

  wave.selectAll('path.line')
    .attr('fill', '#fff');

  wave.selectAll('path.line')
    .data([data.get(t)]).enter()
    .append('path')
    .transition().duration(1000)
    .attr('d', d3.line()
      .x(function(d) { return x(d.x) + margin; })
      .y(function(d) { return y(d.h) + margin; })
      .curve(d3.curveBasis))
    .attr('fill', '#007cc4');
}
