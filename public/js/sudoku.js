window.onload = function() {
    if (document.getElementById("solution_string")) {
        fill_board_with_solution();
    }
    $(".table_cell").each(function() {
        $input_field = $(this).children()[0];
        $input_field.onfocus = function() {
            this.select();
        };
        $input_field.onkeyup = advanceCell;

    });
};

function advanceCell() {
    $cell = this;
    colorCell($cell);
    var next_cell = parseInt(this.parentNode.id) + 1;
    if (next_cell <= 81) {
        $("#" + next_cell).children()[0].select();
    }
}
function colorCell(cell) {
    console.log(cell);
    $(cell).css("background-color", "blue");
}

function go() {
    var string = make_string();
    window.location.href = "/" + string;
}

function make_string() {
    user_string = "";
    for (i = 1; i <= 81; i++) {
        cell_value = $('#' + i + ' input').val();
        if (cell_value === "")
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
