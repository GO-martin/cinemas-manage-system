import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="booking"
export default class extends Controller {
  static values = {
    roomId: Number,
    selected: Array,
    price: Number,
    seatCoordinates: Object,
    selectedSupply: Object,
    selectedSeat: Object,
    totalPrice: Number,
    showtimeId: Number,
  };

  connect() {
    this.fetchStructure();
  }

  loadPayment() {
    if ($("#payment-form").length) {
      this.renderDetailTable();
      this.renderStripe();
    }
  }

  renderDetailTable() {
    $(".payment-seat-name").html(`${this.selectedValue[0].seat_name}`);
    $(".payment-seat-price").html(`${this.priceValue} VND`);

    const detailTableBody = $("#detail-table-body");
    if (Object.keys(this.selectedSupplyValue).length > 0) {
      for (const id in this.selectedSupplyValue) {
        const trSupplies = $("<tr>").addClass("hover_bg-gray-100");
        trSupplies.html(`
        <td class="p-4 text-base font-medium text-gray-900 whitespace-nowrap">
          Supply
        </td>
        <td class="p-4 text-base font-medium text-gray-900 whitespace-wrap">
          ${this.selectedSupplyValue[id].name}
        </td>
        <td class="p-4 text-base font-medium text-gray-900 whitespace-nowrap">
          ${
            this.selectedSupplyValue[id].quantity *
            this.selectedSupplyValue[id].price
          } VND
        </td>
        `);
        detailTableBody.append(trSupplies);
      }
    }

    $("#payment-total-price").html(`${this.totalPriceValue} VND`);
  }

  renderStripe() {
    var stripe = Stripe($("#payment-form").attr("data-public-key"));

    var elements = stripe.elements();

    var cardElement = elements.create("card", {
      style: {
        base: {
          iconColor: "#cccccc",
          color: "#000000",
          fontWeight: "500",
          fontFamily: "Roboto, Open Sans, Segoe UI, sans-serif",
          fontSize: "16px",
          fontSmoothing: "antialiased",
          ":-webkit-autofill": {
            color: "#ccc",
          },
          "::placeholder": {
            color: "#ccc",
          },
        },
        invalid: {
          iconColor: "#FFC7EE",
          color: "#A31621",
        },
      },
    });

    cardElement.mount("#payment-element");

    const submitBtn = $("#payment-submit");

    var totalPriceValue = this.totalPriceValue;

    var ticketData = {
      ticket: {
        seat_row: this.selectedValue[0].row_index,
        seat_column: this.selectedValue[0].column_index,
        price: this.totalPriceValue,
        user_id: $("#payment-form").attr("data-user-id"),
        showtime_id: this.showtimeIdValue,
        seat_name: this.selectedValue[0].seat_name,
      },
    };

    let _this = this;

    submitBtn.on("click", function (e) {
      e.preventDefault();

      _this.setLoading(true);

      fetch("/payment_intents", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
        body: JSON.stringify({
          amount: totalPriceValue,
          currency: "vnd",
        }),
      })
        .then((response) => response.json())
        .then((paymentIntent) => {
          stripe
            .confirmCardPayment(paymentIntent.client_secret, {
              payment_method: {
                card: cardElement,
              },
            })
            .then((resp) => {
              if (resp.error) {
                alert(resp.error.message);
              } else {
                ticketData["ticket"]["stripe_payment_id"] = paymentIntent.id;
                _this.createTicket(ticketData);
              }
            });
        })
        .catch((error) => {
          console.error("Error: ", error);
        });

      _this.setLoading(false);
    });
  }

  setLoading(isLoading) {
    if (isLoading) {
      document.querySelector("#payment-submit").disabled = true;
      document.querySelector("#spinner").classList.remove("hidden");
      document.querySelector("#button-text").classList.add("hidden");
    } else {
      document.querySelector("#payment-submit").disabled = false;
      document.querySelector("#spinner").classList.add("hidden");
      document.querySelector("#button-text").classList.remove("hidden");
    }
  }

  async createTicket(ticketData) {
    try {
      const response = await fetch("/customer/tickets", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
        body: JSON.stringify(ticketData),
      });

      const result = await response.json();

      if (Object.keys(this.selectedSupplyValue).length > 0) {
        this.createTicketSupplies(result.ticket_id);
      }
    } catch (error) {
      console.error("Error: ", error);
    }
  }

  createTicketSupplies(ticketId) {
    for (const id in this.selectedSupplyValue) {
      var data = {
        ticket_supply: {
          ticket_id: ticketId,
          supply_id: id,
          quantity: this.selectedSupplyValue[id].quantity,
        },
      };
      this.createTicketSupply(data);
    }
  }

  async createTicketSupply(data) {
    await fetch("/customer/ticket_supplies", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
      },
      body: JSON.stringify(data),
    });

    window.location = "/";
  }

  fetchStructure() {
    fetch(
      `/customer/rooms/${this.roomIdValue}?showtime_id=${this.showtimeIdValue}`,
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
        $("#room").html(res);
      })
      .catch((error) => console.error("Error: ", error));
  }

  selectSeat(e) {
    if (!e.target.classList.contains("sold")) {
      let seat = e.currentTarget;
      let row_index = parseInt(seat.getAttribute("row-index")),
        column_index = parseInt(seat.getAttribute("column-index")),
        selectedArray = this.selectedValue;

      if (!seat.classList.contains("selected")) {
        if (selectedArray.length == 1) {
          alert("You can only choose 1 seat");
        } else {
          seat.classList.add("selected");

          selectedArray.push({
            row_index,
            column_index,
            seat_name: seat.textContent,
          });
          this.updateSeat(this.priceValue, seat, row_index, column_index);
        }
      } else {
        seat.classList.remove("selected");
        selectedArray.pop();
        this.updateSeat(-this.priceValue);
      }

      this.selectedValue = selectedArray;
      this.updateTotal();
    }
  }

  updateTotal() {
    this.totalPriceValue = this.selectedValue.length * this.priceValue;
    $("#total-price").html(this.totalPriceValue);
  }

  updateSeat(price, seat, row_index, column_index) {
    let originalSeatPrice = parseInt($("#seat-price").text());
    let updateSeatPrice = originalSeatPrice + price;
    if (seat) {
      this.seatCoordinates = { row_index, column_index };
      $("#seat").html(seat.textContent);
      $("#seat-price").html(updateSeatPrice);
    } else {
      this.seatCoordinates = {};
      $("#seat").empty();
      $("#seat-price").html(updateSeatPrice);
    }
  }

  checkSelectedSeat(e) {
    if (!this.selectedValue.length) {
      e.preventDefault();
      alert("Please choose your seats first");
    }
    let obj = $(e.currentTarget);

    if (!obj.hasClass("supply")) {
      obj.addClass("supply");
      obj.children("span").html("Payment");
    } else {
      obj.attr("href", "/customer/tickets/new");
      obj.addClass("hidden");
    }
  }

  minusSupply(e) {
    let obj = $(e.currentTarget);

    let input = parseInt($("#supply-" + obj.attr("supply-id")).val());

    if (input >= 1) {
      input -= 1;
      $("#supply-" + obj.attr("supply-id")).val(input);

      if (input == 0) {
        let selectedSupply = this.selectedSupplyValue;
        delete selectedSupply[parseInt(obj.attr("supply-id"))];
        this.selectedSupplyValue = selectedSupply;
      } else {
        this.updateSelectedSupply(
          parseInt(obj.attr("supply-id")),
          obj.attr("supply-name"),
          input,
          parseInt(obj.attr("supply-price"))
        );
      }
      this.updateSupplyPrice(-parseInt(obj.attr("supply-price")));
    }
  }

  plusSupply(e) {
    let obj = $(e.currentTarget);

    let input = parseInt($("#supply-" + obj.attr("supply-id")).val());

    input += 1;

    $("#supply-" + obj.attr("supply-id")).val(input);

    this.updateSelectedSupply(
      parseInt(obj.attr("supply-id")),
      obj.attr("supply-name"),
      input,
      parseInt(obj.attr("supply-price"))
    );
    this.updateSupplyPrice(parseInt(obj.attr("supply-price")));
  }

  updateSupplyPrice(price) {
    let originalSupplyPrice = parseInt($("#supply-price").text());
    let updateSupplyPrice = originalSupplyPrice + price;
    this.totalPriceValue += price;
    $("#supply-price").html(updateSupplyPrice);
    $("#total-price").html(this.totalPriceValue);
  }

  updateSelectedSupply(id, name, quantity, price) {
    let selectedSupply = this.selectedSupplyValue;

    selectedSupply[id] = {
      id,
      name,
      quantity,
      price,
    };

    this.selectedSupplyValue = selectedSupply;
  }
}
