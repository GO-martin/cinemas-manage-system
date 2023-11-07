import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["filter", "searchTerm", "movieFilter", "roomFilter"];

  static values = {
    filter: Object,
  };

  connect() {
    console.log("connect search");
  }

  search(e) {
    e.preventDefault();

    var filter = this.filterValue;
    this.filterTargets.forEach((target) => {
      var searchType = $(target).attr("data-search-type");
      var searchValue = $(target).val() || "";
      filter[searchType] = searchValue;
    });

    this.fetchData(filter);
  }

  clear(e) {
    e.preventDefault();

    this.filterTargets.forEach((target) => {
      $(target).val("");
    });

    this.fetchData();
  }

  fetchData(filter) {
    const formData = new FormData();
    formData.append("searchTerm", filter?.searchTerm || "");
    formData.append("movieFilter", filter?.movieFilter || "");
    formData.append("roomFilter", filter?.roomFilter || "");

    fetch(`/admin/tickets/search`, {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
      },
    })
      .then((response) => response.json())
      .then((res) => {
        $("#tickets").html(res.tickets_html);
        $("#pagination").html(res.pagination_html);
      });
  }
}
