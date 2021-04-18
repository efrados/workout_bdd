// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap/js/src/alert'  
 import 'bootstrap/js/src/button'  
// import 'bootstrap/js/src/carousel'  
import 'bootstrap/js/src/collapse'  
import 'bootstrap/js/src/dropdown'  
// import 'bootstrap/js/src/modal'  
// import 'bootstrap/js/src/popover'  
import 'bootstrap/js/src/scrollspy'  
// import 'bootstrap/js/src/tab'  
// import 'bootstrap/js/src/toast'  
// import 'bootstrap/js/src/tooltip'
import 'bootstrap-icons/font/bootstrap-icons.css'
import { scaleLinear, scaleTime } from 'd3-scale'
import { select, selectAll, mouse,event } from 'd3-selection'
import { min, max, extent, range } from 'd3-array'
import { timer } from 'd3-timer'
import { timeDay } from 'd3-time'
import { line, curveMonotoneX } from 'd3-shape'
import { json,csv } from 'd3-fetch'
import { axis,axisBottom,axisLeft } from 'd3-axis'
import { timeParse, timeFormat} from 'd3-time-format'
import { randomUniform } from 'd3-random'
window.d3 = Object.assign(
  {},
  {
    scaleLinear,
    scaleTime,
    axis,
    axisBottom,
    axisLeft,
    curveMonotoneX,
    extent,
    event,
    json,
    csv,
    line,
    max,
    min,
    mouse,
    range,
    randomUniform,
    select,
    selectAll,
    timer,
    timeParse,
    timeFormat
  }
)
require("flatpickr")


Rails.start()
Turbolinks.start()
ActiveStorage.start()
document.addEventListener("turbolinks:load", () => {
  flatpickr("[class='flatpickr form-control']",{
      altInput: true,
      altFormat:"F j Y",
      dateFormat:"Y-m-d",
  });
    var regex = /\/users\/\d+\/exercises$/i;
  if(location.pathname.match(regex)) {
    drawChart();
  }
});

 var drawChart = function() {
  var margin = { top: 100, right: 20, bottom: 100, left: 50 },
      width  = 600 - margin.left - margin.right,
      height = 450 - margin.top - margin.bottom;
  var JSONData = document.querySelector('#chart').dataset.workouts;
 
  if (!JSONData) {
    return;
  }
  // var data = JSONData.slice()
  var data = JSON.parse(JSONData);
  
  var parseTime = d3.timeParse("%Y-%m-%d");
  
  var workoutFn = function(d) { return d.duration_in_min }

  var dateFn = function(d) { return parseTime(d.workout_date) }
  
  var x = d3.scaleTime()
    .range([0, width])
    .domain(d3.extent(data, dateFn))
  
  var y = d3.scaleLinear()
    .range([height, 0])
    .domain([0, d3.max(data, workoutFn)])
  
  var workout_line = d3.line()
      .x(function(d) { return x(d.workout_date); })
      .y(function(d) { return y(d.duration_in_min);  });

  for (let d in data) {
    data[d].workout_date = parseTime(data[d].workout_date);
    data[d].duration_in_min = +data[d].duration_in_min;
  }
// create a tooltip
    var Tooltip = d3.select("#chart")
      .append("div")
      .style("opacity", 0)
      .attr("class", "tooltip")
      .style("background-color", "white")
      .style("border", "solid")
      .style("border-width", "2px")
      .style("border-radius", "5px")
      .style("padding", "5px")
    
      // Three function that change the tooltip when user hover / move / leave a cell
      var mouseover = function(d) {
        Tooltip
          .style("opacity", 1)
      }
      var mousemove = function(d, workout) {
        Tooltip
          .html("Workout Date: " + workout.workout_date.getDate() +
                " <br /> Duration(min): " + workout.duration_in_min +
                " <br /> Workout Details: " + workout.workout)
          .style("left", (d.pageX) + 15 + "px")
          .style("top", (d.pageY) + 15 + "px")
      }
      var mouseleave = function(d) {
        Tooltip
          .style("opacity", 0)
      }
  var svg = d3.select("#chart").append("svg")
  .attr("width", width + margin.left + margin.right)
  .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
  
    svg.append("path")
        .attr("class", "line")
        .attr("fill", "none")
        .attr("stroke", "steelblue")
        .attr("stroke-width", 1.5)
        .attr("d", workout_line(data));

    svg
      .append("g")
      .selectAll("dot")
      .data(data)
      .enter()
      .append("circle")
        .attr("class", "myCircle")
        .attr("cx", function(d) { return x(d.workout_date) } )
        .attr("cy", function(d) { return y(d.duration_in_min) } )
        .attr("r", 7)
        .attr("stroke", "#69b3a2")
        .attr("stroke-width", 3)
        .attr("fill", "white")
        .on("mouseover", mouseover)
        .on("mousemove", mousemove)
        .on("mouseleave", mouseleave)

  svg.append("g")
   .attr("class", "x axis")
   .attr("transform", "translate(0," + height + ")")
   .call(d3.axisBottom(x)
      .tickFormat(d3.timeFormat('%Y-%m-%d'))
    )
   .selectAll("text")
      .style("text-anchor", "end")
      .attr("dx", "-.8em")
      .attr("dy", ".15em")
      .attr("transform", "rotate(-60)");
  
   // x axis label
   svg.append("text")
      .attr("x", width / 2)
      .attr("y", height + margin.top - 15)
      .style("text-anchor", "middle")
      .text("Date of workout")
  
   svg.append("g")
    .attr("class", "y axis")
    .call(d3.axisLeft(y).ticks(4));
  
  // y axis label
  svg.append("text")
     .attr("transform", "rotate(-90)")
     .attr("y", 0 - margin.left)
     .attr("x", 0 - (height / 2))
     .attr("dy", "1em")
     .style("text-anchor", "middle")
     .text("Workout duration (min)")
  
   // Chat title
   svg.append("text")
      .attr("x", (width / 2))
      .attr("y", 0 - (margin.top / 2))
      .style("text-anchor", "middle")
      .style("font-size", "18px")
      .style("text-decoration", "underline")
      .text("Workout duration vs Workout date")
};
