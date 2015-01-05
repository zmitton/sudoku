window.onload = function() {
    if (document.getElementById("solution_string")) {
        fill_board_with_solution();
    }
}

function Board() {
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
    var string = make_string();
    window.location.href = "/" + string;
}

function make_string() {
    user_string = ""
    for (i = 1; i <= 81; i++) {
        cell_value = $('#' + i + ' input').val();
        if (cell_value == "")
            cell_value = "0";
        user_string += cell_value;
    }
    console.log(user_string);
    return user_string;
}


function fill_board_with_solution() {
    for (i = 1; i <= 81; i++) {
        cell = $('#' + i + ' input');
        value = $("#solution_string").text().charAt(i - 1);
        cell.val(value);
        console.log(cell.val(value));
    }
}
