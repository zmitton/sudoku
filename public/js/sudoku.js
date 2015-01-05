var board = "g";

window.onload = function() {
    $(".table_cell").each(function() {
        console.log(this);
        input_field = document.createElement("input");
        input_field.setAttribute("type", "text");
        input_field.setAttribute("maxlength", "1");
        input_field.setAttribute("size", "1");
        input_field.onfocus = function() {
            this.select();
        }
        input_field.onkeyup = board_changed;
        this.appendChild(input_field);

    });
    if (document.getElementById("solution_string")) {
        fill_board_with_solution();
    }

}

function x() {
    for (i = 0; i <= 1000000000; i++) {
        z = 1 + 1;
    }
    //console.log("hello");
}

function y() {
    //console.log("hello2");

}

function board_changed() {
    //console.log("board changed");
    board = map_board_from_UI();
    board.run_solver();
    board.print_result();
    //console.log(this.parentNode.id);
    var next_cell = parseInt(this.parentNode.id) + 1;
    if (next_cell <= 81) {
        //console.log(next_cell);
        document.getElementById(next_cell).childNodes[0].select();
    }
}

function map_board_from_UI() {
    //console.log("map_board_from_UI");
    return new Board();
}


function Board() {
    this.run_solver = function() {
        //console.log("run_solver");
    }
    this.print_result = function() {
        //console.log("print_result");
    }

    this.tri_square_arr = [];
    for (tri_square = 0; tri_square <= 2; tri_square++) {
        var square_arr = [];
        for (square = 0; square <= 2; square++) {
            var tri_cell_arr = [];
            for (tri_cell = 0; tri_cell <= 2; tri_cell++) {
                var cell_arr = [];
                for (cell = 0; cell <= 2; cell++) {
                    id = tri_square * 27 + square * 3 + tri_cell * 9 + cell + 1;
                    cell_arr.push(document.getElementById(id).childNodes[0].value);
                }
                tri_cell_arr.push(cell_arr);
            }
            square_arr.push(tri_cell_arr);
        }
        this.tri_square_arr.push(square_arr);
    }
}


function go() {
    var url = "/"
    var string = make_string();
    window.location.href = url + string;
}

function make_string() {
    user_string = ""
    for (i = 1; i <= 81; i++) {
        cell_value = document.getElementById(i).childNodes[0].value
        if (cell_value == "")
            cell_value = "0";
        user_string += cell_value;
    }
    console.log(user_string);
    return user_string;
}


function fill_board_with_solution() {
    for (i = 1; i <= 81; i++) {
        cell = document.getElementById(i).childNodes[0]
        cell.value = document.getElementById("solution_string").innerHTML.charAt(i - 1);
        console.log(document.getElementById("solution_string").innerHTML.charAt(i - 1));
    }
}
