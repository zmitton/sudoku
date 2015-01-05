var app = angular.module('sudoku', []);

var cellValues = Array.apply(null, Array(81)).map(function() { return "" });

app.controller('SudokuCtrl', function($scope, $http) {
  var cells = [];
   for (var i = 0; i < cellValues.length; i++ ) {
        if (i % 9 == 0) cells.push([]);
        cells[cells.length-1].push(cellValues[i]);
    }
  return $scope.cells = cells;
});




    

