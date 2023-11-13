import { Controller } from "@hotwired/stimulus";

const TYPE = {
  INACTIVE: "INACTIVE",
  ACTIVE: "ACTIVE",
};

const seats = document.querySelectorAll(".row .seat");

export default class extends Controller {
  static targets = [
    "seat",
    "inputNumberOfSeats",
    "inputInactive",
    "structureData",
    "inputRowSize",
    "inputColumnSize",
  ];
  static values = {
    structure: Array,
    numberOfSeats: Number,
    active: Array,
    inactive: Array,
    id: Number,
    structure: Array,
  };

  connect() {
    renderUI(this.structureValue);
  }

  createStructure(event) {
    event.preventDefault();

    let rowSize = $(this.inputRowSizeTarget).val(),
      columnSize = $(this.inputColumnSizeTarget).val();

    const formData = {
      room: {
        name: $("#room_name").val(),
        cinema_id: $("#room_cinema_id").val(),
        number_of_seats: $("#room_number_of_seats").val(),
        row_size: rowSize,
        column_size: columnSize,
      },
    };

    let inactiveValue = this.inactiveValue;
    if (this.idValue) {
      $.ajax({
        url: "/admin/rooms/" + this.idValue,
        type: "PUT",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
        data: formData,
        success: function (response) {
          window.location = "/admin/rooms";
        },
        error: function (error) {
          console.error("Lỗi khi gửi Ajax: ", error);
        },
      });
    } else {
      $("#loading").toggle("hidden");
      $.ajax({
        url: "/admin/rooms",
        type: "POST",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
        data: formData,
        success: function (response) {
          createStructureRecords(
            response.room_id,
            inactiveValue,
            rowSize,
            columnSize
          );
        },
        error: function (error) {
          $("#loading").toggle("hidden");
          console.error("Lỗi khi gửi Ajax: ", error);
        },
      });
    }
  }

  toggleActive(event) {
    event.target.classList.toggle("active");
    let tempArray = this.inactiveValue;
    let row = parseInt(event.target.getAttribute("row-index"));
    let column = parseInt(event.target.getAttribute("column-index"));
    let checkType = event.target.classList.contains("active");

    if (checkType) {
      if (checkExist(tempArray, row, column, TYPE.INACTIVE)) {
        tempArray = tempArray.filter(
          (e) => !(e.row_index == row && e.column_index == column)
        );
      }
      this.numberOfSeatsValue += 1;
    } else {
      if (!checkExist(tempArray, row, column, TYPE.INACTIVE))
        tempArray.push({
          row_index: row,
          column_index: column,
          type_seat: TYPE.INACTIVE,
        });
      this.numberOfSeatsValue -= 1;
    }
    this.inactiveValue = tempArray;

    this.inputNumberOfSeatsTarget.value = this.numberOfSeatsValue;

    let structureId = event.target.getAttribute("id");

    if (this.idValue) {
      $.ajax({
        url: `/admin/rooms/${this.idValue}`,
        type: "PUT",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
        data: {
          room: {
            number_of_seats: this.numberOfSeatsValue,
          },
        },
        success: function (response) {
          updateStructureRecords(structureId, checkType);
        },
        error: function (error) {
          console.error("Lỗi khi gửi Ajax: ", error);
        },
      });
    }
  }

  setSize(e) {
    e.preventDefault();

    let rowSize = $(this.inputRowSizeTarget).val(),
      columnSize = $(this.inputColumnSizeTarget).val();
    let numberOfSeats = rowSize * columnSize;

    this.inactiveValue = [];
    this.numberOfSeatsValue = numberOfSeats;

    $("#room_number_of_seats").val(numberOfSeats);

    $("#structure").empty();

    for (var i = 0; i < rowSize; i++) {
      const row = $("<div>").addClass("row justify-center");
      for (var j = 0; j < columnSize; j++) {
        const column = $("<div>").addClass("seat active");
        column.attr({
          "row-index": i,
          "column-index": j,
          "data-action": "click->structure#toggleActive",
          "data-structure-target": "seat",
        });
        row.append(column);
      }
      $("#structure").append(row);
    }
  }
}

function updateStructureRecords(id, checkType) {
  $.ajax({
    url: "/admin/structure_of_rooms/" + id,
    type: "PUT",
    headers: {
      "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
    },
    data: {
      structure_of_room: {
        type_seat: checkType ? "ACTIVE" : "INACTIVE",
      },
    },
    success: function (response) {},
    error: function (error) {
      console.error("Lỗi khi gửi Ajax: ", error);
    },
  });
}

function renderUI(structureValue) {
  if (structureValue != null && structureValue.length > 0) {
    seats.forEach((seat) => {
      let row = seat.getAttribute("row-index");
      let column = seat.getAttribute("column-index");

      structureValue.forEach((element) => {
        if (element.row_index == row && element.column_index == column) {
          seat.setAttribute("id", element.id);
        }
      });

      if (checkExist(structureValue, row, column, TYPE.INACTIVE)) {
        seat.classList.remove("active");
      }
    });
  }
}

function checkExist(element, rowIndex, columnIndex, typeSeat) {
  return (
    element.findIndex(
      (e) =>
        e.row_index == rowIndex &&
        e.column_index == columnIndex &&
        e.type_seat == typeSeat
    ) > -1
  );
}

function createStructureRecords(roomId, inactiveValue, rowSize, columnSize) {
  for (var i = 0; i < rowSize; i++) {
    for (var j = 0; j < columnSize; j++) {
      var type =
        inactiveValue.findIndex(
          (item) => item.row_index == i && item.column_index == j
        ) == -1
          ? "ACTIVE"
          : "INACTIVE";
      var seat = {
        row_index: i,
        column_index: j,
        type_seat: type,
      };

      createStructureRecord(roomId, seat);
    }
  }
}

function createStructureRecord(roomId, seat) {
  $.ajax({
    url: "/admin/structure_of_rooms",
    type: "POST",
    headers: {
      "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
    },
    data: { structure_of_room: { ...seat, room_id: roomId } },
    success: function (response) {
      window.location = "/admin/rooms";
    },
    error: function (error) {
      console.error("Lỗi khi gửi Ajax: ", error);
    },
  });
}
