import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [
    "filter",
    "searchTerm",
    "movieFilter",
    "roomFilter",
    "locationFilter",
    "statusFilter",
    "cinemaFilter",
  ];

  static values = {
    filter: Object,
    controllerName: String,
  };

  search(e) {
    e.preventDefault();

    let filter = this.filterValue;

    this.filterTargets.forEach((target) => {
      let searchType = $(target).attr("data-search-type");
      let searchValue = $(target).val() || "";
      filter[searchType] = searchValue;
    });

    this.fetchData(filter);
  }

  clear(e) {
    e.preventDefault();

    let filter = this.filterValue;
    this.filterTargets.forEach((target) => {
      $(target).val("");
      let searchType = $(target).attr("data-search-type");
      let searchValue = "";
      filter[searchType] = searchValue;
    });

    this.fetchData(filter);
  }

  fetchData(filter) {
    const formData = new FormData();
    Object.keys(filter).forEach((type) => {
      formData.append(type, filter[type]);
    });
    let _this = this;

    $.ajax({
      url: `/admin/${this.controllerNameValue}/search`,
      type: "GET",
      data: filter,
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
      },
      success: function (data) {
        let target_html = `${_this.controllerNameValue}_html`;

        $(`#${_this.controllerNameValue}`).html(data[target_html]);
        $("#pagination").html(data.pagination_html);
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  }
}
