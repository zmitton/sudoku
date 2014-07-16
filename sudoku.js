/* PLAN
	
	each cell on ui is a field mapped via its id to a cell in the global board object.
	whenever a filed is updated the board resets (re-maps entirely) and undergoes the solver.

*/
var board = "g";

window.onload= function(){
	$(".table_cell").each(function(){
		console.log(this);
		input_field = document.createElement("input");
		input_field.setAttribute("type","text");
		input_field.setAttribute("maxlength","1");
		input_field.setAttribute("size","1");
		input_field.onfocus = function(){this.select();}
		input_field.onkeyup = board_changed;
		this.appendChild(input_field);

	});








}

function x(){
	for(i=0; i <= 1000000000 ; i++){
		z = 1+1;
	}
	//console.log("hello");
}

function y(){
	//console.log("hello2");

}

function board_changed(){
	//console.log("board changed");
	board = map_board_from_UI();
	board.run_solver();
	board.print_result();
	//console.log(this.parentNode.id);
	var next_cell = parseInt(this.parentNode.id) + 1;
	if(next_cell <= 81 ){
		//console.log(next_cell);
		document.getElementById(next_cell).childNodes[0].select();
	}
}

function map_board_from_UI(){
	//console.log("map_board_from_UI");
	return new Board();
}




function Board(){
	this.run_solver = function(){
		//console.log("run_solver");
	}
	this.print_result = function(){
		//console.log("print_result");
	}

	this.tri_square_arr = [];
	for(tri_square=0;tri_square<=2;tri_square++){
		var square_arr = [];
		for(square=0;square<=2;square++){
			var tri_cell_arr = [];
			for(tri_cell=0;tri_cell<=2;tri_cell++){
				var cell_arr = [];
				for(cell=0;cell<=2;cell++){
					id = tri_square*27 + square*3 + tri_cell*9 +cell + 1;
					cell_arr.push(document.getElementById(id).childNodes[0].value);
				}
				tri_cell_arr.push(cell_arr);
			}
			square_arr.push(tri_cell_arr);
		}
		this.tri_square_arr.push(square_arr);
	}
}







