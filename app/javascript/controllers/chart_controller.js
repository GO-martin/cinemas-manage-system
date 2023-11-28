import { Controller } from "@hotwired/stimulus";
import ApexCharts from "apexcharts";
// Connects to data-controller="chart"
export default class extends Controller {
  static values = {
    mainChart: Object,
    newCustomersChart: Object,
    newTicketsChart: Object,
    locationChart: Object,
  };

  connect() {
    this.renderUI();
  }

  renderUI() {
    this.renderMainChart();
    this.renderNewCustomersChart();
    this.renderNewTicketsChart();
    this.renderLocationChart();
  }

  getMainChartOptions(values, dates) {
    let mainChartColors = {
      borderColor: "#F3F4F6",
      labelColor: "#6B7280",
      opacityFrom: 0.45,
      opacityTo: 0,
    };

    return {
      chart: {
        height: 420,
        type: "area",
        fontFamily: "Inter, sans-serif",
        foreColor: mainChartColors.labelColor,
        toolbar: {
          show: false,
        },
      },
      fill: {
        type: "gradient",
        gradient: {
          enabled: true,
          opacityFrom: mainChartColors.opacityFrom,
          opacityTo: mainChartColors.opacityTo,
        },
      },
      dataLabels: {
        enabled: false,
      },
      tooltip: {
        style: {
          fontSize: "14px",
          fontFamily: "Inter, sans-serif",
        },
      },
      grid: {
        show: true,
        borderColor: mainChartColors.borderColor,
        strokeDashArray: 1,
        padding: {
          left: 35,
          bottom: 15,
        },
      },
      series: [
        {
          name: "Revenue",
          data: values,
          color: "#1A56DB",
        },
      ],
      markers: {
        size: 5,
        strokeColors: "#ffffff",
        hover: {
          size: undefined,
          sizeOffset: 3,
        },
      },
      xaxis: {
        categories: dates,
        labels: {
          style: {
            colors: [mainChartColors.labelColor],
            fontSize: "14px",
            fontWeight: 500,
          },
        },
        axisBorder: {
          color: mainChartColors.borderColor,
        },
        axisTicks: {
          color: mainChartColors.borderColor,
        },
        crosshairs: {
          show: true,
          position: "back",
          stroke: {
            color: mainChartColors.borderColor,
            width: 1,
            dashArray: 10,
          },
        },
      },
      yaxis: {
        labels: {
          style: {
            colors: [mainChartColors.labelColor],
            fontSize: "14px",
            fontWeight: 500,
          },
          formatter: function (value) {
            return `${value} VND`;
          },
        },
      },
      legend: {
        fontSize: "14px",
        fontWeight: 500,
        fontFamily: "Inter, sans-serif",
        labels: {
          colors: [mainChartColors.labelColor],
        },
        itemMargin: {
          horizontal: 10,
        },
      },
      responsive: [
        {
          breakpoint: 1024,
          options: {
            xaxis: {
              labels: {
                show: false,
              },
            },
          },
        },
      ],
    };
  }

  renderMainChart() {
    var { current_main_chart_data } = this.mainChartValue;

    var { dates, values } = this.formatObject(current_main_chart_data);

    const chart = new ApexCharts(
      document.getElementById("main-chart"),
      this.getMainChartOptions(values, dates)
    );
    chart.render();

    let _this = this;

    $(".main-chart-dropdown-button").on("click", async function (e) {
      e.preventDefault();
      let obj = $(e.currentTarget),
        period = obj.attr("data-filter"),
        type = obj.attr("data-type");

      var content = await fetch(
        `/admin/dashboards/update_main_chart?period=${period}`,
        {
          headers: {
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
              .content,
          },
        }
      );

      var response = await content.json();
      var main_chart_data = response.main_chart_data,
        { current_main_chart_data } = main_chart_data;

      var { dates, values } = _this.formatObject(current_main_chart_data);

      $("#main-chart-total-revenue").next().html(`Sales last ${period} days`);

      $("#main-chart-button")
        .children("span")
        .html(type == "today" ? "Today" : `Last ${period} days`);

      $("#main-chart-total-revenue").html(
        `${main_chart_data.total_revenue} VND`
      );

      chart.updateOptions(_this.getMainChartOptions(values, dates));
    });
  }

  formatObject(obj) {
    var dates = Object.keys(obj).map((key) => {
      var date = new Date(key),
        day = date.getDate(),
        month = date.getMonth() + 1;
      return `${day}/${month}`;
    });

    var values = Object.values(obj);

    return { dates, values };
  }

  renderLocationChart() {
    var { current_location_chart_data } = this.locationChartValue;
    const chart = new ApexCharts(
      document.getElementById("location-chart"),
      this.getLocationChartOptions(current_location_chart_data)
    );
    chart.render();

    let _this = this;
    $(".location-chart-dropdown-button").on("click", async function (e) {
      e.preventDefault();

      let obj = $(e.currentTarget),
        period = obj.attr("data-filter"),
        type = obj.attr("data-type");

      var content = await fetch(
        `/admin/dashboards/update_location_chart?period=${period}`,
        {
          headers: {
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
              .content,
          },
        }
      );

      var response = await content.json();
      var location_chart_data = response.location_chart_data,
        { current_location_chart_data } = location_chart_data;

      $("#location-chart-name").next().html(`Sales last ${period} days`);

      $("#location-chart-button")
        .children("span")
        .html(type == "today" ? "Today" : `Last ${period} days`);

      chart.updateOptions(
        _this.getLocationChartOptions(current_location_chart_data)
      );
    });
  }

  getLocationChartOptions(object) {
    return {
      labels: object.map((i) => i.name),
      series: object.map((i) => i["total_price"]),
      chart: {
        type: "pie",
        height: 400,
        fontFamily: "Inter, sans-serif",
      },
      responsive: [
        {
          breakpoint: 430,
          options: {
            chart: {
              height: 300,
            },
          },
        },
      ],
      stroke: {
        colors: "#ffffff",
      },
      states: {
        hover: {
          filter: {
            type: "darken",
            value: 0.9,
          },
        },
      },
      tooltip: {
        shared: true,
        followCursor: false,
        fillSeriesColor: false,
        inverseOrder: true,
        style: {
          fontSize: "14px",
          fontFamily: "Inter, sans-serif",
        },
        x: {
          show: true,
          formatter: function (_, { seriesIndex, w }) {
            const label = w.config.labels[seriesIndex];
            return label;
          },
        },
        y: {
          formatter: function (value) {
            return value + " VND";
          },
        },
      },
      grid: {
        show: false,
      },
    };
  }

  renderNewCustomersChart() {
    var { current_data } = this.newCustomersChartValue;

    var data = this.formatNewGeneralObject(current_data);

    const chart = new ApexCharts(
      document.getElementById("new-customers-chart"),
      this.getNewGeneralChartOptions(data, "User")
    );
    chart.render();
  }

  formatNewGeneralObject(obj) {
    let newArray = [];
    Object.keys(obj).forEach((key) => {
      var date = new Date(key),
        day = date.getDate(),
        month = date.getMonth() + 1;
      newArray.push({ x: `${day}/${month}`, y: obj[key] });
    });
    return newArray;
  }

  getNewGeneralChartOptions(data, name) {
    return {
      colors: ["#1A56DB", "#FDBA8C"],
      series: [
        {
          name: name,
          color: "#1A56DB",
          data,
        },
      ],
      chart: {
        type: "bar",
        height: "140px",
        fontFamily: "Inter, sans-serif",
        foreColor: "#4B5563",
        toolbar: {
          show: false,
        },
      },
      plotOptions: {
        bar: {
          columnWidth: "90%",
          borderRadius: 3,
        },
      },
      tooltip: {
        shared: false,
        intersect: false,
        style: {
          fontSize: "14px",
          fontFamily: "Inter, sans-serif",
        },
      },
      states: {
        hover: {
          filter: {
            type: "darken",
            value: 1,
          },
        },
      },
      stroke: {
        show: true,
        width: 5,
        colors: ["transparent"],
      },
      grid: {
        show: false,
      },
      dataLabels: {
        enabled: false,
      },
      legend: {
        show: false,
      },
      xaxis: {
        floating: false,
        labels: {
          show: false,
        },
        axisBorder: {
          show: false,
        },
        axisTicks: {
          show: false,
        },
      },
      yaxis: {
        show: false,
      },
      fill: {
        opacity: 1,
      },
    };
  }

  updateStatsData(e) {
    e.preventDefault();

    let obj = $(e.currentTarget),
      period = obj.attr("data-filter");

    fetch(`/admin/dashboards/update_stats?period=${period}`, {
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
      },
    })
      .then((response) => response.json())
      .then((res) => {
        $("#top-movies").html(res.top_movies_html);
        $("#top-customers").html(res.top_customers_html);

        $("#stats-text").html(`Statistics last ${period} days`);
        $("#stats-button")
          .children("span")
          .html(period == "1" ? "Today" : `Last ${period} days`);
      });
  }

  renderNewTicketsChart() {
    var { current_data } = this.newTicketsChartValue;

    var data = this.formatNewGeneralObject(current_data);

    const chart = new ApexCharts(
      document.getElementById("new-tickets-chart"),
      this.getNewGeneralChartOptions(data, "Tickets")
    );
    chart.render();
  }
}
