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
    var input = cell.value
    switch (input) {
        case "1":
            $(cell).css("background-color", "#62cec7");
            break;
        case "2":
            $(cell).css("background-color", "#83c6e2");
            break;
        case "3":
            $(cell).css("background-color", "#2fc8d3");
            break;
        case "4":
            $(cell).css("background-color", "#588eaf");
            break;
        case "5":
            $(cell).css("background-color", "#4b9eb1");
            break;
        case "6":
            $(cell).css("background-color", "#309fce");
            break;
        case "7":
            $(cell).css("background-color", "#a3e6e3");
            break;
        case "8":
            $(cell).css("background-color", "#8cb1c8");
            break;
        case "9":
            $(cell).css("background-color", "#2996e8");
            break;
        default:
            $(cell).css("background-color", "white");
            break;
    }
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
        var cell = $('#' + i + ' input');
        $setCell = cell;
        value = $("#solution_string").text().charAt(i - 1);
        $setCell.val(value);
        cell.value = value;
        colorCell(cell);
    }
}
