lineColor = "#000";
lineWidth = 1;
//pitchColor = "#eee";
pitchColor = "white";
pitchMultiplier = 8;
pitchWidth = 105;
pitchHeight = 68;
margin = ({top: 20, right: 20, bottom: 20, left: 20});
width = pitchWidth * pitchMultiplier;
height = pitchHeight * pitchMultiplier;

const pitch = svg.append('g')
  .attr('transform', `translate(${margin.left},${margin.right})`);
  
pitch.append('rect')
    .attr('x', -margin.left)
    .attr('y', -margin.top)
    .attr('width', width + margin.left + margin.right)
    .attr('height', height + margin.top + margin.bottom)
    .style('fill', pitchColor);

getPitchLines = function () {
  const lines = [];
  // left penalty box
  lines.push({x1: 0, x2: 16.5, y1: pitchHeight/2 - 11 - 9.15, y2: pitchHeight/2 - 11 - 9.15});
  lines.push({x1: 16.5, x2: 16.5, y1: 13.85, y2: pitchHeight/2 + 11 + 9.15});
  lines.push({x1: 0, x2: 16.5, y1: pitchHeight/2 + 11 + 9.15, y2: pitchHeight/2 + 11 + 9.15});
  // left six-yard box
  lines.push({x1: 0, x2: 5.5, y1: pitchHeight/2 - 9.15, y2: pitchHeight/2 - 9.15});
  lines.push({x1: 5.5, x2: 5.5, y1: pitchHeight/2 - 9.15, y2: pitchHeight/2 + 9.15});
  lines.push({x1: 0, x2: 5.5, y1: pitchHeight/2 + 9.15, y2: pitchHeight/2 + 9.15});
  // right penalty box
  lines.push({x1: pitchWidth - 16.5, x2: pitchWidth, y1: pitchHeight/2 - 11 - 9.15, y2: pitchHeight/2 - 11 - 9.15});
  lines.push({x1: pitchWidth - 16.5, x2: pitchWidth - 16.5, y1: pitchHeight/2 - 11 - 9.15, y2: pitchHeight/2 + 11 + 9.15});
  lines.push({x1: pitchWidth - 16.5, x2: pitchWidth, y1: pitchHeight/2 + 11 + 9.15, y2: pitchHeight/2 + 11 + 9.15});
  // right six-yard box
  lines.push({x1: pitchWidth - 5.5, x2: pitchWidth, y1: pitchHeight/2 - 9.15, y2: pitchHeight/2 - 9.15});
  lines.push({x1: pitchWidth - 5.5, x2: pitchWidth - 5.5, y1: pitchHeight/2 - 9.15, y2: pitchHeight/2 + 9.15});
  lines.push({x1: pitchWidth - 5.5, x2: pitchWidth, y1: pitchHeight/2 + 9.15, y2: pitchHeight/2 + 9.15});
  // outside borders
  lines.push({x1: 0, x2: pitchWidth, y1: 0, y2: 0});
  lines.push({x1: 0, x2: pitchWidth, y1: pitchHeight, y2: pitchHeight});
  lines.push({x1: 0, x2: 0, y1: 0, y2: pitchHeight});
  lines.push({x1: pitchWidth, x2: pitchWidth, y1: 0, y2: pitchHeight});
  // middle line
  lines.push({x1: pitchWidth/2, x2: pitchWidth/2, y1: 0, y2: pitchHeight});
  // left goal
  lines.push({x1: -1.5, x2: -1.5, y1: pitchHeight/2 - 7.32/2, y2: pitchHeight/2 + 7.32/2});
  lines.push({x1: -1.5, x2: 0, y1: pitchHeight/2 - 7.32/2, y2: pitchHeight/2 - 7.32/2});
  lines.push({x1: -1.5, x2: 0, y1: pitchHeight/2 + 7.32/2, y2: pitchHeight/2 + 7.32/2});
  // right goal
  lines.push({x1: pitchWidth + 1.5, x2: pitchWidth + 1.5, y1: pitchHeight/2 - 7.32/2, y2: pitchHeight/2 + 7.32/2});
  lines.push({x1: pitchWidth, x2: pitchWidth + 1.5, y1: pitchHeight/2 - 7.32/2, y2: pitchHeight/2 - 7.32/2});
  lines.push({x1: pitchWidth, x2: pitchWidth + 1.5, y1: pitchHeight/2 + 7.32/2, y2: pitchHeight/2 + 7.32/2});
  return lines;
};

getPitchCircles2 = function () {
  const circles = [];
  // center circle
  circles.push({cx: pitchWidth/2, cy: pitchHeight/2, r: 9.15, color: 'none'});
  // // left penalty spot
  // circles.push({cx: 11, cy: pitchHeight/2, r: 0.3, color: lineColor});
  // // right penalty spot
  // circles.push({cx: pitchWidth - 11, cy: pitchHeight/2, r: 0.3, color: lineColor});
  // // kick-off circle
  circles.push({cx: pitchWidth/2, cy: pitchHeight/2, r: 0.3, color: lineColor});
  return circles;
};

getArcs = function () {
  const arcs = [];
  const cornerRadius = 1 * pitchMultiplier;
  const penaltyRadius = 9.15 * pitchMultiplier;
  // left top corner
  arcs.push({arc: {innerRadius: cornerRadius, outerRadius: cornerRadius + lineWidth, startAngle: 1/2 * Math.PI, endAngle: Math.PI}, 'x': 0, 'y': 0});
  // left bottom corner
  arcs.push({arc: {innerRadius: cornerRadius, outerRadius: cornerRadius + lineWidth, startAngle: 1/2 * Math.PI, endAngle: 0}, 'x': 0, 'y': pitchHeight});
  // right top corner
  arcs.push({arc: {innerRadius: cornerRadius, outerRadius: cornerRadius + lineWidth, startAngle: 3/2 * Math.PI, endAngle: Math.PI}, 'x': pitchWidth, 'y': 0});
  // right bottom corner
  arcs.push({arc: {innerRadius: cornerRadius, outerRadius: cornerRadius + lineWidth, startAngle: 2 * Math.PI, endAngle: 3/2 * Math.PI}, 'x': pitchWidth, 'y': pitchHeight});
  // left penalty arc
  arcs.push({arc: {innerRadius: penaltyRadius, outerRadius: penaltyRadius + lineWidth, startAngle: Math.sin(6.5/9.15), endAngle: Math.PI - Math.sin(6.5/9.15)}, 'x': 11, 'y': pitchHeight/2});
  // right penalty arc
  arcs.push({arc: {innerRadius: penaltyRadius, outerRadius: penaltyRadius + lineWidth, startAngle: -Math.sin(6.5/9.15), endAngle: -(Math.PI - Math.sin(6.5/9.15))}, 'x': pitchWidth - 11, 'y': pitchHeight/2});
  return arcs;
};
    
const pitchLineData = getPitchLines();
pitch.selectAll('.pitchLines')
    .data(pitchLineData)
  .enter().append('line')
    .attr('x1', d => d['x1'] * pitchMultiplier)
    .attr('x2', d => d['x2'] * pitchMultiplier)
    .attr('y1', d => d['y1'] * pitchMultiplier)
    .attr('y2', d => d['y2'] * pitchMultiplier)
    .style('stroke-width', lineWidth)
    .style('stroke', lineColor);
    
const pitchCircleData = getPitchCircles2();
pitch.selectAll('.pitchCircles')
    .data(pitchCircleData)
  .enter().append('circle')
    .attr('cx', d => d['cx'] * pitchMultiplier)
    .attr('cy', d => d['cy'] * pitchMultiplier)
    .attr('r', d => d['r'] * pitchMultiplier)
    .style('stroke-width', lineWidth)
    .style('stroke', lineColor)
    .style('fill', d => d['color']);
    
const pitchArcData = getArcs();
const arc = d3.arc();
pitch.selectAll('.pitchCorners')
    .data(pitchArcData)
  .enter().append('path')
    .attr('d', d => arc(d['arc']))
    .attr('transform', d => `translate(${pitchMultiplier * d.x},${pitchMultiplier * d.y})`)
    .style('fill', lineColor);    

markerBoxWidth = 15;
markerBoxHeight = 15;
refX = markerBoxWidth / 2;
refY = markerBoxHeight / 2;
markerWidth = markerBoxWidth / 2;
markerHeight = markerBoxHeight / 2;
arrowPoints = [[0, 0], [0, 15], [15, 7.5]];  
    
svg.append('defs')
  .append('marker')
  .attr('id', 'arrow')
  .attr('viewBox', [0, 0, markerBoxWidth, markerBoxHeight])
  .attr('refX', refX)
  .attr('refY', refY)
  .attr('markerWidth', markerBoxWidth)
  .attr('markerHeight', markerBoxHeight)
  .attr('orient', 'auto-start-reverse')
  .append('path')
  .attr('d', d3.line()(arrowPoints))
  .attr('stroke', 'black');

svg.append('path')
  .attr('d', d3.line()([[(width + margin.left + margin.right)/3, height + margin.bottom*3/2], [(width + margin.left + margin.right)*2/3, height + margin.bottom*3/2]]))
  .attr('stroke', 'black')
  .attr('marker-end', 'url(#arrow)')
  .attr('fill', 'none');   

svg.append("text")
  .attr("class", "title")
  .attr("x", (width / 10))             
  .attr("y", 0 + (margin.top / 2))
  .attr("text-anchor", "left")  
  .style("font-size", "12px") 
  .style("font-weight","bold")
  .text("Messi Carry Transitions");

pitch.selectAll("g.myGroup")
    .data(data)
    .enter()
    .append('rect')
    .attr("class", "zone")
    .attr('x', d => d.x1)
    .attr('y', d => d.y1)
    .attr('width', d => d.width)
    .attr('height', d => d.height)
    .attr('fill-opacity', '0.6')
    .attr("id", function (d) {return (d.area_origin)})
    .attr("ratio_origin", function (d) {return (d.ratio_origin)})
    .style('fill', d => d3.interpolateGreens(d.ratio_origin * 20));

svg.selectAll(".zone")
  .on("mouseover", function(d, i) {
    var select_id = d3.select(this).attr("id");
    var select_ratio = d3.select(this).attr("ratio_origin") * 100;
    var format = d3.format(".2f");

    d3.select(this)
      .style("stroke", "orange")
      .style("stroke-width", 1);
    
    svg.selectAll(".title")
      .text("Messi Carry Transitions - " + format(select_ratio).toString() + "% of carries originate from this zone");
      
    svg.selectAll(".zone")
    .datum(data[(select_id-1).toString()])
    .each(function (d, i) {
      var select_id = d3.select(this).attr("id");
      
      d3.select(this)
        .attr('fill-opacity', '0.6')
        .style("fill", d => d3.interpolateGreens(d[(select_id).toString()] * 10));   
      });
    })
    .on("mouseleave", function(d) {
      d3.select(this)
        .style("stroke", "none");
      
      svg.selectAll(".title")
      .text("Messi Carry Transitions");
      
      svg.selectAll(".zone")
        .data(data)
        .attr('fill-opacity', '0.6')
        .style('fill', d => d3.interpolateGreens(d.ratio_origin * 20));
    });     


