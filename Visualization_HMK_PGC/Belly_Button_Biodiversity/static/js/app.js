function buildMetadata(sample) {
  // Use `d3.json` to fetch the metadata for a sample
  // Use d3 to select the panel with id of `#sample-metadata`
  d3.json("/metadata/<sample>",function(error,data) {
    if (error) return console.warn(error);    
    console.log(data);
  });
  var Selectormetadata =   d3.select("#sample-metadata");
  // Use `.html("") to clear any existing metadata 
    Selectormetadata.html("");
    // Use `Object.entries` to add each key and value pair to the panel
    // Hint: Inside the loop, you will need to use d3 to append new
    // tags for each key-value in the metadata.
  Object.entries(data).forEach(([key,value])=>{
    Selectormetadata
    .append('p').text(`${key}: ${value}`)
    .append('hr')
  });
}
function buildCharts(sample) {
  // @TODO: Use `d3.json` to fetch the sample data for the plots
  d3.json('/sample/${sample}').then(data =>{
    // @TODO: Build a Pie Chart
    function pieChart(data); {
      console.log(data);
      var values = data.sample_values.slice(0,10);
      var labels = data.otu_ids.slice(0,10);
      var hovertext = data.otu_labels.slice(0,10);

      var trace = [{
        values : values,
        labels : labels,
        hovertext : hovertext,
        type : pie,
        textposition : inside
      }];

      var layout = {
        title : "Belly Button Pie Chart",
      };

      var colorScale = d3.scaleOrdinal.range(["#949c8d","#6e6557","#b8917a","#a69e77","#b9a29a"]);

      pie.colors(colorScale);

      Plotly.newPlot('pie','trace','layout','colorScale',{responsive:true});
  }

    // HINT: You will need o use slice() to grab the top 10 sample_values,
    // otu_ids, and labels (10 each).


    // @TODO: Build a Bubble Chart using the sample data

function init() {
  // Grab a reference to the dropdown select element
  var selector = d3.select("#selDataset");

  // Use the list of sample names to populate the select options
  d3.json("/names").then((sampleNames) => {
    sampleNames.forEach((sample) => {
      selector
        .append("option")
        .text(sample)
        .property("value", sample);
    });

    // Use the first sample from the list to build the initial plots
    const firstSample = sampleNames[0];
    buildCharts(firstSample);
    buildMetadata(firstSample);
  });
}

function optionChanged(newSample) {
  // Fetch new data each time a new sample is selected
  buildCharts(newSample);
  buildMetadata(newSample);
}

// Initialize the dashboard
init();