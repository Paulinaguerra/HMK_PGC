// from data.js
var ufosTable = data;
var contentUfo = d3.select('#content-ufo');

//create table , using 
function buildTable(data){ 
//    console.log(data);
    console.log(contentUfo);
    contentUfo.html("")
    data.forEach((sighting) => {
        var row = contentUfo.append("tr");
        Object.entries(sighting).forEach(([key,value]) => {
            var cell = contentUfo.append("td");
            cell.text(value);        
        });
    });
};

var submit = d3.select('#submit');
console.log()

buildTable(ufosTable)

//Click function
submit.on('click',function() {

//no refreshing 
d3.event.preventDefault();

//select the input element and get the raw HTML node
var inputElement = d3.select('#datetime');

var inputValue = inputElement.property('value');
console.log(inputValue)

var filterData = ufosTable.filter(sight => sight.datetime === inputValue);
console.log(filterData);
buildTable(filterData)
});

