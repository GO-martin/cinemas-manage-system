import { Controller } from "@hotwired/stimulus";

const DEFAULT_STRUCTURE = [
  [1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1, 1, 1],
];

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

    const formData = {
      room: {
        name: $("#room_name").val(),
        cinema_id: $("#room_cinema_id").val(),
        number_of_seats: $("#room_number_of_seats").val(),
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
          console.log("Lỗi khi gửi Ajax: ", error);
        },
      });
    } else {
      $.ajax({
        url: "/admin/rooms",
        type: "POST",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
        data: formData,
        success: function (response) {
          createStructureRecords(response.room_id, inactiveValue);
        },
        error: function (error) {
          console.log("Lỗi khi gửi Ajax: ", error);
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
          console.log("Lỗi khi gửi Ajax: ", error);
        },
      });
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
      console.log("Lỗi khi gửi Ajax: ", error);
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

function createStructureRecords(roomId, inactiveValue) {
  let value = DEFAULT_STRUCTURE;
  let data = [];

  inactiveValue.forEach((seat) => {
    value[seat.row_index][seat.column_index] = 0;
  });

  value.forEach((row, rowIndex) => {
    row.forEach((seat, columnIndex) => {
      data.push({
        row_index: rowIndex,
        column_index: columnIndex,
        type_seat: seat == 1 ? "ACTIVE" : "INACTIVE",
      });
    });
  });

  data.forEach((seat) => {
    createStructureRecord(roomId, seat);
  });
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
      console.log("Lỗi khi gửi Ajax: ", error);
    },
  });
}
