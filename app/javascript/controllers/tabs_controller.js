import { Controller } from "@hotwired/stimulus";

const ATTRIBUTES = {
  ACTIVE: ["text-white", "bg-blue-600"],
  INACTIVE: ["hover_text-gray-900", "hover_bg-gray-100"],
  HIDDEN: "hidden",
};

export default class extends Controller {
  static targets = ["tabLink", "tabContent"];

  connect() {
    const firstTabLink = this.tabLinkTargets[0],
      firstTabLinkId = firstTabLink.id,
      firstTabContentId = firstTabLink.getAttribute("tab-content-id");
    this.setActiveTabLink(firstTabLinkId);
    this.showTabContent(firstTabContentId);
  }

  showTab(e) {
    e.preventDefault();
    const tabLinkId = e.target.id;
    const tabContentId = e.target.getAttribute("tab-content-id");

    this.setActiveTabLink(tabLinkId);
    this.hideTabs();
    this.showTabContent(tabContentId);
  }

  hideTabs() {
    this.tabContentTargets.forEach((tabContent) => {
      tabContent.classList.add(ATTRIBUTES.HIDDEN);
    });
  }

  showTabContent(id) {
    const activeTab = this.tabContentTargets.find(
      (tabContent) => tabContent.id == id
    );
    activeTab.classList.remove(ATTRIBUTES.HIDDEN);
  }

  setActiveTabLink(id) {
    this.tabLinkTargets.forEach((tabLink) => {
      if (tabLink.id === id) {
        this.addMultipleAttributes(tabLink.classList, ATTRIBUTES.ACTIVE);
      } else {
        this.removeMultipleAttributes(tabLink.classList, ATTRIBUTES.ACTIVE);
        this.addMultipleAttributes(tabLink.classList, ATTRIBUTES.INACTIVE);
      }
    });
  }

  addMultipleAttributes(element, attributes) {
    attributes.forEach((attribute) => element.add(attribute));
  }

  removeMultipleAttributes(element, attributes) {
    attributes.forEach((attribute) => element.remove(attribute));
  }
}
