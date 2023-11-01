import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    movieId: Number,
  };
  connect() {
    renderUI();
  }

  fetchShowtimes(e) {
    e.preventDefault();

    let dateValue = e.currentTarget.getAttribute("date-value");

    const collateralTabs = document.getElementById("collateral-tabs");

    collateralTabs.innerHTML = "";

    fetch(
      `/pages/${this.movieIdValue}/booking/showtimes?selected_date=${dateValue}`,
      {
        contentType: "application/json",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
      }
    )
      .then((response) => response.text())
      .then((res) => {
        $("#collateral-tabs").html(res);
      })
      .catch((error) => console.error("Error: ", error));
  }
}

function renderUI() {
  let selectedCard = null;
  $(".date-card").click(function () {
    if (selectedCard) {
      changeBackgroundColor(selectedCard, "bg-blue-200", "bg-white");
    }
    changeBackgroundColor($(this), "bg-white", "bg-blue-200");
    selectedCard = $(this);
  });
}

function changeBackgroundColor(element, originalColor, transformColor) {
  element.removeClass(originalColor);
  element.addClass(transformColor);
}
